package kr.or.ddit.controller;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.service.IWorkService;
import kr.or.ddit.vo.CustomEmployeeVO;
import kr.or.ddit.vo.WorkVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@Component
@RequestMapping("/egg")
public class WorkController {

	@Inject
	private IWorkService service;

	// 매일 23시 59분마다 실행
	@Scheduled(cron = "59 59 23 * * *")
	public void test() {
		log.info("비 출근자 insert완료~!!!!!!!");
		service.workNullCheckIn();
	}
	
	// 출근버튼 눌렀을때 실행되는 메서드
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@RequestMapping(value = "/workStart", method = RequestMethod.GET)
	public ResponseEntity<String> workStart(@RequestParam String emplId, @RequestParam String startTime){
		service.startWorkChk(emplId, startTime);
		
		return new ResponseEntity<String>(startTime, HttpStatus.OK);
	}
	
	// 퇴근버튼 눌렀을때 실행되는 메서드
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@RequestMapping(value = "/workEnd", method = RequestMethod.GET)
	public ResponseEntity<String> workEnd(@RequestParam String emplId, @RequestParam String endTime){
		
		service.endWorkChk(emplId);
		
		return new ResponseEntity<String>(endTime, HttpStatus.OK);
	}
	
	
//	next, prev 버튼 누를때  비동기로 데이터를 전달하는 메서드.
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@RequestMapping(value = "/workMonthInfo", method = RequestMethod.GET)
	public ResponseEntity<Map<String, List<WorkVO>>> workMonthInfo(@RequestParam String month, HttpServletRequest request){
		
		HttpSession session = request.getSession();
		CustomEmployeeVO emplInfo = (CustomEmployeeVO) session.getAttribute("emplInfo");
		String emplId = emplInfo.getEmplId();
		
		if (month == null) {
			month = String.format("%02d", LocalDate.now().getMonthValue());
		}
		if(month.length()==1) {
			month = "0"+ month;
		}
		
		List<WorkVO> workList = service.weekListSelect(emplId, month);

		for(int i =0; i<workList.size(); i++) {
			double timeChk = Double.parseDouble(workList.get(i).getWorkBgngHr().substring(11, 13));
			double timeChk1 = Double.parseDouble(workList.get(i).getWorkBgngHr().substring(14, 16));

			if(Double.parseDouble(workList.get(i).getWorkDayHours()) == 0.0) {
				workList.get(i).setWorkState("결근");	
			}else {
				workList.get(i).setWorkState("정상");
			}
			if (timeChk >= 9.0 && timeChk1 > 0.0) {
				workList.get(i).setWorkState("지각");
			}
		}
		
		List<WorkVO> hdList = service.hdList(emplId);
		for (WorkVO hd : hdList) {
			for (WorkVO day : workList) {
				int sYear = Integer.parseInt(hd.getHdBgngHr().substring(0, 4));
				int sMon = Integer.parseInt(hd.getHdBgngHr().substring(5, 7));
				int sDay = Integer.parseInt(hd.getHdBgngHr().substring(8, 10));

				int eYear = Integer.parseInt(hd.getHdEndHr().substring(0, 4));
				int eMon = Integer.parseInt(hd.getHdEndHr().substring(5, 7));
				int eDay = Integer.parseInt(hd.getHdEndHr().substring(8, 10));

				LocalDate startDate = LocalDate.of(sYear, sMon, sDay);
				LocalDate endDate = LocalDate.of(eYear, eMon, eDay);

				// 시작 날짜와 끝 날짜 사이의 일 수 계산
				long daysBetween = ChronoUnit.DAYS.between(startDate, endDate);

				// for 루프를 사용하여 날짜 반복
				for (int i = 0; i <= daysBetween; i++) {
					LocalDate currentDate = startDate.plusDays(i);
					String strCurDate = String.valueOf(currentDate);
					// 현재 날짜 출력
					if ((day.getWorkBgngHr().substring(0, 10)).equals(strCurDate)) {
						day.setWorkState("휴가");
						if(Double.parseDouble(day.getWorkDayHours()) != 0) {
							day.setWorkState("반차");
							int startHour = Integer.parseInt(day.getWorkBgngHr().substring(11, 13));
							int startMin = Integer.parseInt(day.getWorkBgngHr().substring(14, 16));
							if(       (startHour == 13 || startHour == 9) && (startMin > 0)     ) {
								day.setWorkState("반차, 지각");
							}
						}
					}

				}

			}
		}
		Map<String, List<WorkVO>> groupedByWeek = workList.stream().collect(Collectors.groupingBy(WorkVO::getNumWeek));
		groupedByWeek.forEach((key, value) -> System.out.println(key + " -> " + value));
		return new ResponseEntity<Map<String, List<WorkVO>>>(groupedByWeek, HttpStatus.OK);
	}

