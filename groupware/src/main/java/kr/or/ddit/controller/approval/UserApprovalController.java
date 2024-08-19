package kr.or.ddit.controller.approval;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.simple.parser.JSONParser;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.service.approval.IApprovalService;
import kr.or.ddit.service.mailService.IMailService;
import kr.or.ddit.vo.AprvDeptVO;
import kr.or.ddit.vo.AprvDocumentVO;
import kr.or.ddit.vo.AprvFormVO;
import kr.or.ddit.vo.AprvLineTempVO;
import kr.or.ddit.vo.AprvLineVO;
import kr.or.ddit.vo.AprvProjectVO;
import kr.or.ddit.vo.AprvProxyVO;
import kr.or.ddit.vo.AprvVacVO;
import kr.or.ddit.vo.AttachFileVO;
import kr.or.ddit.vo.CustomEmployeeVO;
import kr.or.ddit.vo.DepartmentVO;
import kr.or.ddit.vo.EmployeeHolidayVO;
import kr.or.ddit.vo.EmployeeVO;
import kr.or.ddit.vo.HdHistoryVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/egg")
public class UserApprovalController {

	@Inject
	private IApprovalService service;

	@Inject
	private IMailService mailService;

	// 사용자 결재하기list
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@RequestMapping(value = "/aprvList", method = RequestMethod.GET)
	public String aprvList(HttpServletRequest request, Model model, String prgrsSttsTy, String aprvStatus
			, @RequestParam(name="aprvId", required = false, defaultValue = "0") int aprvId ) {
		HttpSession session = request.getSession();
		CustomEmployeeVO emplInfo = (CustomEmployeeVO) session.getAttribute("emplInfo");
		String emplId = emplInfo.getEmplId();


		AprvDocumentVO doc = new AprvDocumentVO();
		doc.setEmplId(emplId);
		doc.setPrgrsSttsTy(prgrsSttsTy);
		doc.setAprvStatus(aprvStatus);
		List<AprvDocumentVO> aprvDocList = service.aprvDocList(doc);
		
		// 대결자설정 조회
		AprvProxyVO proxy = service.proxyOne(emplId);
		
		// 결재라인에 있는 대결자 아이디로 결재문서 조회. 
		String agtId = emplInfo.getEmplId();
		List<AprvDocumentVO> proxyDoc = service.aprvProxyList(agtId);
		if(proxyDoc.size() == 0) proxyDoc = null;
	    

		model.addAttribute("proxyDoc", proxyDoc);
	    model.addAttribute("list", aprvDocList);
	    model.addAttribute("proxy", proxy);
	    model.addAttribute("type", "gjhg");
	    model.addAttribute("prgrsSttsTy", prgrsSttsTy);
	    model.addAttribute("aprvStatus", aprvStatus);
	    
	    model.addAttribute("aprvId", aprvId); // 알람을 위한 결재 번호
	    
		return "egg/approval/userAprvList";
	}

	// 내가 올린 기안 List
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@RequestMapping(value = "/draftList", method = RequestMethod.GET)
	public String draftList(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		CustomEmployeeVO emplInfo = (CustomEmployeeVO) session.getAttribute("emplInfo");
		String emplId = emplInfo.getEmplId();
		
		List<AprvDocumentVO> draftList = service.draftList(emplId);

		AprvProxyVO proxy = service.proxyOne(emplId);
		
		model.addAttribute("proxy",proxy);
		model.addAttribute("draft","draft");
		model.addAttribute("list", draftList);
		model.addAttribute("type", "gimsh");
		return "egg/approval/userAprvList";
	}
	//참조문서함 List
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@RequestMapping(value = "/rfrncList", method = RequestMethod.GET)
	public String rfrncList(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		CustomEmployeeVO emplInfo = (CustomEmployeeVO) session.getAttribute("emplInfo");
		String emplId = emplInfo.getEmplId();
		
		List<AprvDocumentVO> rfrncList = service.rfrncList(emplId);
		
		AprvProxyVO proxy = service.proxyOne(emplId);
		
		model.addAttribute("rfrnc","rfrnc");
		model.addAttribute("proxy",proxy);
		model.addAttribute("list", rfrncList);
		model.addAttribute("type", "gimsh");
		return "egg/approval/userAprvList";
	}

