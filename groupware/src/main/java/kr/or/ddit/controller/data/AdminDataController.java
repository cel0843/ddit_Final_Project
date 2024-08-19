package kr.or.ddit.controller.data;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import kr.or.ddit.service.data.IDataService;
import kr.or.ddit.util.MediaUtils;
import kr.or.ddit.util.ServiceResult;
import kr.or.ddit.vo.AttachFileVO;
import kr.or.ddit.vo.CustomEmployeeVO;
import kr.or.ddit.vo.CustomFileVO;
import kr.or.ddit.vo.CustomUser;
import kr.or.ddit.vo.DataVO;
import kr.or.ddit.vo.EmployeeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin")
public class AdminDataController {

    @Inject
    private IDataService service;
    
    private static final String resourcePath = "C:/groupware_file_upload/upload_files/data";

    
//공용자료실
    @PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
    @RequestMapping(value = "/adminDataMain", method = RequestMethod.GET)
    public String commonDataMain(
    		@RequestParam(value="searchType",required=false,defaultValue="") String searchType,
    		@RequestParam(value="searchExtension",required=false,defaultValue="") String searchExtension,
    		@RequestParam(value="keyword",required=false,defaultValue="") String keyword,
    		DataVO dataVO, Model model) {
    	
    	log.info("공용자료실 메인 실행()");
    	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    	Object principal = authentication.getPrincipal();
    	String emplId = "";
    	
    	
    	if (principal instanceof UserDetails) {
    		UserDetails userDetails = (UserDetails) principal;
    		emplId = userDetails.getUsername();
    	} else {
    		log.info("UserDetails 정보가 없습니다.");
    		return "redirect:/login";
    	}
    	
    	Map<String,Object> map = new HashMap<String, Object>();
    	map.put("searchType", searchType);
    	map.put("searchExtension", searchExtension);
    	map.put("keyword", keyword);
    	List<DataVO> dataList = service.selectCommonDataList(emplId);
    	List<DataVO> allFileList = service.selectCommonAllfileList(emplId);
//    	Map<String, Object> totalUsage = service.selectTotalUsage(emplId);
//        Map<String, Object> percent = service.getPercent(emplId);
    	
    	
    	
    	model.addAttribute("dataList", dataList);
    	model.addAttribute("allFileList", allFileList);
//    	model.addAttribute("totalUsage", totalUsage);
//    	log.info("totalUsage:"+ totalUsage);
    	
    	return "admin/data/adminDataDirectory";
    }
    
