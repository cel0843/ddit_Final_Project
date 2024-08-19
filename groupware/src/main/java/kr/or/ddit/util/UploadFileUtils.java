package kr.or.ddit.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.vo.AttachFileVO;
import kr.or.ddit.vo.CustomChatMsgVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class UploadFileUtils {
	
	private static String resourcePath = "C:/groupware_file_upload/upload_files/";
	
	// 이미지 파일 base64인코딩 값
	public static String encodeImageToBase64(MultipartFile file) throws IOException {
        byte[] bytes = file.getBytes();
        return Base64.getEncoder().encodeToString(bytes);
    }
	
	// 게시판 file 저장 메서드
	public static List<AttachFileVO> saveBoardFile(MultipartFile[] fileArr, int fileGroupNo) throws IOException {
		List<AttachFileVO> fileList = new ArrayList<AttachFileVO>();
		for (MultipartFile file : fileArr) {
			String originalFilename = file.getOriginalFilename();	// 원본 파일명
	        String uuid = UUID.randomUUID().toString();				// 저장 파일명 : UUID_원본파일명
	        String fileStrgNm = uuid + "_" + originalFilename;		// 저장 파일명 : UUID_원본파일명 
	        String filePath = resourcePath + fileStrgNm;	// 저장 경로 /resources/upload/UUID_원본파일명 
	        
	        log.info("@@@ 파일경로 : " + resourcePath);
	        log.info("@@@ 저장경로 : " + filePath);
	        
	        File dest = new File(filePath);
	        if (!dest.getParentFile().exists()) {
	            dest.getParentFile().mkdirs();
	        }
	        file.transferTo(dest);	// 파일복사
	        
	        AttachFileVO fileVO = new AttachFileVO();
	        fileVO.setFileGroupNo(fileGroupNo);
	        fileVO.setFilePath(resourcePath + fileStrgNm);
	        fileVO.setFileStrgNm(fileStrgNm);
	        fileVO.setFileOrgnlNm(originalFilename);
	        fileVO.setFileSz(file.getSize());
	        fileVO.setFileFancysize(convertSize(file.getSize()));
	        fileVO.setFileCtrDt(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
	        fileVO.setFileType(getFileExtension(originalFilename));
	        log.info("##### uploadFileUtils saveBoardFile : \n " + fileVO);
	        fileList.add(fileVO);
		}
		return fileList;
	}
	
	// 채팅에 사용할 file 저장 메서드
	public static CustomChatMsgVO saveFile(MultipartFile file) throws IOException {
        String originalFilename = file.getOriginalFilename();	// 원본 파일명
        String uuid = UUID.randomUUID().toString();				// 저장 파일명 : UUID_원본파일명
        String fileStrgNm = uuid + "_" + originalFilename;		// 저장 파일명 : UUID_원본파일명 
//        String filePath = resourcePath + File.separator + fileStrgNm;	// 저장 경로 /resources/upload/UUID_원본파일명 
        String filePath = resourcePath + fileStrgNm;	// 저장 경로 /resources/upload/UUID_원본파일명 
        
        log.info("@@@ 파일경로 : " + resourcePath);
        log.info("@@@ 저장경로 : " + filePath);
        
        File dest = new File(filePath);
        if (!dest.getParentFile().exists()) {
            dest.getParentFile().mkdirs();
        }
        file.transferTo(dest);	// 파일복사

        CustomChatMsgVO fileInfo = new CustomChatMsgVO();
        fileInfo.setFilePath(resourcePath + fileStrgNm);
        fileInfo.setFileStrgNm(fileStrgNm);
        fileInfo.setFileOrgnlNm(originalFilename);
        fileInfo.setFileSz(file.getSize());
        fileInfo.setFileFancySize(convertSize(file.getSize()));
        fileInfo.setFileCtrDt(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
//        fileInfo.setFileType(Files.probeContentType(dest.toPath()));
        fileInfo.setFileType(getFileExtension(originalFilename));
        log.info("@@@@@@@@@@ uploadFileUtils CustomChatMsgVO : \n " + fileInfo);
        return fileInfo;
    }
	
	// fancysize 추출
	private static String convertSize(long size) {
        if (size <= 0) return "0";
        final String[] units = new String[]{"B", "KB", "MB", "GB", "TB"};
        int digitGroups = (int) (Math.log10(size) / Math.log10(1024));
        return String.format("%.1f %s", size / Math.pow(1024, digitGroups), units[digitGroups]);
    }
	
	// 확장자 추출
	private static String getFileExtension(String fileName) {
        int lastIndex = fileName.lastIndexOf('.');
        return (lastIndex == -1) ? "" : fileName.substring(lastIndex + 1);
    }
	
	// 수업 시간에 배운 내용 참고
	
	/*
	public static String uploadFile(String originalName, byte[] fileData) throws Exception {
		// /2024/05/29/UUID_원본파일명
		UUID uuid = UUID.randomUUID();
		
		// UUID_원본파일명
		String savedName = uuid.toString() + "_" + originalName;
		
		String savedPath = calcPath(resourcePath);
		
		// 배포된 서버 업로드 경로 + /2024/05/29 + UUID_원본파일명으로 File target을 하나 만들어 놓는다.
		File target = new File(resourcePath + savedPath, savedName);
		FileCopyUtils.copy(fileData, target);	// 파일복사
		
		String formatName = originalName.substring(originalName.lastIndexOf(".") + 1);
		
		String uploadedFileName = savedPath.replace(File.separatorChar, '/') + "/" + savedName;
		
//		if (MediaUtils.getMediaType(formatName) != null) {
//			makeThumnail(uploadPath, savedPath, savedName);
//		}
		
		// /2024/05/29/UUID_원본파일명
		return uploadedFileName;
	}
	*/
	
	
	/*
	private static void makeThumnail(String uploadPath, String savedPath, String savedName) throws Exception {
		// 썸네일 이미지를 만들기 위해 원본 이미지를 읽는다.
		BufferedImage sourceImg =  ImageIO.read(new File(uploadPath + savedPath, savedName));
		
		// 썸네일 이미지를 만들기 위한 설정을 진행
		// Method.AUTOMATIC : 최소 시간 내에 가장 잘 보이는 이미지를 얻기 위한 사용 방식
		// Mode.FIT_TO_HEIGHT : 이미지 방향과 상관없이 주어진 높이 내에서 가장 잘 맞는 이미지로 계산
		// targetSize : 값 100, 정사각형 사이즈로 100 x 100
		BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 100);
		
		// 업로드 한 원본 이미지를 가지고 's_'를 붙여서 임시 파일로 만들기 위해 썸네일 경로 + 파일명을 작성한다.
		String thumbnailName = uploadPath + savedPath + File.separator + "s_" + savedName;
		
		File newFile = new File(thumbnailName);
		String formatName = savedName.substring(savedName.lastIndexOf(".") + 1);
		
		// 's_'가 붙은 썸네일 이미지를 만든다.
		ImageIO.write(destImg, formatName.toUpperCase(), newFile);
	}
	 */
	
	/*
	private static String calcPath(String uploadPath) {
		Calendar cal =Calendar.getInstance();
		String yearPath = File.separator + cal.get(Calendar.YEAR);	// /2024
		
		// DecimalFormat("00") : 두자리에서 빈자리는 0으로 채움
		String monthPath = yearPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);	// /2024/05
		String datePath = monthPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.DATE));	// /2024/05/29
		
		// 년월일 폴더 구조에 의한 폴더 생성
		makeDir(uploadPath, yearPath, monthPath, datePath);
		
		return datePath;
	}
	*/

	/*
	// 가변인자
	// 키워드 '...'를 사용한다.
	// [사용법] 타입...변수명 형태로 사용
	// 순서대로 yearPath, monthPath, datePath가 배열로 들어가 처리
	private static void makeDir(String uploadPath, String...paths) {
		// /2024/05/29 폴더 구조가 존재한다면 return
		// 만들려던 폴더 구조가 이미 만들어져 있는 구조기 때문에 return을 하고
		// 그렇지 않으면 폴더 구조를 만들어준다.
		if (new File(paths[paths.length - 1]).exists()) {
			return;
		}
		
		for (String path : paths) {
			File dirPath = new File(uploadPath + path);
			
			// /2024/05/29과 같은 경로에 각 촐더가 없으면 각각 만들어진다.
			if (!dirPath.exists()) {
				dirPath.mkdirs();
			}
		}
		
	}
	*/
	
}