	// 대리자 설정 시 조직도
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@RequestMapping(value = "/emplList", method = RequestMethod.GET)
	public ResponseEntity<List<EmployeeVO>> emplList(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		CustomEmployeeVO emplInfo = (CustomEmployeeVO) session.getAttribute("emplInfo");
		List<EmployeeVO> emplList = service.emplList();
		model.addAttribute("emplList", emplList);
		return new ResponseEntity<List<EmployeeVO>>(emplList, HttpStatus.OK);
	}

	// 대결자 등록
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@RequestMapping(value = "/proxyInsert", method = RequestMethod.POST)
	public String proxyInsert(HttpServletRequest request, Model model, AprvProxyVO proxy) {
		HttpSession session = request.getSession();
		CustomEmployeeVO emplInfo = (CustomEmployeeVO) session.getAttribute("emplInfo");
		String emplId = emplInfo.getEmplId();
		String bgng = proxy.getBgngYmd();
		String end = proxy.getEndYmd();
		String bgngYmd = bgng.replace("-", "");
		String endYmd = end.replace("-", "");

		proxy.setEmplId(emplId);
		proxy.setBgngYmd(bgngYmd);
		proxy.setEndYmd(endYmd);
		service.insertProxy(proxy);
		return "redirect:/egg/aprvList";
	}

	// 매일 자정에 대결기간 지난 사람들 대결 사용여부 n으로 변경
	@Scheduled(cron = "59 59 23 * * *")
	public void endproxy() {
		log.info("대결기간 종료");
		service.endproxy();
	}

	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	// 프로젝트 기안 등록페이지
	@GetMapping(value = "/projDoc")
	public String projDoc(HttpServletRequest request, Model model,
			@RequestParam("formCd") String formCd) {
		HttpSession session = request.getSession();
		CustomEmployeeVO emplInfo = (CustomEmployeeVO) session.getAttribute("emplInfo");
		model.addAttribute("formCd", formCd);
		return "egg/approval/projAprvDoc";
	}
	
	// 인사 기안 등록페이지
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@GetMapping(value = "/transDoc")
	public String transDoc(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		CustomEmployeeVO emplInfo = (CustomEmployeeVO) session.getAttribute("emplInfo");
		
		List<EmployeeVO> transempl = service.emplList();
		List<DepartmentVO> dept = service.deptList();
		model.addAttribute("transempl", transempl);
		model.addAttribute("dept", dept);
		return "egg/approval/transAprvDoc";
	}
	
	// 휴가 기안 등록페이지
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@GetMapping(value = "/vacDoc")
	public String vacDoc(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		CustomEmployeeVO emplInfo = (CustomEmployeeVO) session.getAttribute("emplInfo");
		return "egg/approval/vacAprvDoc";
	}

	// 결재유형으로 양식불러오기
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@PostMapping(value = "/formList")
	public ResponseEntity<List<AprvFormVO>> formList(Model model) {
		AprvFormVO form = new AprvFormVO();
		List<AprvFormVO> formList = service.formList(form);
		model.addAttribute("formList", formList);
		return new ResponseEntity<List<AprvFormVO>>(formList, HttpStatus.OK);
	}

