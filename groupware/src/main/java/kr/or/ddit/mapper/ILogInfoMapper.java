package kr.or.ddit.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.or.ddit.vo.CustomEmployeeVO;
import kr.or.ddit.vo.EmployeeAuthVO;

public interface ILogInfoMapper {
	public CustomEmployeeVO readByEmplInfo(String username);

	// 이창은 - 2024-07-08 (사원관리에 필요한 사원리스트) 필요에 의해 생성함. 호출서비스는 EmployeeServiceImpl 이다.
	public List<CustomEmployeeVO> employeeList();

	// 이창은 - 2024-07-08 (사원등록) 필요에 의해 생성함. 호출서비스는 EmployeeServiceImpl 이다.
	public void insertEmployee(CustomEmployeeVO emplVO);

	public void insertEmployeeAuth(@Param("authList") List<EmployeeAuthVO> authList);

	public void updateEmployee(CustomEmployeeVO emplVO);

	public void updateEmployeeAuth(@Param("authList") List<EmployeeAuthVO> authList);

	public List<CustomEmployeeVO> employeeSearchList(@Param("select")String select, @Param("searchText")String searchText);

	
	
}
















