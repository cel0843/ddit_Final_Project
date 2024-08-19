package kr.or.ddit.service.chat;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.IChatMapper;
import kr.or.ddit.vo.ChatRoomVO;
import kr.or.ddit.vo.CustomChatMsgVO;

@Service
public class ChatServiceImpl implements IChatService {
	
	List<String> socketAccessEmplList;

	@Inject
	private IChatMapper mapper;

	// 채팅방 select
	@Override
	public List<Map<String, Object>> selectChatRoomList(String emplId) {
		return mapper.selectChatRoomList(emplId);
	}

	// 채팅 select
	@Override
	public List<CustomChatMsgVO> selectChatByRoomNo(Map<String, String> map) {
		mapper.updateRecentMessage(map);
		return mapper.selectChatByRoomNo(map);
	}

	// 채팅 insert
	@Override
	public void insertChatMessage(CustomChatMsgVO chatMsg) {
		if (chatMsg.getChatMsgType() == "MSG_03") {
			mapper.insertChatFile(chatMsg);
		}
		mapper.insertChatMessage(chatMsg);
		mapper.updateLastReadedMessage(chatMsg);
	}

	@Override
	public List<Map<String, Object>> selectEmplListOnChat(String emplId) {
		return mapper.selectEmplListOnChat(emplId);
	}
	
	// 소켓접속 리스트 관련 메서드-----------------------------------------------------------
	@Override
	public void addSocketAccessEmplList(List<String> emplList) {
		socketAccessEmplList = emplList;
		for (String stst : emplList) {
		}
	}
	
	@Override
	public void clearSocketAccessEmplList() {
		if (socketAccessEmplList != null) {
			socketAccessEmplList.clear();
		}
	}

	@Override
	public List<String> getSocketAccessEmplList() {
		return socketAccessEmplList;
	}
	// 소켓접속 리스트 관련 메서드-----------------------------------------------------------

	// 채팅방 생성
	@Override
	public int createChatRoom(Map<String, Object> map) {
		// 채팅방 create
		ChatRoomVO chatRoomVO = (ChatRoomVO) map.get("chatRoomVO");
		mapper.createChatRoom(chatRoomVO);
		
		// 채팅방 유저 insert
		Map<String, Object> chatRoomJoinMap = new HashMap<String, Object>();
		int chatRoomNo = chatRoomVO.getChatRoomNo();
		
		// 채팅방 유저 insert
		chatRoomJoinMap.put("chatRoomNo", chatRoomNo);
		chatRoomJoinMap.put("emplId", map.get("firstEmplId"));
		mapper.insertChatMember(chatRoomJoinMap);
		
		// 채팅방 유저 insert
		chatRoomJoinMap.put("emplId", map.get("secondEmplId"));
		mapper.insertChatMember(chatRoomJoinMap);
		
		return chatRoomNo;
	}

	@Override
	public List<Map<String, Object>> selectEmplNotInChatroom(String chatRoomNo) {
		return mapper.selectEmplNotInChatroom(chatRoomNo);
	}

	@Override
	public void addEmplToChatRoom(String chatRoomNo, String[] emplArr) {
		Map<String, Object> chatRoomJoinMap = new HashMap<String, Object>();
		chatRoomJoinMap.put("chatRoomNo", chatRoomNo);
		for (String emplId : emplArr) {
			chatRoomJoinMap.put("emplId", emplId);
			mapper.insertChatMember(chatRoomJoinMap);
		}
	}

	@Override
	public List<Map<String, Object>> selectEmplInChat(String chatRoomNo) {
		return mapper.selectEmplInChat(chatRoomNo);
	}
	
	
}