	// 프로젝트 결재문서등록
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@PostMapping(value = "/addProjDoc")
	public String addAprvDoc(HttpServletRequest request, AprvDocumentVO aprvDoc, AprvProjectVO aprvProjectVo,
			@RequestParam(value = "rfrnc", required = false, defaultValue = "") List<String> rfrnc,
			@RequestParam("selEmplId") List<String> selEmplId,
			@RequestParam("prtcpList") List<String> prtcpList,@RequestParam("prtcpAuthList") List<String> prtcpAuthList) {
		HttpSession session = request.getSession();
		CustomEmployeeVO emplInfo = (CustomEmployeeVO) session.getAttribute("emplInfo");
		String emplId = emplInfo.getEmplId();
		String emplNm = emplInfo.getEmplNm();
		String deptNm = emplInfo.getDeptNm();

		aprvDoc.setDeptNm(deptNm);
		aprvDoc.setEmplId(emplId);
		aprvDoc.setEmplNm(emplNm);

		service.addAprvDoc(aprvDoc);

		System.out.println("참조자 선택: " + rfrnc);

		if (rfrnc != null && !rfrnc.isEmpty()) {
			for (String rfrncId : rfrnc) {
				Map<String, Object> param = new HashMap<>();
				param.put("emplId", rfrncId);
				param.put("aprvId", aprvDoc.getAprvId());
				service.insertRfrnc(param);
			}
		}
		System.out.println("결재자 지정: " + selEmplId);

		for (int i = 0; i < selEmplId.size(); i++) {
			Map<String, Object> param = new HashMap<>();
			param.put("emplId", selEmplId.get(i));
			param.put("aprvId", aprvDoc.getAprvId());
			param.put("aprvOrder", i + 1);
			service.insertAprvLine(param);
		}
		
		aprvProjectVo.setAprvId(aprvDoc.getAprvId());
		service.insertProjectFormData(aprvProjectVo);
		
		//프로젝트 참가자 등록
		for (int i = 0; i < prtcpList.size(); i++) {
		    Map<String, Object> param = new HashMap<>();
		    param.put("emplId", prtcpList.get(i));
		    param.put("aprvId", aprvDoc.getAprvId());
		    param.put("auth", prtcpAuthList.get(i));
		    service.insertProjFormPrtcp(param);
		}
		
		
		return "redirect:/egg/aprvList?aprvId=" + aprvProjectVo.getAprvId();
	}
	
	// 부서이동 결재문서등록
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@PostMapping(value = "/addTransDoc")
	public String addTransDoc(HttpServletRequest request, AprvDocumentVO aprvDoc, AprvDeptVO aprvDeptVo,
			@RequestParam(value = "rfrnc", required = false, defaultValue = "") List<String> rfrnc,
			@RequestParam("selEmplId") List<String> selEmplId) {
		HttpSession session = request.getSession();
		CustomEmployeeVO emplInfo = (CustomEmployeeVO) session.getAttribute("emplInfo");
		String emplId = emplInfo.getEmplId();
		String emplNm = emplInfo.getEmplNm();
		String deptNm = emplInfo.getDeptNm();
		
		aprvDoc.setDeptNm(deptNm);
		aprvDoc.setEmplId(emplId);
		aprvDoc.setEmplNm(emplNm);
		
		service.addAprvDoc(aprvDoc);
		
		System.out.println("참조자 선택: " + rfrnc);
		
		if (rfrnc != null && !rfrnc.isEmpty()) {
			for (String rfrncId : rfrnc) {
				Map<String, Object> param = new HashMap<>();
				param.put("emplId", rfrncId);
				param.put("aprvId", aprvDoc.getAprvId());
				service.insertRfrnc(param);
			}
		}
		System.out.println("결재자 지정: " + selEmplId);
		
		for (int i = 0; i < selEmplId.size(); i++) {
			Map<String, Object> param = new HashMap<>();
			param.put("emplId", selEmplId.get(i));
			param.put("aprvId", aprvDoc.getAprvId());
			param.put("aprvOrder", i + 1);
			service.insertAprvLine(param);
		}
		
		aprvDeptVo.setAprvId(aprvDoc.getAprvId());
		service.insertDeptMvnvFormData(aprvDeptVo);
		
		return "redirect:/egg/aprvList?aprvId=" + aprvDeptVo.getAprvId();
	}
	
