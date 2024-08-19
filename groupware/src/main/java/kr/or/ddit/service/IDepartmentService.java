package kr.or.ddit.service;

import java.util.List;

import kr.or.ddit.vo.CustomEmployeeVO;
import kr.or.ddit.vo.DepartmentVO;
import kr.or.ddit.vo.EmployeeAuthVO;

public interface IDepartmentService {

	public List<DepartmentVO> departmentList();

	public void deptInsert(DepartmentVO deptVO);

	public DepartmentVO deptSelectOne(String deptCd);

	public void deptUpdate(DepartmentVO deptVO);

	public List<DepartmentVO> departmentSearchList(String select, String searchText);



}