	// 동기방식 처음 근태리스트 화면 현재 월로 가져오는 메서드.
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@RequestMapping(value = "/work", method = RequestMethod.GET)
	public String work(HttpServletRequest request, Model model, @RequestParam(value = "month", required = false) String month) {
		HttpSession session = request.getSession();
		CustomEmployeeVO emplInfo = (CustomEmployeeVO) session.getAttribute("emplInfo");
		String emplId = emplInfo.getEmplId();
		
		if (month == null) {
			month = String.format("%02d", LocalDate.now().getMonthValue());
		}
		if(month.length()==1) {
			month = "0"+ month;
		}
		
		List<WorkVO> workList= service.workInfo(emplId, month);
		model.addAttribute("workList", workList);
		
		
		List<WorkVO> hdList = service.hdList(emplId);
		
		double sum = 0;
		for (int i = 0; i < workList.size(); i++) {
			double weekTime = Double.parseDouble(workList.get(i).getWorkWeekHours());
			if (i == workList.size() - 1) {
				if (weekTime > 45.0) {
					double overTime = weekTime - 45;
					String weekOverTime = convertTime(overTime);
					model.addAttribute("weekOverTime", weekOverTime);
				} else {
					model.addAttribute("weekOverTime", "0h 0m 0s");
				}
				String wTime = convertTime(weekTime);
				model.addAttribute("weekTime", wTime);
			}
			sum += weekTime;
		}
		
		if (sum > 209) {
			String monthOverTime = convertTime(sum - 209);
			model.addAttribute("monthOverTime", monthOverTime);
		} else {
			model.addAttribute("monthOverTime", "0h 0m 0s");
		}
		
		String monthTime = convertTime(sum);
		model.addAttribute("monthTime", monthTime);
		
		int currentMonth = Integer.parseInt(month);
		model.addAttribute("currentMonth", currentMonth);
		
		List<WorkVO> weekList = service.weekListSelect(emplId, month);
		

		
	
		for (int i = 0; i < weekList.size(); i++) {
			double oneDayHours = Double.parseDouble(weekList.get(i).getWorkDayHours());
			if (oneDayHours > 9.0) {
				weekList.get(i).setOverTime(convertTime(oneDayHours - 9.0));
			}
			double oneDayWorkTime = Double.parseDouble(weekList.get(i).getWorkDayHours());
			weekList.get(i).setWorkDayHours(convertTime(oneDayWorkTime));
			String str = weekList.get(i).getWorkBgngHr();
			String substr = str.substring(11, 13);
			String substr1 = str.substring(14, 16);
	
			int subtime = Integer.parseInt(substr);
			int subtime1 = Integer.parseInt(substr1);
			
			if (subtime >= 9 && subtime1 > 0) {
				weekList.get(i).setWorkState("지각");
			} else {
				if(weekList.get(i).getWorkDayHours().equals("0h 0m 0s")) {
					weekList.get(i).setWorkState("결근");
				}else {
					weekList.get(i).setWorkState("정상");
				}
			}
			
			// 출근 찍고 퇴근 안찍었을때!!!!!!!!!   시간처리
			if(weekList.get(i).getWorkDayHours().substring(0,1).equals("-")) {
				weekList.get(i).setWorkDayHours(convertTime(0));
				weekList.get(i).setWorkState("결근");
			}
		}

		for (WorkVO hd : hdList) {
			for (WorkVO day : weekList) {
				int sYear = Integer.parseInt(hd.getHdBgngHr().substring(0, 4));
				int sMon = Integer.parseInt(hd.getHdBgngHr().substring(5, 7));
				int sDay = Integer.parseInt(hd.getHdBgngHr().substring(8, 10));

				int eYear = Integer.parseInt(hd.getHdEndHr().substring(0, 4));
				int eMon = Integer.parseInt(hd.getHdEndHr().substring(5, 7));
				int eDay = Integer.parseInt(hd.getHdEndHr().substring(8, 10));

				LocalDate startDate = LocalDate.of(sYear, sMon, sDay);
				LocalDate endDate = LocalDate.of(eYear, eMon, eDay);

				// 시작 날짜와 끝 날짜 사이의 일 수 계산
				long daysBetween = ChronoUnit.DAYS.between(startDate, endDate);

				// for 루프를 사용하여 날짜 반복
				for (int i = 0; i <= daysBetween; i++) {
					LocalDate currentDate = startDate.plusDays(i);
					String strCurDate = String.valueOf(currentDate);
					// 현재 날짜 출력
					if ((day.getWorkBgngHr().substring(0, 10)).equals(strCurDate)) {
						day.setWorkState("휴가");
						if(!day.getWorkDayHours().equals("0h 0m 0s")) {
							day.setWorkState("반차");
							int startHour = Integer.parseInt(day.getWorkBgngHr().substring(11, 13));
							int startMin = Integer.parseInt(day.getWorkBgngHr().substring(14, 16));
							if(       (startHour == 13 || startHour == 9) && (startMin > 0)     ) {
								day.setWorkState("반차, 지각");
							}
						}
					}

				}

			}
		}

		Map<String, List<WorkVO>> groupedByWeek = weekList.stream().collect(Collectors.groupingBy(WorkVO::getNumWeek));
		model.addAttribute("groupedByWeek", groupedByWeek);
		return "egg/work/work";
	}
	
	// 근무 시간을 h m s로 변환해주는 메소드
	public String convertTime(double timeInHours) {
		int hours = (int) timeInHours;
		double fractionalHour = timeInHours - hours;
		int minutes = (int) (fractionalHour * 60);
		double fractionalMinute = (fractionalHour * 60) - minutes;
		int seconds = (int) (fractionalMinute * 60);

		return hours + "h " + minutes + "m " + seconds + "s";
	}
}