	// 휴가 결재문서등록
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@PostMapping(value = "/addVacDoc")
	public String addVacDoc(HttpServletRequest request, AprvDocumentVO aprvDoc, AprvVacVO aprvVacVo,
			@RequestParam(value = "rfrnc", required = false, defaultValue = "") List<String> rfrnc,
			@RequestParam("selEmplId") List<String> selEmplId) {
		HttpSession session = request.getSession();
		CustomEmployeeVO emplInfo = (CustomEmployeeVO) session.getAttribute("emplInfo");
		String emplId = emplInfo.getEmplId();
		String emplNm = emplInfo.getEmplNm();
		String deptNm = emplInfo.getDeptNm();
		
		aprvDoc.setDeptNm(deptNm);
		aprvDoc.setEmplId(emplId);
		aprvDoc.setEmplNm(emplNm);
		
		// 반차일때는 일자와 시간이 나눠서 들어오기 때문에 데이터를 가공해주어야한다.
		if(aprvVacVo.getFormSeNo() == 2){	
			String[] hdBgngHrArr = aprvVacVo.getHdBgngHr().split(",");
			String[] hdEndHrArr =aprvVacVo.getHdEndHr().split(",");
			aprvVacVo.setHdBgngHr(hdBgngHrArr[0] + " " + hdBgngHrArr[1]);
			aprvVacVo.setHdEndHr(hdEndHrArr[0] + " " + hdEndHrArr[1]);
		}
		
		service.addAprvDoc(aprvDoc);

		
		
		System.out.println("참조자 선택: " + rfrnc);
		
		if (rfrnc != null && !rfrnc.isEmpty()) {
			for (String rfrncId : rfrnc) {
				Map<String, Object> param = new HashMap<>();
				param.put("emplId", rfrncId);
				param.put("aprvId", aprvDoc.getAprvId());
				service.insertRfrnc(param);
			}
		}
		System.out.println("결재자 지정: " + selEmplId);
		
		for (int i = 0; i < selEmplId.size(); i++) {
			Map<String, Object> param = new HashMap<>();
			param.put("emplId", selEmplId.get(i));
			param.put("aprvId", aprvDoc.getAprvId());
			param.put("aprvOrder", i + 1);
			service.insertAprvLine(param);
		}
		
		aprvVacVo.setAprvId(aprvDoc.getAprvId());
		aprvVacVo.setEmplId(emplId);
		
		service.insertHdAplyFormData(aprvVacVo);
		
		return "redirect:/egg/aprvList?aprvId=" + aprvVacVo.getAprvId();
	}

	// 결재문서 파일 업로드
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@PostMapping("/aprvUpload")
	@ResponseBody
	public Map<String, Object> uploadFiles(MultipartFile[] attachments) {
		Map<String, Object> response = new HashMap<>();
		try {
			int fileGroupNo = mailService.saveFiles(attachments);
			response.put("success", true);
			response.put("fileGroupNo", fileGroupNo);
		} catch (Exception e) {
			log.error("File upload failed", e);
			response.put("success", false);
			response.put("message", "File upload failed: " + e.getMessage());
		}
		return response;
	}

