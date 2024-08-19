package kr.or.ddit.service.alarm;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.google.gson.JsonObject;

import kr.or.ddit.mapper.IAlarmMapper;
import kr.or.ddit.vo.AlarmVO;

@Service
public class AlarmServiceImpl implements IAlarmService {
	
	@Inject
	private IAlarmMapper mapper;

	@Override
	public List<AlarmVO> selectAlarmListByEmplNo(String emplId) {
		return mapper.selectAlarmListByEmplNo(emplId);
	}

	@Override
	public int selectUnreadAlaramCount(String emplId) {
		return mapper.selectUnreadAlaramCount(emplId);
	}

	@Override
	public int updateAlarmReadYN(String emplId) {
		return mapper.updateAlarmReadYN(emplId);
	}

	@Override
	public int clearAllAlarm(String emplId) {
		return mapper.clearAllAlarm(emplId);
	}
	
	@Override
	public void insertNewAlarm(List<String> emplList, JsonObject payloadsonObj) {
		AlarmVO alarmVO = new AlarmVO();
		alarmVO.setAlarmConts(payloadsonObj.get("alarmContent").getAsString());
		alarmVO.setAlarmTitle(payloadsonObj.get("alarmTitle").getAsString());
		alarmVO.setAlarmTyCd(payloadsonObj.get("alarmType").getAsString());
		for (String emplId : emplList) {
			alarmVO.setEmplId(emplId);
			System.out.println("보내는 alarmVO : " + alarmVO);
			mapper.insertNewAlarm(alarmVO);
		}
	}
	

	// 채팅받는 사원 리스트 조회
	@Override
	public List<String> selectAlarmUserForChat(String chatRoomNo) {
		return mapper.selectAlarmUserForChat(chatRoomNo);
	}

	@Override
	public List<String> selectAlarmUserForMail(String mailNo) {
		return mapper.selectAlarmUserForMail(mailNo);
	}

	@Override
	public List<String> selectAlarmUserForApproval(String approvalId) {
		return mapper.selectAlarmUserForApproval(approvalId);
	}

}
