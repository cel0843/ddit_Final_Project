package kr.or.ddit.service.project;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.ProjectPrtcpVO;
import kr.or.ddit.vo.ProjectScheduleVO;
import kr.or.ddit.vo.ProjectTaskVO;
import kr.or.ddit.vo.ProjectsVO;

public interface IProjectService {
	
	/**
	 * 참여한 프로젝트 리스트 조회
	 * @param projectPrtcpVO
	 * @return
	 */
	public List<ProjectsVO> projectList(ProjectPrtcpVO projectPrtcpVO);
	
	/**
	 * 상태별 일감 조회
	 * @param projNo
	 * @param status
	 * @param emplId
	 * @return
	 */
	public List<ProjectTaskVO> getTaskListByProject(int projNo, String status, String emplId);
	
	/**
	 * 일감 상태 업데이트 
	 * @param taskId
	 * @param status
	 * @param mdfcnYmd
	 * @return
	 */
	public int updateTaskStatus(int taskId, String status, String mdfcnYmd);
	
	/**
	 * 일감 상세 수정 
	 * @param projectTaskVO
	 * @return
	 */
	public int updateTaskDetail(ProjectTaskVO projectTaskVO);
	
	/**
	 * 일감 날짜 조회 
	 * @param projectTaskVO
	 * @return
	 */
	public List<Map<String, Object>> selectTasksDay(ProjectTaskVO projectTaskVO);
	
	/**
	 * 일감리스트 조회 
	 * @param params
	 * @return
	 */
	public List<Map<String, Object>> selectTaskList(Map<String, Object> params);
	
	/**
	 * 일감 개수 카운트 
	 * @param params
	 * @return
	 */
	public int getTaskCount(Map<String, Object> params);
	
	/**
	 * 프로젝트 사용자 권한 체크 
	 * @param projectPrtcpVO
	 * @return
	 */
	public ProjectPrtcpVO authCheck(ProjectPrtcpVO projectPrtcpVO);
	
	/**
	 * 프로젝트 참가자 리스트 조회
	 * @param projectPrtcpVO
	 * @return
	 */
	public List<Map<String, Object>> projPrtcpList(ProjectPrtcpVO projectPrtcpVO);
	
	/**
	 * 일감 등록 
	 * @param projectTaskVO
	 * @return
	 */
	public int insertTask(ProjectTaskVO projectTaskVO);
	
	/**
	 * 일감 상세 조회 
	 * @param taskNo
	 * @return
	 */
	public ProjectTaskVO selectTaskDetail(int taskNo);
	
	/**
	 * 참여 프로젝트 일정 조회
	 * @param projNo
	 * @return
	 */
	public List<Map<String, Object>> selectScheduleList(int projNo);

	/**
	 * 간트차트 용 업무 조회 
	 * @param projNo
	 * @return
	 */
	public List<ProjectTaskVO> selectTaskGantChart(int projNo);
	
	/**
	 * 기한지난 마감 업데이트  
	 * @return
	 */
	public int updateDeadLine();
	
	/**
	 * 마감 프로젝트 조회 
	 * @param projectPrtcpVO
	 * @return
	 */
	public List<ProjectsVO> projectDeadList(ProjectPrtcpVO projectPrtcpVO);

}
