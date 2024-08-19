package kr.or.ddit.service.analytics;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.IAnalyticsMapper;
import kr.or.ddit.vo.SurveyVO;

@Service
public class AnalyticsServiceImpl implements IAnalyticsService {
	
	@Inject
	private IAnalyticsMapper mapper; 
	
	@Override
	public int selectEmplCnt(Map<String, Object> map) {
		return mapper.selectEmplCnt(map);
	}

	@Override
	public List<SurveyVO> getMonthlySurveyData(String yearMonth) {
		return mapper.getMonthlySurveyData(yearMonth);
	}

	@Override
	public List<Map<String, Object>> getEmplOfMonth(int survNo) {
		return mapper.getEmplOfMonth(survNo);
	}

	@Override
	public Map<String, Object> getProjectAnalytics() {
		return mapper.getProjectAnalytics();
	}

	@Override
	public Map<String, Object> getTaskStatusCounts() {
		return mapper.getTaskStatusCounts();
	}

	@Override
	public Map<String, String> getEmplInfo(String userId) {
		return mapper.getEmplInfo(userId);
	}

	@Override
	public List<Map<String, Object>> getSurvEmplData(int survNo) {
		return mapper.getSurvEmplData(survNo);
	}

	@Override
	public List<Map<String, Object>> getResponCntSurvey(int survNo) {
		return mapper.getResponCntSurvey(survNo);
	}

	@Override
	public Double getServiceYear() {
		return mapper.getServiceYear();
	}

	@Override
	public List<Map<String, Object>> getDeadTaskList() {
		return mapper.getDeadTaskList();
	}

	@Override
	public double getAvgAttendanceRate(String yearMonth) {
		// TODO Auto-generated method stub
		return mapper.getAvgAttendanceRate(yearMonth);
	}

}
