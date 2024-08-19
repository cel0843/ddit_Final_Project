package kr.or.ddit.service.impl;


import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.IDepartmentMapper;
import kr.or.ddit.service.IDepartmentService;
import kr.or.ddit.vo.DepartmentVO;

@Service
public class DepartmentServiceImpl implements IDepartmentService{

	@Inject
	IDepartmentMapper mapper;

	@Override
	public List<DepartmentVO> departmentList() {
		return mapper.departmentList();
	}

	@Override
	public void deptInsert(DepartmentVO deptVO) {
		mapper.deptInsert(deptVO);
	}

	@Override
	public DepartmentVO deptSelectOne(String deptCd) {
		return mapper.deptSelectOne(deptCd);
	}

	@Override
	public void deptUpdate(DepartmentVO deptVO) {
		mapper.deptUpdate(deptVO);
	}

	@Override
	public List<DepartmentVO> departmentSearchList(String select, String searchText) {
		return mapper.departmentSearchList(select, searchText);
	}
	

	
}
