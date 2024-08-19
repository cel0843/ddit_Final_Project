package kr.or.ddit.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.or.ddit.vo.WorkVO;

public interface IWorkMapper {

	public List<WorkVO> workInfo(@Param("emplId") String emplId, @Param("workMonth")String workMonth);

	public List<WorkVO> weekListSelect(@Param("emplId") String emplId, @Param("workMonth")String workMonth);

	public void startWorkChk(@Param("emplId") String emplId, @Param("startTime") String startTime);

	public void endWorkChk(@Param("emplId") String emplId);

	public WorkVO todayWorkTime(String emplId);

	public void workNullCheckIn();

	public List<WorkVO> hdList(String emplId);

	public int workingCount(String emplId);	// 메인화면에 프로필에서 진행중 업무 카운트


}
