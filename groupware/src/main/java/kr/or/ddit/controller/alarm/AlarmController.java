package kr.or.ddit.controller.alarm;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.service.alarm.IAlarmService;
import kr.or.ddit.vo.AlarmVO;
import kr.or.ddit.vo.CustomEmployeeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/egg")
public class AlarmController {
	
	@Inject
	private IAlarmService service;
	
	@RequestMapping(value = "/selectUnreadAlaramCount", method = RequestMethod.GET)
	public ResponseEntity<String> selectUnreadAlaramCount(HttpServletRequest request){
		HttpSession session = request.getSession();
		String emplId = ((CustomEmployeeVO)request.getSession().getAttribute("emplInfo")).getEmplId();
		int unreadAlarmCount = 0;
		unreadAlarmCount = service.selectUnreadAlaramCount(emplId);
		log.info("안읽은 메세지 갯수" + unreadAlarmCount);
		session.setAttribute("existedAlarm", false); // del
		String existedAlarm = "";
		if (unreadAlarmCount > 0) { 
			log.info("알람이 존재합니다"); // del
			session.setAttribute("existedAlarm", true); // del
			existedAlarm = "true";
		} 
		return ResponseEntity.ok(existedAlarm);
	}
	
	@RequestMapping(value = "/selectAlarmListByEmplNo", method = RequestMethod.GET)
	public ResponseEntity<List<AlarmVO>> selectAlarmListByEmplNo(HttpServletRequest request){
		HttpSession session = request.getSession();
		String emplId = ((CustomEmployeeVO)request.getSession().getAttribute("emplInfo")).getEmplId();
		List<AlarmVO> alarmList = service.selectAlarmListByEmplNo(emplId);
		int unreadAlarmCount = 0;
		unreadAlarmCount = service.selectUnreadAlaramCount(emplId);
		session.setAttribute("existedAlarm", false);
		if (unreadAlarmCount > 0) {
			log.info("알람이 존재합니다");
			session.setAttribute("existedAlarm", true);
		}
		service.updateAlarmReadYN(emplId);
		return ResponseEntity.ok(alarmList);
	}
	
	@RequestMapping(value = "/clearAllAlarm", method = RequestMethod.GET)
	public ResponseEntity<String> clearAllAlarm(HttpServletRequest request){
		HttpSession session = request.getSession();
		String emplId = ((CustomEmployeeVO)request.getSession().getAttribute("emplInfo")).getEmplId();
		
		int clearAlarmCount = 0;
		clearAlarmCount = service.clearAllAlarm(emplId);
		String clearStatus = "";
		if (clearAlarmCount > 0) {
			clearStatus = "success";
		}
		service.updateAlarmReadYN(emplId);
		return ResponseEntity.ok(clearStatus);
	}
	
}
