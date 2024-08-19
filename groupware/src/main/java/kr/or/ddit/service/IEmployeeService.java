package kr.or.ddit.service;

import java.util.List;

import kr.or.ddit.vo.CustomEmployeeVO;
import kr.or.ddit.vo.EmployeeAuthVO;

public interface IEmployeeService {

	public List<CustomEmployeeVO> employeeList();

	public void insertEmployee(CustomEmployeeVO emplVO);

	public void insertEmployeeAuth(List<EmployeeAuthVO> authList);

	public CustomEmployeeVO readByEmplInfo(String emplId);

	public void updateEmployee(CustomEmployeeVO emplVO);

	public void updateEmployeeAuth(List<EmployeeAuthVO> authList);

	public List<CustomEmployeeVO> employeeSearchList(String select, String searchText);



}
