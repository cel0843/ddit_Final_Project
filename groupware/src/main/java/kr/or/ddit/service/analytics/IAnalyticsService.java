package kr.or.ddit.service.analytics;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.SurveyVO;

public interface IAnalyticsService {
	
	/**
	 * 전체 사원수
	 * @param map
	 * @return int 
	 */
	int selectEmplCnt(Map<String, Object> map);
	
	/**
	 * 월  데이터
	 * @param yearMonth
	 * @return List
	 */
	List<SurveyVO> getMonthlySurveyData(String yearMonth);
	
	/**
	 * 월별 총 사원 데이터
	 * @param survNo
	 * @return List
	 */
	List<Map<String, Object>> getEmplOfMonth(int survNo);
	
	/**
	 * 프로젝트 통계
	 * @return	Map
	 */
	Map<String, Object> getProjectAnalytics();
	
	/**
	 * 상태별 업무 조회 
	 * @return Map
	 */
	Map<String, Object> getTaskStatusCounts();
	
	/**
	 * 해당 사원 정보 조회  
	 * @param userId
	 * @return Map
	 */
	Map<String, String> getEmplInfo(String userId);
	
	/**
	 * 
	 * @param survNo
	 * @return List
	 */
	List<Map<String, Object>> getSurvEmplData(int survNo);

	/**
	 * 설문 문항 응답 카운트 
	 * @param survNo
	 * @return list
	 */
	List<Map<String, Object>> getResponCntSurvey(int survNo);
	
	/**
	 * 근속년수 
	 * @return Double
	 */
	Double getServiceYear();
	
	/**
	 * 마감 업무 개수 
	 * @return 진행률 100, 마감상태 
	 */
	List<Map<String, Object>> getDeadTaskList();
	
	/**
	 * 평균 출석률 
	 * @param yearMonth
	 * @return double
	 */
	double getAvgAttendanceRate(String yearMonth);

}
