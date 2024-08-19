package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.ProjectTaskVO;

public interface ITaskMapper {
	List<ProjectTaskVO> getTaskListByProject(Map<String, Object> params);

	int updateTaskStatus(Map<String, Object> params);

	int updateTaskDetail(ProjectTaskVO projectTaskVO);

	List<Map<String, Object>> getTasks();

	List<Map<String, Object>> selectTasksDay(ProjectTaskVO projectTaskVO);

	List<Map<String, Object>> selectTaskList(Map<String, Object> params);

	int getTaskCount(Map<String, Object> params);

	int insertTask(ProjectTaskVO projectTaskVO);

	ProjectTaskVO selectTaskDetail(int taskNo);

	List<ProjectTaskVO> selectTaskGantChart(int projNo);

}
