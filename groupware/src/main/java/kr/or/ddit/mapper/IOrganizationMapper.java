package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.vo.DepartmentVO;
import kr.or.ddit.vo.EmployeeVO;

public interface IOrganizationMapper {

	public List<EmployeeVO> emplList();

	public List<DepartmentVO> deptList();

	public List<EmployeeVO> emplList2();

	public EmployeeVO detail();

	public EmployeeVO emplDetail(String emplId);


}
