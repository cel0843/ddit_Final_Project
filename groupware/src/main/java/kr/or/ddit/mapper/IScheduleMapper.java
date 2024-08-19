package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.vo.ProjectScheduleVO;

public interface IScheduleMapper {

	List<ProjectScheduleVO> scheduleList(int projNo);

	int insertSchedul(ProjectScheduleVO projectScheduleVO);

	int updateSchedul(ProjectScheduleVO schedule);

	int deleteSchedul(int projSchdlNo);

	int updateDateSchedul(ProjectScheduleVO schedule);
	
}
