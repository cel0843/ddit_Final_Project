package kr.or.ddit.service.chat;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import kr.or.ddit.vo.CustomChatMsgVO;

public interface IChatService {
	public List<Map<String, Object>> selectChatRoomList(String emplId);
	public List<CustomChatMsgVO> selectChatByRoomNo(Map<String, String> map);
	public void insertChatMessage(CustomChatMsgVO chatMsg);
	public List<Map<String, Object>> selectEmplListOnChat(String emplId);
	// 소켓 접속 사원 조회, 추가, 삭제
	public List<String> getSocketAccessEmplList();
	public void addSocketAccessEmplList(List<String> emplList);
	public void clearSocketAccessEmplList();
	public int createChatRoom(Map<String, Object> map);
	public List<Map<String, Object>> selectEmplNotInChatroom(String chatRoomNo);
	public void addEmplToChatRoom(String chatRoomNo, String[] emplArr);
	public List<Map<String, Object>> selectEmplInChat(String chatRoomNo);
}
