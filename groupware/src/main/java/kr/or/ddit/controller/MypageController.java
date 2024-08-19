package kr.or.ddit.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.ddit.service.IEmployeeService;
import kr.or.ddit.vo.CustomEmployeeVO;

@Controller
@RequestMapping("/egg")
public class MypageController {
	
	@Inject
	IEmployeeService service;
	
	private BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
	
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@RequestMapping(value = "/mypage")
	public String mypage(HttpServletRequest request, Model model) {
		return "egg/mypage";
	}

	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@RequestMapping(value = "/mypageInfoUpdate", method=RequestMethod.POST)
	public String mypageInfoUpdate(HttpServletRequest request, CustomEmployeeVO mypageVO, Model model) {
		HttpSession session = request.getSession();
		CustomEmployeeVO empVO = (CustomEmployeeVO) session.getAttribute("emplInfo");
		String emplId = empVO.getEmplId();
		
		CustomEmployeeVO emplInfo = service.readByEmplInfo(emplId);
		
		 // 비밀번호 암호화
	    String rawPassword = mypageVO.getEmplPswd();
	    String encryptedPassword = passwordEncoder.encode(rawPassword);
	    mypageVO.setEmplPswd(encryptedPassword);

	    // 주민등록번호 포맷 변경
	    String rrno = mypageVO.getRrno();
	    if (rrno != null) {
	        rrno = rrno.replace("-", "");
	        mypageVO.setRrno(rrno);
	    }
		
	    session.setAttribute("emplInfo", emplInfo);
		service.updateEmployee(mypageVO);
		return "redirect:/egg/main";
	}
	
	
}