	// 결재문서 detail
	@GetMapping("/detailDoc")
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	public String detailDoc(Model model, String aprvId, String type,  HttpServletRequest request) {
		AprvDocumentVO doc = service.detailDoc(aprvId);
		
		AprvProjectVO proj = service.detailProj(aprvId);
		model.addAttribute("proj", proj);
	
		AprvDeptVO dept = service.detailDept(aprvId);
		model.addAttribute("dept",dept);
		
		AprvVacVO vac = service.detailVac(aprvId);
		model.addAttribute("vac",vac);
		
		if(doc.getFileGroupNo() != null) {
			List<AttachFileVO> fileList =service.getFile(doc.getFileGroupNo());
			model.addAttribute("fileList",fileList);
		}
		List<AprvLineVO> line = service.aprvLine(aprvId);
		
		HttpSession session = request.getSession();
		CustomEmployeeVO emplInfo = (CustomEmployeeVO) session.getAttribute("emplInfo");
		String emplId = emplInfo.getEmplId();
		
		
		
		boolean aprvFlag = false;
		// 결제 완료? 결제 대기?
		for (int i = 0; i < line.size(); i++) {
		    AprvLineVO currentLine = line.get(i);	//사용자가 지정한 원래결재라인
		    
		    if (currentLine.getEmplId().equals(emplId)) {// 현재 결재 순서와 로그인한 아이디 비교
		    	AprvProxyVO aprvProxyVO = service.proxyOne(currentLine.getEmplId());
		        if (i == line.size() - 1) {
		            currentLine.setFinalAprvYn("Y");	// 최종결재자일때  값 셋팅
		        }
		        model.addAttribute("myAprv", currentLine);	// 내 결재 차례인지 확인

		        // 현재 결재자 앞의 모든 결재자에 대해 처리
		        for (int j = 0; j < i; j++) {
		            AprvLineVO previousLine = line.get(j);
		            if ((previousLine.getAprvStatus().equals("SEC00202") || previousLine.getAprvStatus().equals("SEC00201")) 
		            		&& !previousLine.getEmplId().equals(previousLine.getLastAprv())) {
		                previousLine.setEmplId(previousLine.getLastAprv());
		                previousLine.setEmplNm(previousLine.getAgtNm());
		                
		                AprvProxyVO agtInfo = service.selectAgtName(previousLine.getEmplId());
		                previousLine.setEsgn(agtInfo.getEsgn());
		                
		               
		                System.out.println("Updated line " + j + ": " + previousLine);
		            }
		        }

		        if (i == 0) {
		            // 첫 번째 결재자인 경우
		            aprvFlag = currentLine.getAprvStatus().equals("SEC00103"); // 대기 상태일 때만 true
		        } else {
		            // 이전 결재자가 완료 상태이고 현재 결재자가 대기 상태일 때 true
		            aprvFlag = line.get(i-1).getAprvStatus().equals("SEC00202") && 
		                       currentLine.getAprvStatus().equals("SEC00103");
		            // 이전 결재자가 반려한 경우
	                if (line.get(i-1).getAprvStatus().equals("SEC00201")) {
	                    aprvFlag = false;
	                }
		        }
		        
		        if(aprvProxyVO != null) {	// 결재자가 맞는데 대결자가 있네? 그럼 너 결재 못해
		        	aprvFlag = false;
		        }
		        break; // 현재 사용자의 결재 라인을 찾았으므로 루프 종료
		    }
		}

		model.addAttribute("aprvFlag", aprvFlag);
		model.addAttribute("doc", doc);     
		model.addAttribute("type", type);
		model.addAttribute("line", line);

		return "egg/approval/detailDoc";	
	}
	// 대리결재 문서 detail
	@GetMapping("/agtDetailDoc")
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	public String agtDetailDoc(Model model, String aprvId, String type,  HttpServletRequest request) {
		AprvDocumentVO doc = service.detailDoc(aprvId);
		
		AprvProjectVO proj = service.detailProj(aprvId);
		model.addAttribute("proj", proj);
		
		AprvDeptVO dept = service.detailDept(aprvId);
		model.addAttribute("dept",dept);
		
		AprvVacVO vac = service.detailVac(aprvId);
		model.addAttribute("vac",vac);
		
		List<AprvLineVO> line = service.agtAprvLine(aprvId);

	    HttpSession session = request.getSession();
	    CustomEmployeeVO emplInfo = (CustomEmployeeVO) session.getAttribute("emplInfo");
	    String emplId = emplInfo.getEmplId();
	    AprvProxyVO agtInfo = service.selectAgtName(emplId);

	 // 대리자 정보를 결재 라인에 반영
	    for (int i = 0; i < line.size(); i++) {
	        AprvLineVO lineItem = line.get(i);
	        if (agtInfo != null && lineItem.getEmplId().equals(agtInfo.getEmplId())) {
	            // 원결재자의 ID가 대리 설정된 경우
	            lineItem.setEmplId(agtInfo.getAgtId());
	            lineItem.setEmplNm(emplInfo.getEmplNm()); // 대리자 이름
	            lineItem.setPositionCdNm(emplInfo.getPositionNm()); // 대리자 직위
	            lineItem.setEsgn(emplInfo.getEsgn()); // 대리자 서명
	            line.set(i, lineItem); // 변경된 객체를 리스트에 다시 설정
	        }
	    }

	    boolean aprvFlag = false;
	    // 결제 완료? 결제 대기?
	    for (int i = 0; i < line.size(); i++) {
	        AprvLineVO currentLine = line.get(i);
	        
	        if (currentLine.getEmplId().equals(emplId)) {
	            if (i == line.size() - 1) {
	                currentLine.setFinalAprvYn("Y");
	            }
	            model.addAttribute("myAprv", currentLine);

	            // 현재 결재자 앞의 모든 결재자에 대해 처리
	            for (int j = 0; j < i; j++) {
	                AprvLineVO previousLine = line.get(j);
	                if (previousLine.getAprvStatus().equals("SEC00202") && 
	                    !previousLine.getEmplId().equals(previousLine.getLastAprv())) {
	                    // 대리 결재자 정보 조회
	                    AprvProxyVO previousAgtInfo = service.selectAgtName(previousLine.getLastAprv());
	                    if (previousAgtInfo != null) {
	                        previousLine.setEmplId(previousAgtInfo.getAgtId());
	                        previousLine.setEmplNm(previousAgtInfo.getEmplNm());
	                        previousLine.setPositionCdNm(previousAgtInfo.getPositionCdNm());
	                        previousLine.setEsgn(previousAgtInfo.getEsgn());
	                        line.set(j, previousLine); // 변경된 객체를 리스트에 다시 설정
	                    }
	                }
	            }

	            if (i == 0) {
	                // 첫 번째 결재자인 경우
	                aprvFlag = currentLine.getAprvStatus().equals("SEC00103"); // 대기 상태일 때만 true
	            } else {
	                // 이전 결재자가 완료 상태이고 현재 결재자가 대기 상태일 때 true
	                aprvFlag = line.get(i-1).getAprvStatus().equals("SEC00202") && 
	                           currentLine.getAprvStatus().equals("SEC00103");
	            }
	            break; // 현재 사용자의 결재 라인을 찾았으므로 루프 종료
	        }
	    }
	    
		model.addAttribute("aprvFlag", aprvFlag);
		model.addAttribute("doc", doc);     
		model.addAttribute("type", type);
		model.addAttribute("line", line);
		
		return "egg/approval/detailDoc";	
	}
	
