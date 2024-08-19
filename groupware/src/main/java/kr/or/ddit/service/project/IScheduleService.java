package kr.or.ddit.service.project;

import java.util.List;

import kr.or.ddit.vo.ProjectScheduleVO;

public interface IScheduleService {
	/**
	 * 프로젝트 일정 리스트 조회
	 * @param projNo
	 * @return
	 */
	List<ProjectScheduleVO> scheduleList(int projNo);
	
	/**
	 *  프로젝트 일정 리스트 등록
	 * @param projectScheduleVO
	 * @return
	 */
	int insertSchedul(ProjectScheduleVO projectScheduleVO);

	/**
	 *  프로젝트 일정 수정 
	 * @param projectScheduleVO
	 * @return
	 */
	int updateSchedul(ProjectScheduleVO schedule);

	/**
	 *  프로젝트 일정 삭제
	 * @param projectScheduleVO
	 * @return
	 */
	void deleteSchedul(int projSchdlNo);

	/**
	 *  프로젝트 일정 날짜 수정
	 * @param projectScheduleVO
	 * @return
	 */
	int updateDateSchedul(ProjectScheduleVO schedule);

}
