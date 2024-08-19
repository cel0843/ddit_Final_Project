package kr.or.ddit.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.IWorkMapper;
import kr.or.ddit.service.IWorkService;
import kr.or.ddit.vo.WorkVO;

@Service
public class WorkServiceImpl implements IWorkService{
	
	@Inject
	private IWorkMapper mapper;

	@Override
	public List<WorkVO> workInfo(String emplId, String workMonth) {
		return mapper.workInfo(emplId, workMonth);
	}

	@Override
	public List<WorkVO> weekListSelect(String emplId, String workMonth) {
		return mapper.weekListSelect(emplId, workMonth);
	}

	@Override
	public void startWorkChk(String emplId, String startTime) {
		mapper.startWorkChk(emplId, startTime);
		
	}

	@Override
	public void endWorkChk(String emplId) {
		mapper.endWorkChk(emplId);
		
	}

	@Override
	public WorkVO todayWorkTime(String emplId) {
		return mapper.todayWorkTime(emplId);
	}

	@Override
	public void workNullCheckIn() {
		mapper.workNullCheckIn();		
	}

	@Override
	public List<WorkVO> hdList(String emplId) {
		return mapper.hdList(emplId);
	}

	@Override
	public int workingCount(String emplId) {
		return mapper.workingCount(emplId);// 메인화면에 프로필에서 진행중 업무 카운트
	}


	
}
