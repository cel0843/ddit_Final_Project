
package kr.or.ddit.controller.approval;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.service.approval.IApprovalService;
import kr.or.ddit.vo.AprvDocumentVO;
import kr.or.ddit.vo.AprvFormVO;
import kr.or.ddit.vo.AprvPaginationInfoVO;
import kr.or.ddit.vo.AprvSearchVO;
import kr.or.ddit.vo.DepartmentVO;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
@RequestMapping("/admin")
public class ApprovalController {	
	
	@Inject
	private IApprovalService service;	
	
	// 양식관리 목록페이지
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@RequestMapping(value = "/formList", method = RequestMethod.GET)
	public String aprvForm(Model model, String aprvTy) {
		AprvFormVO form = new AprvFormVO();
		form.setAprvTy(aprvTy);
		List<AprvFormVO> formList = service.formList(form);		
		model.addAttribute("list", formList);		
		return "admin/approval/aprvFormList";
	}	

	
	// 양식 미리보기_상세보기
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@RequestMapping(value = "/formOne", method = RequestMethod.POST)
	public ResponseEntity<AprvFormVO> form(@RequestBody AprvFormVO form) {		
		log.info("form() 양식미리보기 ajax");		
		AprvFormVO result = new AprvFormVO();
		result = service.formOne(form.getFormCd());	
		return new ResponseEntity<AprvFormVO>(result,HttpStatus.OK);
	}
	
	// 사용여부 스위치
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@RequestMapping(value = "/formUse", method = RequestMethod.POST)
	public ResponseEntity<Integer> formUse(@RequestBody AprvFormVO form) {			
        int cnt = service.updateUse(form);
		return new ResponseEntity<Integer>(cnt,HttpStatus.OK);
	}
	// 전결여부 스위치
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@RequestMapping(value = "/dcrbYn", method = RequestMethod.POST)
	public ResponseEntity<Integer> dcrbYn(@RequestBody AprvFormVO form) {			
		int cnt = service.updateDcrb(form);
		return new ResponseEntity<Integer>(cnt,HttpStatus.OK);
	}
	
	// 양식등록 페이지
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@RequestMapping(value = "/addAprvForm", method = RequestMethod.GET)
	public String addAprvForm(String aprvTy) {
		return "admin/approval/addAprvForm";
	}
	
	// 양식insert
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@RequestMapping(value = "/addForm", method = RequestMethod.POST)
	public String addForm(
			@RequestParam String aprvTy,
	        @RequestParam String formTtl,
	        @RequestParam String formCn
	        ) {
		log.info("addForm 양식insert");	
		
		AprvFormVO addForm = new AprvFormVO();
		addForm.setAprvTy(aprvTy);
		addForm.setFormTtl(formTtl);
		addForm.setFormCn(formCn);
		
		service.addForm(addForm);
		return "redirect:/admin/formList";
	}	
	
	//양식수정페이지
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@RequestMapping(value = "/modForm", method = RequestMethod.GET)
	public String modForm(Model model, String formCd) {
	    AprvFormVO result = new AprvFormVO();
		result = service.formOne(formCd);	
	    model.addAttribute("status", "u");
	    model.addAttribute("result",result );
	    return "admin/approval/addAprvForm";
	}
	
	//양식update
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@RequestMapping(value = "/updateForm", method = RequestMethod.POST)
	public String updateForm(
			Model model,
			@RequestParam String aprvTy,
			@RequestParam String formTtl,
			@RequestParam String formCn,
			@RequestParam String formCd
			) {
		
		AprvFormVO updateForm = new AprvFormVO();
		updateForm.setAprvTy(aprvTy);
		updateForm.setFormTtl(formTtl);
		updateForm.setFormCn(formCn);
		updateForm.setFormCd(formCd);
		
		service.updateForm(updateForm);
		return "redirect:/admin/formList";
	}
	
	// 양식 delete
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@RequestMapping(value = "/remove", method = RequestMethod.POST)
	public String delForm(String formCd) {
		service.delForm(formCd);
		return "redirect:/admin/formList";
	}
	
	// letsgo
	// 결재 검색 list
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@RequestMapping(value = "/aprvList")
	public String aprvList(Model model, AprvSearchVO aprvSearchVO) {		
		List<DepartmentVO> dept = service.deptList();
		model.addAttribute("dept", dept);
		List<AprvSearchVO> res = service.selectSearchList(aprvSearchVO);
		model.addAttribute("res",res);
		model.addAttribute("aprvSearchVO",aprvSearchVO);
		return "admin/approval/aprvList";
	}
	
	
	
	
	
	

}

