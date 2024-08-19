package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.SurveyVO;

public interface IAnalyticsMapper {

	int selectEmplCnt(Map<String, Object> map);

	List<SurveyVO> getMonthlySurveyData(String yearMonth);

	List<Map<String, Object>> getEmplOfMonth(int survNo);

	Map<String, Object> getProjectAnalytics();

	Map<String, Object> getTaskStatusCounts();

	Map<String, String> getEmplInfo(String userId);

	List<Map<String, Object>> getSurvEmplData(int survNo);

	List<Map<String, Object>> getResponCntSurvey(int survNo);

	Double getServiceYear();

	List<Map<String, Object>> getDeadTaskList();

	double getAvgAttendanceRate(String yearMonth);

}
