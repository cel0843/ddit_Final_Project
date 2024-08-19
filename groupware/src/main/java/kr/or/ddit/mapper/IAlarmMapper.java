package kr.or.ddit.mapper;

import java.util.List;

import com.google.gson.JsonObject;

import kr.or.ddit.vo.AlarmVO;

public interface IAlarmMapper {

	public List<AlarmVO> selectAlarmListByEmplNo(String emplId);
	public int selectUnreadAlaramCount(String emplId);
	public int updateAlarmReadYN(String emplId);
	public int clearAllAlarm(String emplId);
	public int getAlarmNo();
	public int insertNewAlarm(AlarmVO alarmVO);
	
	public List<String> selectAlarmUserForChat(String chatRoomNo);
	public List<String> selectAlarmUserForMail(String mailNo);
	public List<String> selectAlarmUserForApproval(String approvalId);
}
