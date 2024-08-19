package kr.or.ddit.controller.chat;

import java.io.IOException;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.service.chat.IChatService;
import kr.or.ddit.util.UploadFileUtils;
import kr.or.ddit.vo.ChatRoomVO;
import kr.or.ddit.vo.CustomChatMsgVO;
import kr.or.ddit.websocket.WebSocketHandler;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/egg")
public class ChatController {

	@Inject
	private IChatService service;
	
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@RequestMapping(value = "/chat_main", method = RequestMethod.GET)
	public String chat_main(HttpServletRequest request, Model model) {
		log.info("chat_main() 실행...!");
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        Object principal = authentication.getPrincipal();
        String emplId = "";

        if (principal instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) principal;
            emplId = userDetails.getUsername();
            log.info("@@ emplId: " + emplId);	// 확인용 >> 이후 삭제
            log.info("@@ Authorities: " + userDetails.getAuthorities());	// 확인용 >> 이후 삭제

        } else {
            log.info("UserDetails 정보가 없습니다.");
        }

        // 사용자 정보를 콘솔에 출력
        log.info("Authentication details: " + authentication.getDetails());
        log.info("Authentication authorities: " + authentication.getAuthorities());
		
        
        // 채팅방 목록 조회
        List<Map<String, Object>> chatRoomList = service.selectChatRoomList(emplId);
        model.addAttribute("chatRoomList", chatRoomList);
        
        // 채팅방 유저 목록 조회
        List<Map<String, Object>> chatEmplList = service.selectEmplListOnChat(emplId);
        model.addAttribute("chatEmplList", chatEmplList);
        
        // 소켓 접속 사원 조회
        List<String> socketAccessEmplList = service.getSocketAccessEmplList();
        model.addAttribute("socketAccessEmplList", socketAccessEmplList);

		return "egg/chat/chat_main";
	}
	
	@RequestMapping(value = "/selectChatRoom", method = RequestMethod.GET)
	public ResponseEntity<List<CustomChatMsgVO>> selectChatByRoomNo(String chatRoomNo) {
		log.info("selectChatByRoomNo() 실행...!");
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        Object principal = authentication.getPrincipal();
        String emplId = "";

        if (principal instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) principal;
            emplId = userDetails.getUsername();
        } else {
            log.info("UserDetails 정보가 없습니다.");
        }
        
        Map<String, String> map = new HashMap<String, String>();
        map.put("emplId", emplId);
        map.put("chatRoomNo", chatRoomNo);
        
        List<CustomChatMsgVO> chatRoomMap = service.selectChatByRoomNo(map);
        return ResponseEntity.ok(chatRoomMap);
	}
	
	@RequestMapping(value = "/createChatRoom", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<Integer> createChatRoom(
			@RequestParam("firstEmplId") String firstEmplId,
			@RequestParam("secondEmplId") String secondEmplId,
			@RequestParam("chatRoomName") String chatRoomName
			) {
		
		log.info("createChatRoom() 실행...!");
		ChatRoomVO chatRoomVO = new ChatRoomVO();
		chatRoomVO.setChatRoomNm(chatRoomName);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("chatRoomVO", chatRoomVO);
		map.put("firstEmplId", firstEmplId);
		map.put("secondEmplId", secondEmplId);
		int chatRoomNo = service.createChatRoom(map);
		
		return ResponseEntity.ok(chatRoomNo);
	}
	
	@RequestMapping(value = "/insertChatMessage", method = RequestMethod.POST)
	@ResponseBody
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	public ResponseEntity<CustomChatMsgVO> insertChatMessage(CustomChatMsgVO chatMsg,
			@RequestParam(value = "fileData", required = false) MultipartFile file) {
		log.info("insertChatMessage() 실행...!");

		// 파일 업로드 처리
		if (file != null && !file.isEmpty()) {
			try {
				CustomChatMsgVO fileInfo;
				String filePath;
				String contentType = file.getContentType();
				if (contentType != null && contentType.startsWith("image")) {
                    // 이미지 파일인 경우 Base64로 인코딩
                    String base64Image = UploadFileUtils.encodeImageToBase64(file);
                    chatMsg.setImgFile("data:"+ contentType +";base64," + base64Image);
                    chatMsg.setChatMsgType("MSG_02"); // 이미지 타입 메시지
                } else {
                	// 일반 파일인 경우 서버에 저장
                    fileInfo = UploadFileUtils.saveFile(file);
                    chatMsg.setFilePath(fileInfo.getFilePath());
                    chatMsg.setFileStrgNm(fileInfo.getFileStrgNm());
                    chatMsg.setFileOrgnlNm(fileInfo.getFileOrgnlNm());
                    chatMsg.setFileSz(fileInfo.getFileSz());
                    chatMsg.setFileFancySize(fileInfo.getFileFancySize());
                    chatMsg.setFileCtrDt(fileInfo.getFileCtrDt());
                    chatMsg.setFileType(fileInfo.getFileType());
                    chatMsg.setChatMsgType("MSG_03"); // 파일 타입 메시지
                }
            } catch (IOException e) {
                log.error("파일 업로드 중 오류 발생", e);
                return ResponseEntity.status(500).body(null);
            }
		}
		
		// 채팅 메시지 저장
		// 기능 임시 off
		service.insertChatMessage(chatMsg);

		return ResponseEntity.ok(chatMsg);
	}
	
	// 채팅방에 존재하지 않는 사원 리스트 조회
	@RequestMapping(value = "/selectEmplNotInChatroom", method = RequestMethod.GET)
	public ResponseEntity<List<Map<String, Object>>> selectEmplNotInChatroom(String chatRoomNo) {
		log.info("selectEmplNotInChatroom() 실행...!");
		List<Map<String, Object>> map = service.selectEmplNotInChatroom(chatRoomNo);
		return ResponseEntity.ok(map);
	}
	
	// 채팅방에 사원 추가
	@RequestMapping(value = "/addEmplToChatRoom", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<String> addEmplToChatRoom(
			@RequestParam("chatRoomNo") String chatRoomNo,
			@RequestParam("emplArrToStr") String emplArrToStr) {
		log.info("addEmplToChatRoom() 실행...!");
		String[] emplArr = emplArrToStr.split(",");
		service.addEmplToChatRoom(chatRoomNo, emplArr);
		return ResponseEntity.ok("success");
	}
	
	// 채팅방에 속한 사원 조회
	@RequestMapping(value = "/selectEmplInChat", method = RequestMethod.GET)
	public ResponseEntity<List<Map<String, Object>>> selectEmplInChat(String chatRoomNo) {
		log.info("selectEmplInChat() 실행...!");
		List<Map<String, Object>> emplInChatList = service.selectEmplInChat(chatRoomNo);
		return ResponseEntity.ok(emplInChatList);
	}
}
