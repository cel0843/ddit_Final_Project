package kr.or.ddit.websocket;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.service.chat.IChatService;
import kr.or.ddit.vo.CustomChatMsgVO;
import kr.or.ddit.vo.CustomEmployeeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/egg/chat")
public class WebSocketHandler extends TextWebSocketHandler {

	// 세션 리스트
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	
	@Inject
	private IChatService service;
	
	// JSON 메시지를 파싱하기 위해 ObjectMapper를 사용
	private ObjectMapper objectMapper = new ObjectMapper();

	// 클라이언트가 연결 되었을 때 실행
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		sessionList.add(session);
		Map<String, Object> map = session.getAttributes();
		String emplId = ((CustomEmployeeVO) map.get("emplInfo")).getEmplId();
		log.info("### {} 소켓 연결됨", emplId);
		
		List<String> socketAccessList = new ArrayList<String>();
		for (WebSocketSession sessionOne : sessionList) {
			String socketAccessEmpl = ((CustomEmployeeVO)sessionOne.getAttributes().get("emplInfo")).getEmplId();
			socketAccessList.add(socketAccessEmpl);
			log.info("### socketAccessList에 아이디 저장 중입니다. >> " + socketAccessEmpl);
		}
		
		service.clearSocketAccessEmplList();		
		service.addSocketAccessEmplList(socketAccessList);
		
		
		// Authentication에서 정보꺼내는 방법
//		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
//        Object principal = authentication.getPrincipal();
//        if (principal instanceof UserDetails) {
//            UserDetails userDetails = (UserDetails) principal;
//            emplId = userDetails.getUsername();
//            log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ emplId: " + emplId);
//        } else {
//            log.info("UserDetails 정보가 없습니다.");
//        }
		
	}

	// 클라이언트가 웹소켓 서버로 메시지를 전송했을 때 실행
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		Map<String, Object> map = session.getAttributes();
		String emplId = ((CustomEmployeeVO) map.get("emplInfo")).getEmplId();
		log.info("{}로 부터 {}받음", emplId, message.getPayload());
		
		// JSON 메시지를 ChatMessageVO 객체로 변환
		CustomChatMsgVO chatMessage = objectMapper.readValue(message.getPayload(), CustomChatMsgVO.class);
		
		log.info("###" + chatMessage);
		
		// 모든 유저에게 메세지 출력
		for (WebSocketSession sess : sessionList) {
//			sess.sendMessage(new TextMessage(message.getPayload()));
			sess.sendMessage(new TextMessage(objectMapper.writeValueAsString(chatMessage)));
		}
		
		super.handleTextMessage(session, message);
	}

	// 클라이언트 연결을 끊었을 때 실행
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		Map<String, Object> map = session.getAttributes();
		String emplId = ((CustomEmployeeVO) map.get("emplInfo")).getEmplId();
		sessionList.remove(session);
		log.info("{} 연결 끊김.", emplId);
	}

}
