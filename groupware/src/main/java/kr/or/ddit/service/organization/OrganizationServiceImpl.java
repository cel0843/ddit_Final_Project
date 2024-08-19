package kr.or.ddit.service.organization;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.IOrganizationMapper;
import kr.or.ddit.util.ServiceResult;
import kr.or.ddit.vo.DepartmentVO;
import kr.or.ddit.vo.EmployeeVO;

@Service
public class OrganizationServiceImpl implements IOrganizationService{

	@Inject
	private IOrganizationMapper mapper;  
	
	@Override
	public List<EmployeeVO> emplList() {
		return mapper.emplList();
	}

	@Override
	public List<DepartmentVO> deptList() {
		return mapper.deptList();
	}

	@Override
	public List<EmployeeVO> emplList2() {
		return mapper.emplList2();
	}

	@Override
	public EmployeeVO detail() {
		return mapper.detail();
	}

	@Override
	public EmployeeVO emplDetail(String emplId) {
		return mapper.emplDetail(emplId);
	}


}