	//승인 결재
	@ResponseBody
	@PostMapping(value = "/saveAprvLine")
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	public Map<String, Object> saveAprvLine(Model model, AprvLineVO lineVO, AprvVacVO vacaVO,HttpServletRequest request) {
		HttpSession session = request.getSession();
		CustomEmployeeVO emplInfo = (CustomEmployeeVO) session.getAttribute("emplInfo");
		String emplId = emplInfo.getEmplId();
		lineVO.setEmplId(emplId);
		
		//대결자 설정
		AprvProxyVO proxy = service.proxyOne(emplId);
		if (proxy == null) {
			lineVO.setLastAprv(emplId);
		} else {
			lineVO.setLastAprv(proxy.getAgtId());
		}
		
		Map<String, Object> res = new HashMap<>();
		
		service.saveAprvLine(lineVO);
		
		
		if (lineVO.getFinalAprvYn().equals("Y")) {
			//최종결재 완료 후 처리 데이터
//			lineVO.setCmptnYn("Y");
//			lineVO.setAprvStatus("SEC00101");

			//최종 승인일시
			if (lineVO.getAprvStatus().equals("SEC00202")) {
				//승인일시
				if (lineVO.getFormCd().equals("BP")) {
					//프로젝트일시
					service.insertProjectData(lineVO);					
					service.insertProjectPrtcp(lineVO);
				} else if (lineVO.getFormCd().equals("HR")) {
					//인사이동 일시
					service.updateDeptMvnv(lineVO);
					
				} else if(lineVO.getFormCd().equals("AR")) {
					//휴가 일시
					vacaVO = service.selectCountDay(lineVO.getAprvId());
					EmployeeHolidayVO emplHoliday = service.selectEmployeeHoliday(lineVO.getEmplId());
					HdHistoryVO hdHistory = new HdHistoryVO();
					hdHistory.setEmplId(vacaVO.getEmplId());
					hdHistory.setAprvId(vacaVO.getAprvId());
					hdHistory.setHdBgngHr(vacaVO.getHdBgngHr().replace(".0", ""));
					hdHistory.setHdEndHr(vacaVO.getHdEndHr().replace(".0", ""));
					hdHistory.setHdCd(vacaVO.getFormHdfSe());
					hdHistory.setHdCnt(vacaVO.getDeductedDays());
					hdHistory.setHdReson(vacaVO.getHdReson());
					hdHistory.setLeftCnt(emplHoliday.getLeftCnt() - vacaVO.getDeductedDays());
					
					service.insertHdHistory(hdHistory);	
					service.updateEmployeeHoliday(hdHistory);
				}
				lineVO.setCmptnYn("Y");
			} else {
				//결재 진행중
				lineVO.setCmptnYn("N");
				if(lineVO.getAprvStatus().equals("SEC00201")) { // 반려 일때
					lineVO.setCmptnYn("Y");	
				}
			}
			lineVO.setAprvStatus("SEC00101");	// 반려이지만 문서는 완료임
		}else {
			lineVO.setCmptnYn("Y");
			lineVO.setAprvStatus("SEC00102");
		}
		
		//결재문서 상태 업데이트
		service.updateAprvDocStts(lineVO);
		res.put("aprvId", lineVO.getAprvId());		
		return res;
	}
	
