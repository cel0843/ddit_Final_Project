package kr.or.ddit.service;

import java.util.List;

import kr.or.ddit.vo.WorkVO;

public interface IWorkService {

	public List<WorkVO> workInfo(String emplId, String workMonth);

	public List<WorkVO> weekListSelect(String emplId, String workMonth);

	public void startWorkChk(String emplId, String startTime);

	public void endWorkChk(String emplId);

	public WorkVO todayWorkTime(String emplId);

	public void workNullCheckIn();

	public List<WorkVO> hdList(String emplId);

	public int workingCount(String emplId);// 메인화면에 프로필에서 진행중 업무 카운트


}
