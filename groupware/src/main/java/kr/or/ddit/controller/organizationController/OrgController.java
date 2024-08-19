package kr.or.ddit.controller.organizationController;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.json.simple.parser.ParseException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.service.organization.IOrganizationService;
import kr.or.ddit.vo.EmployeeVO;
import kr.or.ddit.vo.NVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/egg")
public class OrgController {

	@Inject
	private IOrganizationService service;
	
	@RequestMapping(value = "/org", method = RequestMethod.GET)
	public String orgChart(Model model) throws ParseException {
		log.info("[kr.or.ddit.controller.organizationController.OrgController] orgChart() 실행...!");
		
		List<EmployeeVO> empList = service.emplList(); 
		// ceoList
		List<EmployeeVO> ceoList1 = new ArrayList<EmployeeVO>();
		
		// 대표자를 따로 색출해내기 위한 작업
		for(int i = 0; i < empList.size(); i++) {
			EmployeeVO empVO = empList.get(i);
			if(empVO.getPositionCd().equals("POSITION07")) {	// 대표
				ceoList1.add(empVO);
				empList.remove(empVO);
				break;
			}
		}

		log.info("#### ===>  " + empList.get(0));
		
		List<String> deptList = new ArrayList<String>();
		List<List<String>> departmentList = new ArrayList<List<String>>();
		List<List<String>> organizationList = new ArrayList<List<String>>();
		
		String deptCd1 = empList.get(0).getDeptCd();
		for(int i = 0; i < empList.size(); i++) {
			EmployeeVO eVO = empList.get(i);
			
			if(i == 0) {
				deptList.add(eVO.getDeptNm());
				deptList.add(eVO.getEmplNm());
				deptList.add(eVO.getTelno());
				departmentList.add(deptList);
			}
			
			if(!deptCd1.equals(eVO.getDeptCd())) {
				deptCd1 = eVO.getDeptCd();
				deptList = new ArrayList<String>();
			}else {
				continue;
			}
			deptList.add(eVO.getDeptNm());
			deptList.add(eVO.getEmplNm());
			deptList.add(eVO.getTelno());
			departmentList.add(deptList);
		}

		for(int j = 0; j < deptList.size(); j++) {
			for(int k = 0; k < empList.size(); k++) {
				if(departmentList.get(j).get(0).equals(empList.get(k).getDeptNm())) {
					EmployeeVO eVO = empList.get(k);
					List<String> organizList = new ArrayList<String>();
					organizList.add(eVO.getEmplNm() + "<div style='color:red; font-style:italic' class='divNodes'>9999"+eVO.getPositionCdNm()+"</div>");
					organizList.add(eVO.getDeptNm());
					organizList.add(eVO.getTelno());
					organizationList.add(organizList);
				}
			}
		}
 		
		model.addAttribute("ceoList1",ceoList1);
		model.addAttribute("departmentList",departmentList);
		model.addAttribute("organizationList",organizationList);
		return "egg/organizationChart/org_main";
	}
	
	@RequestMapping(value="/orgChartAjax", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> orgChartAjax(){
		log.info("[kr.or.ddit.controller.organizationController.OrgController] orgChartAjax() 살행...!");
		Map<String, Object> result = new HashMap<String, Object>();
		List<EmployeeVO> empList = service.emplList(); 
		// ceoList
		List<EmployeeVO> ceoList1 = new ArrayList<EmployeeVO>();
		
		// 대표자를 따로 색출해내기 위한 작업
		for(int i = 0; i < empList.size(); i++) {
			EmployeeVO empVO = empList.get(i);
			if(empVO.getPositionCd().equals("POSITION07")) {	// 대표
				ceoList1.add(empVO);
				empList.remove(empVO);
				break;
			}
		}

		log.info("#### >> " + empList.get(0));
		
		List<String> deptList = new ArrayList<String>();
		List<List<String>> departmentList = new ArrayList<List<String>>();
		List<List<Object>> organizationList = new ArrayList<List<Object>>();
		
		String deptCd1 = empList.get(0).getDeptCd();
		for(int i = 0; i < empList.size(); i++) {
			EmployeeVO eVO = empList.get(i);
			
			if(i == 0) {
				deptList.add(eVO.getDeptNm());
				deptList.add(ceoList1.get(0).getEmplNm());
				deptList.add(eVO.getTelno());
				departmentList.add(deptList);
			}
			
			if(!deptCd1.equals(eVO.getDeptCd())) {
				deptCd1 = eVO.getDeptCd();
				deptList = new ArrayList<String>();
			}else {
				continue;
			}
			deptList.add(eVO.getDeptNm());
			deptList.add(ceoList1.get(0).getEmplNm());
			deptList.add(eVO.getTelno());
			departmentList.add(deptList);
		}

		for(int j = 0; j < departmentList.size(); j++) {
			int cnt = 0;
			for(int k = 0; k < empList.size(); k++) {
				if(departmentList.get(j).get(0).equals(empList.get(k).getDeptNm())) {
					EmployeeVO eVO = empList.get(k);
					List<Object> organizList = new ArrayList<Object>();
					NVO nVO = new NVO(eVO.getEmplNm(), "<i style='color:black; background-color: transparent;  width:100%;'  class='ri-file-user-fill divNodes divNodes' data-id='"+eVO.getEmplId()+"'>"+ eVO.getEmplNm() + " " + eVO.getPositionCdNm() +"</i>");
					organizList.add(nVO);
					if(cnt == 0)
						organizList.add(eVO.getDeptNm());
					else
						organizList.add(empList.get(k-1).getEmplNm());
					organizList.add(eVO.getTelno());
					organizationList.add(organizList);
					cnt++;
				}
			}
		}
 		
		result.put("ceoList", ceoList1);
		result.put("departmentList", departmentList);
		result.put("organizationList", organizationList);
		return new ResponseEntity<Map<String,Object>>(result, HttpStatus.OK);
	}
	
//	@RequestMapping (value = "orgEmplChart", method=RequestMethod.GET)
//	public String orgEmplChart(Model model) {
//		log.info("[kr.or.ddit.controller.organizationController.OrgController] orgEmplChart() 살행...!");
//		
//		List<EmployeeVO> empList2 = service.emplList2(); 
//		
//		model.addAttribute("empList2", empList2);
//		
//		return "egg/organizationChart/org_main";
//	}
	
	@ResponseBody
	@RequestMapping (value = "/orgEmplDetail", method=RequestMethod.GET)
	public ResponseEntity<EmployeeVO> orgEmplDetail(Model model, @RequestParam(name="emplId") String emplId) {
		log.info("[kr.or.ddit.controller.organizationController.OrgController] orgEmplDetail() 살행...!");
		
		//	결과를 받기 위한 Entity
		ResponseEntity<EmployeeVO> entity = null;
		
		//	Service 연결
		EmployeeVO employee = service.emplDetail(emplId);
		
		if(employee == null) {
			entity = new ResponseEntity<EmployeeVO>(HttpStatus.BAD_REQUEST);
		} else {
			entity = new ResponseEntity<EmployeeVO>(employee, HttpStatus.OK);
		}
		
		return entity;
	}
	
}

