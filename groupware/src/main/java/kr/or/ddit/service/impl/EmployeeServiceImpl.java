package kr.or.ddit.service.impl;


import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.ILogInfoMapper;
import kr.or.ddit.service.IEmployeeService;
import kr.or.ddit.vo.CustomEmployeeVO;
import kr.or.ddit.vo.EmployeeAuthVO;

@Service
public class EmployeeServiceImpl implements IEmployeeService{

	@Inject
	ILogInfoMapper mapper;
	
	@Override
	public List<CustomEmployeeVO> employeeList() {
		return mapper.employeeList();
	}

	@Override
	public void insertEmployee(CustomEmployeeVO emplVO) {
		mapper.insertEmployee(emplVO);
		
	}

	@Override
	public void insertEmployeeAuth(List<EmployeeAuthVO> authList) {
		mapper.insertEmployeeAuth(authList);
	}

	@Override
	public CustomEmployeeVO readByEmplInfo(String emplId) {
		return mapper.readByEmplInfo(emplId);		
	}

	@Override
	public void updateEmployee(CustomEmployeeVO emplVO) {
		mapper.updateEmployee(emplVO);
	}

	@Override
	public void updateEmployeeAuth(List<EmployeeAuthVO> authList) {
		mapper.updateEmployeeAuth(authList);
	}

	@Override
	public List<CustomEmployeeVO> employeeSearchList(String select, String searchText) {
		return mapper.employeeSearchList(select, searchText);
	}

	
	
}