	// 부서이동 사원 목록 조회
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@GetMapping("/getEmplInfo")
	@ResponseBody
	public EmployeeVO getEmplInfo(String emplId) {
		EmployeeVO empl = service.getEmplInfo(emplId);
		return empl;
	}
	
	// 설정된 결재라인 불러오기
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@GetMapping("/lineTemplate")
	@ResponseBody
	public  ResponseEntity<List<AprvLineTempVO>> lineTemplate(HttpServletRequest request,Model model) {
		HttpSession session = request.getSession();
		CustomEmployeeVO emplInfo = (CustomEmployeeVO) session.getAttribute("emplInfo");
		String emplId = emplInfo.getEmplId();
		List<AprvLineTempVO> lineList = service.getlineTemplate(emplId);
		model.addAttribute("lineList", lineList);
		return new ResponseEntity<List<AprvLineTempVO>>(lineList, HttpStatus.OK);
	}
	
	// 결재라인 추가하기
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@PostMapping("/insertLineTemp")
	public ResponseEntity<String> insertLineTemp(@RequestBody Map<String, Object> param) {
	    log.info("### param : " + param);
	    String emplId = (String) param.get("emplId");
	    List<Map<String, Object>> lineTempList = (List<Map<String, Object>>) param.get("newLineArray");
	    
	    // 새로운 GROUP_NO 생성
	    int newGroupNo = service.getNewGroupNo();
	    
	    for (Map<String, Object> lineTemp : lineTempList) {
	        AprvLineTempVO altVO = new AprvLineTempVO();
	        altVO.setEmplId(emplId);
	        
	        String aprvOrderStr = String.valueOf(lineTemp.get("aprvOrder"));
	        int aprvOrder = Integer.parseInt(aprvOrderStr);
	        altVO.setAprvOrder(aprvOrder);
	        
	        String lineEmplId = String.valueOf(lineTemp.get("lineEmplId"));
	        altVO.setLineEmplId(lineEmplId);
	        
	        // 새로운 GROUP_NO 설정
	        altVO.setGroupNo(newGroupNo);
	        
	        // 개별 AprvLineTempVO 객체를 서비스로 전달
	        service.insertLineTemp(altVO);
	        
	        log.info("### Inserted AprvLineTempVO: " + altVO);
	    }
	    
	    return ResponseEntity.ok("Success");
	}
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@PostMapping("/deleteLineTemplates")
    public ResponseEntity<?> deleteLineTemplates(@RequestBody List<Integer> groupNos) {
        
        for (Integer group : groupNos) {
			System.out.println(group);
			service.deleteLineTemplates(group);
		}
        
        return ResponseEntity.ok("삭제 성공");
      
    }
	
		
	
}
