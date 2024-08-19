package kr.or.ddit.controller.analytics;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.service.analytics.IAnalyticsService;
import kr.or.ddit.vo.SurveyVO;

@Controller
@RequestMapping("/admin/analytics")
public class AnalyticsController {
	
	@Inject
	private IAnalyticsService analyticsService;
	
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@GetMapping("/analyticsMain")
	public String analyticsMain(HttpServletRequest request, Model model, @RequestParam Map<String, Object> map) {
	    int emplTotalcnt = 0;
	    // 오늘 날짜 
	    LocalDate today = LocalDate.now();
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
	    DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("MM/dd/yyyy");
	    List<SurveyVO> monthlySurveyData;
	    List<Map<String, Object>> emplOfMonth = null;
	    List<Map<String, Object>> emplSuvyResList = null; 
	    String formattedDate;
	    String inputDate ="";
        String monthName = "";
        String yearMonth = "";
	    // date를 선택했을 때 데이터 변경 
	    if (map.containsKey("selectDate")) {
	        inputDate = map.get("selectDate").toString();
	        
	        LocalDate date = LocalDate.parse(inputDate, inputFormatter);
	        formattedDate = date.format(formatter);
	        yearMonth = date.format(DateTimeFormatter.ofPattern("yyyy-MM"));
	        monthName = ""+date.getMonth().getValue(); 
	    } else {
	        formattedDate = today.format(formatter);
		    yearMonth = today.format(DateTimeFormatter.ofPattern("yyyy-MM"));
	        monthName = ""+today.getMonth().getValue();
	    }
	    	
	    	monthlySurveyData = analyticsService.getMonthlySurveyData(yearMonth);
	    	
	    	
	    // 우수 회원 데이터 조회 
        if (monthlySurveyData != null && !monthlySurveyData.isEmpty()) {
            if (monthlySurveyData.get(0).getSurvNo()  !=  0) {
                emplOfMonth = analyticsService.getEmplOfMonth(monthlySurveyData.get(0).getSurvNo());
                emplSuvyResList = analyticsService.getResponCntSurvey(monthlySurveyData.get(0).getSurvNo());
                
                List<Map<String, String>> emplSuvyResListName = processEmplOfMonth(emplSuvyResList);
                model.addAttribute("emplSuvyResList", emplSuvyResListName);
                
                model.addAttribute("emplOfMonth", emplOfMonth);
                List<Map<String, String>> processedEmplOfMonth = processEmplOfMonth(emplOfMonth);
                model.addAttribute("processedEmplOfMonth", processedEmplOfMonth);
            }
        } else {
            model.addAttribute("error", "No survey data available for the selected date.");
        }
	    
	    Map<String, Object> projectAnalytics = analyticsService.getProjectAnalytics();
	    Map<String, Object> taskStatusCounts = analyticsService.getTaskStatusCounts();
	    double avgAttendanceRate = analyticsService.getAvgAttendanceRate(yearMonth);
	    int intAvgAttendanceRate = (int) avgAttendanceRate;
	    model.addAttribute("monthlySurveyData", monthlySurveyData);
	    model.addAttribute("avgAttendanceRate", intAvgAttendanceRate);
	    
	    
        // JSP에 데이터를 전달
        // 총 일감 개수와 상태 개수를 가져옴
        // 총 일감 개수와 상태 개수를 가져옴
        BigDecimal totalTasksBD = (BigDecimal) taskStatusCounts.get("TOTAL_TASKS");
        BigDecimal countTkst001BD = (BigDecimal) taskStatusCounts.get("COUNT_TKST001");
        BigDecimal countTkst002BD = (BigDecimal) taskStatusCounts.get("COUNT_TKST002");
        BigDecimal countTkst003BD = (BigDecimal) taskStatusCounts.get("COUNT_TKST003");

        int totalTasks = totalTasksBD.intValue();
        int countTkst001 = countTkst001BD.intValue();
        int countTkst002 = countTkst002BD.intValue();
        int countTkst003 = countTkst003BD.intValue();

        // 퍼센트 값을 계산함
        double percentTkst001 = (totalTasks > 0) ? Math.floor((double) countTkst001 / totalTasks * 100) : 0;
        double percentTkst002 = (totalTasks > 0) ? Math.floor((double) countTkst002 / totalTasks * 100) : 0;
        double percentTkst003 = (totalTasks > 0) ? Math.floor((double) countTkst003 / totalTasks * 100) : 0;

        // 퍼센트 값을 Map에 추가
        taskStatusCounts.put("totalTasks", totalTasks);
        taskStatusCounts.put("countTkst003", countTkst003);
        
        
        taskStatusCounts.put("PERCENT_TKST001", percentTkst001);
        taskStatusCounts.put("PERCENT_TKST002", percentTkst002);
        taskStatusCounts.put("PERCENT_TKST003", percentTkst003);

        // JSP에 데이터를 전달
        model.addAttribute("taskStatusCounts", taskStatusCounts);
	    
        // 프로젝트 통계 
        model.addAttribute("projectAnalytics", projectAnalytics);
	    
        // 선택 날짜 리턴
	    map.put("selectDate", formattedDate);
	    // 선택한 날짜의 사원수 
	    emplTotalcnt = analyticsService.selectEmplCnt(map);
	    // 한달 전 날짜 
	    String todayDateStr = today.format(formatter);
	    
	    Map<String, Object> map2 = new HashMap<>();
	    map2.put("selectDate", todayDateStr);
	    // 현재 사원 수 
	    int emplCurrentTotalCnt = analyticsService.selectEmplCnt(map2);
	    
	    Double iDRate = (emplTotalcnt == 0) ? 0 : ((emplTotalcnt - emplCurrentTotalCnt) / (double) emplTotalcnt) * 100;
	    iDRate = Math.round(iDRate * 100.0) / 100.0;
	    
        double serviceYear = analyticsService.getServiceYear();
        
        // DecimalFormat을 사용하여 소수점 둘째 자리까지 반올림
        DecimalFormat df = new DecimalFormat("#.##");
        double serviceManYear = Double.valueOf(df.format(serviceYear));
	    
	    model.addAttribute("serviceManYear", serviceManYear);
	    
	     List<Map<String, Object>> deadTasks = analyticsService.getDeadTaskList();
	     
	     	// 중요도 
	        Map<String, String> tkprCodeMap = new HashMap<>();
	        tkprCodeMap.put("TKPR001", "하급");
	        tkprCodeMap.put("TKPR002", "중급");
	        tkprCodeMap.put("TKPR003", "상급");

	        // deadTasks 리스트를 순회하면서 tkprWord 값을 매핑
	        for (Map<String, Object> deadTask : deadTasks) {
	            String tkprCode = (String) deadTask.get("TKPR_CODE");

	            // TKPR_CODE에 해당하는 tkprWord 값을 가져옴, 없을 경우 "알 수 없음"으로 설정
	            String tkprWord = tkprCodeMap.getOrDefault(tkprCode, "알 수 없음");

	            // tkprWord 값을 맵에 추가
	            deadTask.put("tkprWord", tkprWord);
	        }
	    
	     // deadTasks 리스트에 소요 시간 추가
	        for (Map<String, Object> deadTask : deadTasks) {
	            String taskBgngYmd = (String) deadTask.get("TASK_BGNG_YMD");
	            String taskMdfcnYmd = (String) deadTask.get("TASK_MDFCN_YMD");
	            String taskDdlnYmd = (String) deadTask.get("TASK_DDLN_YMD");
	            
	            // LocalDate로 변환
	            LocalDate startDate = LocalDate.parse(taskBgngYmd, formatter);
	            LocalDate ddlnDate = LocalDate.parse(taskDdlnYmd, formatter);
	            LocalDate mdfcnDate = LocalDate.parse(taskMdfcnYmd, formatter);
	            
	            // 두 날짜 간의 차이를 일 단위로 계산
	            long daysBetween = ChronoUnit.DAYS.between(startDate, mdfcnDate);
	            long daysTotalBetween = ChronoUnit.DAYS.between(startDate, ddlnDate);
	            
	            // 소요 시간을 deadTask에 추가
	            deadTask.put("totalDays", daysTotalBetween);
	            deadTask.put("complementDays", daysBetween);
	        }
	     
	     
	    
	    model.addAttribute("deadTasks", deadTasks);
        model.addAttribute("monthlySurveyData", monthlySurveyData);
	    model.addAttribute("inputDate", inputDate);
	    model.addAttribute("iDRate", iDRate);
	    model.addAttribute("emplTotalcnt", emplTotalcnt);
	    model.addAttribute("monthName", monthName);
	    return "admin/analytics/analytics";
	}
	
