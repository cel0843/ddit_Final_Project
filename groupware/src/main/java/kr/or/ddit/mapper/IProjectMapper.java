package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.ProjectPrtcpVO;
import kr.or.ddit.vo.ProjectTaskVO;
import kr.or.ddit.vo.ProjectsVO;

public interface IProjectMapper {
	public List<ProjectsVO> projectList(ProjectPrtcpVO projectPrtcpVO);

	public ProjectPrtcpVO authCheck(ProjectPrtcpVO projectPrtcpVO);

	public List<Map<String, Object>> projPrtcpList(ProjectPrtcpVO projectPrtcpVO);

	public List<Map<String, Object>> selectScheduleList(int projNo);

	public int updateDeadLine();

	public List<ProjectsVO> projectDeadList(ProjectPrtcpVO projectPrtcpVO);

}
