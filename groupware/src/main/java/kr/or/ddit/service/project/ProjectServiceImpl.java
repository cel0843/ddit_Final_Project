package kr.or.ddit.service.project;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.IProjectMapper;
import kr.or.ddit.mapper.IScheduleMapper;
import kr.or.ddit.mapper.ITaskMapper;
import kr.or.ddit.vo.ProjectPrtcpVO;
import kr.or.ddit.vo.ProjectTaskVO;
import kr.or.ddit.vo.ProjectsVO;

@Service
public class ProjectServiceImpl implements IProjectService {
	@Inject
	private IProjectMapper projectMapper;

	@Inject
	private ITaskMapper taskMapper;
	

	// 프로젝트 메인 프로젝트 리스트
	@Override
	public List<ProjectsVO> projectList(ProjectPrtcpVO projectPrtcpVO) {

		return projectMapper.projectList(projectPrtcpVO);
	}

	// 프로젝트 상태별, 내 업무 리스트 
	@Override
	public List<ProjectTaskVO> getTaskListByProject(int projNo, String status, String empl) {
		Map<String, Object> params = new HashMap<>();
		params.put("projNo", projNo);
		params.put("status", status);
		params.put("emplId", empl);

		return taskMapper.getTaskListByProject(params);
	}

	@Override
	public int updateTaskStatus(int taskId, String tkstCode, String taskMdfcnYmd) {
        Map<String, Object> params = new HashMap<>();
        params.put("taskNo", taskId);
        params.put("tkstCode", tkstCode);
        params.put("taskMdfcnYmd", taskMdfcnYmd);
        int status = taskMapper.updateTaskStatus(params);
        
        return status;
    }

	@Override
	public int updateTaskDetail(ProjectTaskVO projectTaskVO) {
		
		
		int status = taskMapper.updateTaskDetail(projectTaskVO);
		return status;
	}


	@Override
	public List<Map<String, Object>> selectTasksDay(ProjectTaskVO projectTaskVO) {
		
		return taskMapper.selectTasksDay(projectTaskVO);
	}

	@Override
	public List<Map<String, Object>> selectTaskList(Map<String, Object> params) {
		
		return taskMapper.selectTaskList(params);
	}

	@Override
	public int getTaskCount(Map<String, Object> params) {
		
		return taskMapper.getTaskCount(params);
	}

	@Override
	public ProjectPrtcpVO authCheck(ProjectPrtcpVO projectPrtcpVO) {
		return projectMapper.authCheck(projectPrtcpVO);
	}

	@Override
	public List<Map<String, Object>> projPrtcpList(ProjectPrtcpVO projectPrtcpVO) {

		return projectMapper.projPrtcpList(projectPrtcpVO);
	}

	@Override
	public int insertTask(ProjectTaskVO projectTaskVO) {

		return taskMapper.insertTask(projectTaskVO);
	}

	@Override
	public ProjectTaskVO selectTaskDetail(int taskNo) {
		
		return taskMapper.selectTaskDetail(taskNo);
	}

	@Override
	public List<Map<String, Object>> selectScheduleList(int projNo) {

		return projectMapper.selectScheduleList(projNo);
	}

	@Override
	public List<ProjectTaskVO> selectTaskGantChart(int projNo) {

		return taskMapper.selectTaskGantChart(projNo);
	}

	@Override
	public int updateDeadLine() {
		return projectMapper.updateDeadLine();
	}

	@Override
	public List<ProjectsVO> projectDeadList(ProjectPrtcpVO projectPrtcpVO) {
		
		return projectMapper.projectDeadList(projectPrtcpVO);
	}

}
