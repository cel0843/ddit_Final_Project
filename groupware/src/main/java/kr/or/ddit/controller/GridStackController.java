package kr.or.ddit.controller;


import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.ddit.service.IGridStackService;
import kr.or.ddit.vo.CustomEmployeeVO;
import kr.or.ddit.vo.GridStackVO;

@Controller
@Component
@RequestMapping("/egg")
public class GridStackController {

	@Inject
	private IGridStackService service;

	@RequestMapping(value = "/gridStackInfo", method = RequestMethod.POST)
	public ResponseEntity<String> workStart(
	        HttpServletRequest request, @RequestBody GridStackVO gsVO){
	    
	    HttpSession session = request.getSession();
	    CustomEmployeeVO emplInfo = (CustomEmployeeVO) session.getAttribute("emplInfo");
	    String emplId = emplInfo.getEmplId();
	    gsVO.setEmplId(emplId);
	        System.out.println("x : " + gsVO.getGsX() + "  y : " + gsVO.getGsY() + "  w : " + gsVO.getGsW() + "  h : " + gsVO.getGsH() + "  id : " + gsVO.getGsId() + "  emplId : " + emplId);
	    
	    service.updateGridStack(gsVO);
	    

	        
	    return new ResponseEntity<String>("성공", HttpStatus.OK);
	}


	
	
}
