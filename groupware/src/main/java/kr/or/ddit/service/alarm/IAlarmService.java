package kr.or.ddit.service.alarm;

import java.util.List;

import com.google.gson.JsonObject;

import kr.or.ddit.vo.AlarmVO;

public interface IAlarmService {

	public List<AlarmVO> selectAlarmListByEmplNo(String emplId);
	public int selectUnreadAlaramCount(String emplId);
	public int updateAlarmReadYN(String emplId);
	public int clearAllAlarm(String emplId);
	public void insertNewAlarm(List<String> emplList, JsonObject payloadsonObj);
	
	public List<String> selectAlarmUserForChat(String chatRoomNo);
	public List<String> selectAlarmUserForMail(String mailNo);
	public List<String> selectAlarmUserForApproval(String approvalId);
	
}