    @PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@RequestMapping(value = "/adminFileupload", method = RequestMethod.POST)
	public String cFileupload(HttpServletRequest req, @RequestParam(value="fileGroupNo", defaultValue = "0") int fileGroupNo, int fldNo,  @RequestParam("file") MultipartFile[] files, Model model) throws Exception {
		String goPage = "";
		DataVO filegroupNoUpdateDataVO = null;
		int fgn0 = service.getFgn0(fldNo);
		// fldNo를 이용해서 file_group_no를 구한다.
		if(fileGroupNo==0) {
    		fileGroupNo = service.getNextFileGroupNo(); // 시퀀스를 통해 다음 파일 그룹 번호를 가져옵니다
    		filegroupNoUpdateDataVO = new DataVO();
    		filegroupNoUpdateDataVO.setFldNo(fldNo);
    		filegroupNoUpdateDataVO.setFileGroupNo(fileGroupNo);
    	}
		// 만약 fil_group_no가 0이면 
		// "getNextFileGroupNo"를 실행하여 file_group_no 를 구한다.
		log.info("@@@@@@@@@@@@@@fileGroupNo:",fileGroupNo);
		log.info("@@@@@@@@@@@@@@fldNo:",fldNo);
		filegroupNoUpdateDataVO = new DataVO();
		filegroupNoUpdateDataVO.setFldNo(fldNo);
		filegroupNoUpdateDataVO.setFileGroupNo(fileGroupNo);
		
		
		
		for (int i = 0; i < files.length; i++) {
			MultipartFile file = files[i];
			AttachFileVO fileVO = new AttachFileVO(file);
			// 파일이 비어있는지 확인
			if (file.isEmpty()) {
				return "파일을 선택해주세요.";
			}
			
			// 파일 저장 로직
			String originalFilename = file.getOriginalFilename();
			String uuid = UUID.randomUUID().toString();
			String fileStrgNm = uuid + "_" + originalFilename;
			String filePath = resourcePath + fileStrgNm;
			
			log.info("@@@ 파일경로 : " + resourcePath);
			log.info("@@@ 저장경로 : " + filePath);
			
			File dest = new File(filePath);
			if (!dest.getParentFile().exists()) {
				dest.getParentFile().mkdirs();
			}
			file.transferTo(dest);
//	 List<AttachFileVO> fileList = service.selectFileList(fileGroupNo);
//	if(fileList != null) {
//		
//	}
			// 파일 번호는 각 파일마다 1씩 증가
			int fileNo = service.getNextFileNo(fileGroupNo);
			
			// 파일 정보 설정
			fileVO.setFileGroupNo(fileGroupNo);
			fileVO.setFileNo(fileNo);
			fileVO.setFilePath(filePath);
			fileVO.setFileStrgNm(fileStrgNm);
			fileVO.setFileCtrDt(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
			fileVO.setFileDelYn("N");
			
			// 데이터베이스에 파일 정보 저장
			service.uploadFolderFile(req, fileVO);
			
			goPage = "redirect:/admin/adminFileList?fileGroupNo="+fileGroupNo+"&fldNo="+fldNo;
		}

		if(filegroupNoUpdateDataVO!=null) {
			// update  작업...
			service.filegroupNoUpdate(filegroupNoUpdateDataVO);
		}
		
		return goPage;
		}
    
    
    @PreAuthorize("hasAnyRole('ROLE_ADMIN')")
    @RequestMapping(value = "/adminFolderFileupload", method = RequestMethod.POST)
    public String cFolderFileupload(HttpServletRequest req, @RequestParam(value="fileGroupNo", defaultValue = "0") int fileGroupNo, int fldNo,  @RequestParam("file") MultipartFile[] files, Model model) throws Exception {
    	String goPage = "";
    	DataVO filegroupNoUpdateDataVO = null;
    	if(fileGroupNo==0) {
    		fileGroupNo = service.getNextFileGroupNo(); // 시퀀스를 통해 다음 파일 그룹 번호를 가져옵니다
    		filegroupNoUpdateDataVO = new DataVO();
    		filegroupNoUpdateDataVO.setFldNo(fldNo);
    		filegroupNoUpdateDataVO.setFileGroupNo(fileGroupNo);
    	}
    	for (int i = 0; i < files.length; i++) {
    		MultipartFile file = files[i];
    		AttachFileVO fileVO = new AttachFileVO(file);
    		// 파일이 비어있는지 확인
    		if (file.isEmpty()) {
    			return "파일을 선택해주세요.";
    		}
    		
    		// 파일 저장 로직
    		String originalFilename = file.getOriginalFilename();
    		String uuid = UUID.randomUUID().toString();
    		String fileStrgNm = uuid + "_" + originalFilename;
    		String filePath = resourcePath + fileStrgNm;
    		
    		log.info("@@@ 파일경로 : " + resourcePath);
    		log.info("@@@ 저장경로 : " + filePath);
    		
    		File dest = new File(filePath);
    		if (!dest.getParentFile().exists()) {
    			dest.getParentFile().mkdirs();
    		}
    		file.transferTo(dest);
//    		 List<AttachFileVO> fileList = service.selectFileList(fileGroupNo);
//    		if(fileList != null) {
//    			
//    		}
    		// 파일 번호는 각 파일마다 1씩 증가
    		int fileNo = service.getNextFileNo(fileGroupNo);
    		
    		// 파일 정보 설정
    		fileVO.setFileGroupNo(fileGroupNo);
    		fileVO.setFileNo(fileNo);
    		fileVO.setFilePath(filePath);
    		fileVO.setFileStrgNm(fileStrgNm);
    		fileVO.setFileCtrDt(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
    		fileVO.setFileDelYn("N");
    		
    		// 데이터베이스에 파일 정보 저장
    		service.uploadFolderFile(req, fileVO);
    		
    		goPage = "redirect:/admin/adminFileList?fileGroupNo="+fileGroupNo+"&fldNo="+fldNo;
    	}
    	
    	if(filegroupNoUpdateDataVO!=null) {
    		// update  작업...
    		service.filegroupNoUpdate(filegroupNoUpdateDataVO);
    	}
    	
    	return goPage;
    }
    
    @PreAuthorize("hasAnyRole('ROLE_ADMIN')")
    @RequestMapping(value = "/createCommonFolder", method = RequestMethod.POST)
    public String createCommonFolder(DataVO dataVO, Model model) {
    	String goPage = "";
    	CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    	CustomEmployeeVO empVO = user.getCustomEmpl();
    	dataVO.setEmplId(empVO.getEmplId());
    	service.createCommonFolder(dataVO);
    	
    	return "redirect:/admin/adminDataMain";
    }
    
    @PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
    @RequestMapping(value = "/adminFileList", method = RequestMethod.GET)
    public String getCFileList(int fileGroupNo, int fldNo,  Model model ) {
    	
    	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    	Object principal = authentication.getPrincipal();
    	String emplId = "";
    	
    	
    	if (principal instanceof UserDetails) {
    		UserDetails userDetails = (UserDetails) principal;
    		emplId = userDetails.getUsername();
    	} else {
    		log.info("UserDetails 정보가 없습니다.");
    		return "redirect:/login";
    	}
    	
    	List<AttachFileVO> fileList = service.selectFileList(fileGroupNo);
    	List<DataVO> dataList = service.selectCommonDataList(emplId);
    	model.addAttribute("fileList", fileList);
    	model.addAttribute("dataList", dataList);
    	model.addAttribute("fldNo", fldNo);
    	return "admin/data/adminFileList";
    }

    @ResponseBody
    @RequestMapping(value = "/commonSearch", method = RequestMethod.POST)
    public List<DataVO> commonSearch(@RequestBody Map<String, Object> param ,  HttpServletRequest request) {
    	String goPage = "";
    	HttpSession session = request.getSession();
    	CustomEmployeeVO emplInfo = (CustomEmployeeVO) session.getAttribute("emplInfo");
    	String emplId = emplInfo.getEmplId();
    	param.put("emplId", emplId);
    	List<DataVO> searchList = service.commonSearch(param);
    	
    	return searchList;
    }
    
    @ResponseBody
    @RequestMapping(value = "/commonFolderSearch", method = RequestMethod.POST)
    public List<DataVO> commonFolderSearch(@RequestBody Map<String, Object> param ,  HttpServletRequest request) {
    	String goPage = "";
    	HttpSession session = request.getSession();
    	CustomEmployeeVO emplInfo = (CustomEmployeeVO) session.getAttribute("emplInfo");
    	String emplId = emplInfo.getEmplId();
    	param.put("emplId", emplId);
    	List<DataVO> searchList = service.commonFolderSearch(param);
    	
    	return searchList;
    }
    
    @PreAuthorize("hasAnyRole('ROLE_ADMIN')")
    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    public String commonDelete(AttachFileVO fileVO ) {
    	 service.fileDelete(fileVO);
    	 return "redirect:/admin/adminDataMain";
    }
    
    @PreAuthorize("hasAnyRole('ROLE_ADMIN')")
    @RequestMapping(value = "/inListDelete", method = RequestMethod.POST)
    public String inListDelete(AttachFileVO fileVO, Model model ) {
    	service.fileDelete(fileVO);
    	int fgn = fileVO.fileGroupNo;
    	int fn = fileVO.fileNo;
    	return "redirect:/admin/adminFileList?fileGroupNo="+fgn+"&fldNo="+fn;
    }
    
    @PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
    @RequestMapping(value = "/download", method = RequestMethod.GET)
    public void downloadFile(@RequestParam("fileGroupNo") int fileGroupNo, @RequestParam("fileNo") int fileNo, HttpServletResponse response) {
    	
    	try {
    		Map<String, Object> map = new HashMap<String, Object>();
    		map.put("fileGroupNo", fileGroupNo);
    		map.put("fileNo", fileNo);
    		CustomFileVO file = service.getFile(map);
    		Path filePath = Paths.get(file.getFilePath());
    		// 파일 이름 인코딩
    		String encodedFileName = java.net.URLEncoder.encode(file.getFileOrgnlNm(), "UTF-8").replaceAll("\\+", "%20");
    		response.setContentType(file.getFileType());
    		response.setHeader("Content-Disposition", "attachment; filename=\"" + encodedFileName + "\"");
    		response.setCharacterEncoding("UTF-8");
    		
    		Files.copy(filePath, response.getOutputStream());
    		response.getOutputStream().flush();
    	} catch (IOException e) { 
    		log.error("File download error", e);
    	}
    }
    
    @PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
    @RequestMapping(value = "/delFolder", method = RequestMethod.POST)
    public String delFolder(int fldNo) {
    	service.deleteFolder(fldNo);
    	return "redirect:/admin/adminDataMain";
    }
    

} 