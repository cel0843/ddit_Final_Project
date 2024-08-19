package kr.or.ddit.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.or.ddit.vo.DepartmentVO;

public interface IDepartmentMapper {

	public List<DepartmentVO> departmentList();

	public void deptInsert(DepartmentVO deptVO);

	public DepartmentVO deptSelectOne(String deptCd);

	public void deptUpdate(DepartmentVO deptVO);

	public List<DepartmentVO> departmentSearchList(@Param("select")String select, @Param("searchText")String searchText);


}
