package kr.or.ddit.controller.department;

import java.util.List;

import javax.inject.Inject;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.service.IDepartmentService;
import kr.or.ddit.vo.DepartmentVO;

@Controller
@RequestMapping("/admin")
public class DepartmentManagementController {
	
	@Inject
	IDepartmentService service;

	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@RequestMapping(value = "/deptmain")
	public String deptMangamentMain(Model model) {
		
		List<DepartmentVO> deptList = service.departmentList();
		
		model.addAttribute("deptList", deptList);
		
		return "admin/departmentManager";
	}
	
	@RequestMapping(value = "/deptSearch")
	public String deptSearch(String select, String searchText, Model model) {
		
		List<DepartmentVO> deptList = service.departmentSearchList(select, searchText);
		
		model.addAttribute("deptList", deptList);
		model.addAttribute("selectBoxChk", select);
		return "admin/departmentManager";
	}

	@RequestMapping(value = "/deptform")
	public String deptForm(Model model) {
		List<DepartmentVO> deptList = service.departmentList();
		
		String lastDeptCd = deptList.get(deptList.size()-1).getDeptCd();
		String[] lastDeptCdNumsStr= lastDeptCd.split("_");
		String lastDeptCdNumStr = lastDeptCdNumsStr[1];
		int temp = Integer.parseInt(lastDeptCdNumStr);
		String inputDeptCd="";
		if(temp <9) {
			inputDeptCd = "DEPT_0" + String.valueOf(++temp);
		}else {
			inputDeptCd = "DEPT_" + String.valueOf(++temp);
		}
		
		model.addAttribute("inputDeptCd", inputDeptCd);
		return "admin/departmentForm";
	}

	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@RequestMapping(value = "/departmentInsertForm")
	public String deptInsertForm(DepartmentVO deptVO, Model model) {
		service.deptInsert(deptVO);
		List<DepartmentVO> deptList = service.departmentList();
		model.addAttribute("deptList", deptList);
		
		return "admin/departmentManager";
	}
	
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@RequestMapping(value = "/updateDeptInfo")
	public String deptUpdateForm(String deptCd, Model model) {
		DepartmentVO deptVO = service.deptSelectOne(deptCd);
		
		model.addAttribute("deptVO", deptVO);
		model.addAttribute("update", "update");
		return "admin/departmentForm";
	}

	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@RequestMapping(value = "/departmentUpdateForm")
	public String departmentUpdateForm(DepartmentVO deptVO, Model model) {
		service.deptUpdate(deptVO);
		List<DepartmentVO> deptList = service.departmentList();
		
		model.addAttribute("deptList", deptList);
		return "admin/departmentManager";
	}
}