	// 우수 사원 관련 데이터 가공 메소드 
    private List<Map<String, String>> processEmplOfMonth(List<Map<String, Object>> emplOfMonth) {
        List<Map<String, String>> processedList = new ArrayList<>();
        for (Map<String, Object> map : emplOfMonth) {
            String userSur = (String) map.get("QITEM_CN");
            BigDecimal responseCount = (BigDecimal) map.get("RESPONSE_COUNT");
            String suvyresCnt = responseCount.toString();
            String[] list = userSur.split("-");
            if (list.length >= 2) {
                String userId = list[1].trim();
                String userName = list[0].trim();
                Map<String, String> userMap = new HashMap<>();
                
                userMap = analyticsService.getEmplInfo(userId);
                
                String positionCd = userMap.get("POSITION_CD");
                
                String position_nm;
                switch (positionCd) {
                    case "POSITION07":
                    	position_nm = "대표이사";
                        break;
                    case "POSITION06":
                    	position_nm = "부장";
                        break;
                    case "POSITION05":
                    	position_nm = "차장";
                        break;
                    case "POSITION04":
                    	position_nm = "과장";
                        break;
                    case "POSITION03":
                    	position_nm = "대리";
                        break;
                    case "POSITION02":
                    	position_nm = "사원";
                        break;
                    case "POSITION01":
                    	position_nm = "인턴";
                        break;
                    default:
                    	position_nm = "직위 없음";
                        break;
                }
                userMap.put("position_nm", position_nm);
                userMap.put("suvyres_cnt", suvyresCnt);
                processedList.add(userMap);
            }
        }
        return processedList;
    }
	
	
}
