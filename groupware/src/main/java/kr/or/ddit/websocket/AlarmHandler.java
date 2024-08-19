package kr.or.ddit.websocket;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import kr.or.ddit.service.alarm.IAlarmService;
import kr.or.ddit.vo.CustomEmployeeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("egg/alarm")
public class AlarmHandler extends TextWebSocketHandler {

	@Inject
	private IAlarmService service;
	
	// 세션 리스트
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		log.info("####### "+((CustomEmployeeVO)session.getAttributes().get("emplInfo")).getEmplId()+"alarm 소켓 실행 ");
		sessionList.add(session);
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		// 전송 메세지 JsonParsing 하기
		String payload = message.getPayload();
		log.info("###### message.getPayload : "+payload);	// del
		JsonObject payloadsonObj;
		String alarmType;
		try {
			JsonParser jParser = new JsonParser();
 			payloadsonObj = jParser.parse(payload).getAsJsonObject();
 			alarmType = payloadsonObj.get("alarmType").getAsString();
 			log.info("#######" + alarmType);	// del
		} catch (Exception e) {
			log.info("### JSON paring error >> " + e);
			log.info("### error payload >> " + payload);
			return;
		}
		
		// 채팅 전송시 알람 내용
//		alarmType : "ALARM01",
//		alarmTitle : "EGGCHAT", 
//		alarmContent : chatAlarmContent,
//		referenceId : res.chatRoomNo,
//		referenceInfo : ""
		
		List<String> emplList; // 알람 insert할 사원 리스트
		
		// 채팅 알람
		if (alarmType.equals("ALARM01")) {
			log.info("### chat alarm > " + alarmType);
			log.info("##### 채팅 알람인지 구분했고 이제 전송한다." + payload); // del
			String chatRoomNo = payloadsonObj.get("referenceId").getAsString();
			log.info("##### 너가 조회할 채팅방 번호: " + chatRoomNo); // del
			emplList = service.selectAlarmUserForChat(chatRoomNo);
			sendAlramMessage(emplList, payload); // 전송
		}
		// /채팅 알람
		
		// 메일 알람
		if (alarmType.equals("ALARM02")) {
			log.info("### mail alarm > " + alarmType);
			String mailNo = payloadsonObj.get("referenceId").getAsString();
			emplList = service.selectAlarmUserForMail(mailNo);
			service.insertNewAlarm(emplList, payloadsonObj); // 알람 insert
			sendAlramMessage(emplList, payload); // 전송
		}
		// /메일 알람
		
		// 전자결재 알람
		if (alarmType.equals("ALARM03")) { 
			log.info("### aprv alarm > " + alarmType);
			String approvalId = payloadsonObj.get("referenceId").getAsString();
			emplList = service.selectAlarmUserForApproval(approvalId);
			service.insertNewAlarm(emplList, payloadsonObj); // 알람 insert
			sendAlramMessage(emplList, payload); // 전송
		}
		// /전자결재 알람
		
		// 다른 알람 유형은 아래에 추가
		
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		Map<String, Object> map = session.getAttributes();
		String emplId = ((CustomEmployeeVO) map.get("emplInfo")).getEmplId();
		sessionList.remove(session);
		log.info("{} alarm 소켓 연결 끊김.", emplId);
		
	}
	
	
	// 알람전송 메서드
	public void sendAlramMessage(List<String> emplList, String payload) throws Exception {
		for (WebSocketSession webSocketSession : sessionList) {
			for (String emplId : emplList) {
				String socketAccessEmplId = ((CustomEmployeeVO)webSocketSession.getAttributes().get("emplInfo")).getEmplId();
				if (socketAccessEmplId.equals(emplId)) { // session 접속자워 수신자가 일치할 때 전송
					webSocketSession.sendMessage(new TextMessage(payload));	// 이상하게 받아지면 여기가 문제일꺼야
				}
			}
		}
	}
	
}
