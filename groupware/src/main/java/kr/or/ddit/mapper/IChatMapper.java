package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.ChatRoomVO;
import kr.or.ddit.vo.CustomChatMsgVO;

public interface IChatMapper {

	public List<Map<String, Object>> selectChatRoomList(String emplId);
	public List<CustomChatMsgVO> selectChatByRoomNo(Map<String, String> map);
	public int insertChatFile(CustomChatMsgVO chatMsg);
	public int insertChatMessage(CustomChatMsgVO chatMsg);
	public int updateLastReadedMessage(CustomChatMsgVO chatMsg);
	public List<Map<String, Object>> selectEmplListOnChat(String emplId);
	public void createChatRoom(ChatRoomVO chatRoomVO);
	public void insertChatMember(Map<String, Object> chatRoomJoinMap);
	public List<Map<String, Object>> selectEmplNotInChatroom(String chatRoomNo);
	public List<Map<String, Object>> selectEmplInChat(String chatRoomNo);
	public void updateRecentMessage(Map<String, String> map);
}
