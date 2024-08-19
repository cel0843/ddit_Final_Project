package kr.or.ddit.service.project;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.IScheduleMapper;
import kr.or.ddit.vo.ProjectScheduleVO;

@Service
public class ScheduleServiceImpl implements IScheduleService {
	
	@Inject
	private IScheduleMapper scheduleMapper;
	
	
	@Override
	public List<ProjectScheduleVO> scheduleList(int projNo) {

		return scheduleMapper.scheduleList(projNo);
	}


	@Override
	public int insertSchedul(ProjectScheduleVO projectScheduleVO) {
		return scheduleMapper.insertSchedul(projectScheduleVO);
	}


	@Override
	public int updateSchedul(ProjectScheduleVO schedule) {
		return scheduleMapper.updateSchedul(schedule);
	}


	@Override
	public void deleteSchedul(int projSchdlNo) {
		scheduleMapper.deleteSchedul(projSchdlNo);
	}


	@Override
	public int updateDateSchedul(ProjectScheduleVO schedule) {
		return scheduleMapper.updateDateSchedul(schedule);
	}
	
}
