package kr.or.ddit.controller.employee;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.service.IEmployeeService;
import kr.or.ddit.vo.CustomEmployeeVO;
import kr.or.ddit.vo.EmployeeAuthVO;

@Controller
@RequestMapping("/admin")
public class EmployeeManagementController {
	
	@Inject
	IEmployeeService service;

	
	private BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
	
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@RequestMapping(value = "/updateEmplInfo")
	public String updateEmplInfo(String emplId, Model model){
		CustomEmployeeVO empVO = service.readByEmplInfo(emplId);
		
        // 기존 날짜 형식 변환
        if (empVO != null && empVO.getJncmpYmd() != null) {
            try {
                SimpleDateFormat fromFormatter = new SimpleDateFormat("yyyyMMdd");
                SimpleDateFormat toFormatter = new SimpleDateFormat("yyyy-MM-dd");
                Date date = fromFormatter.parse(empVO.getJncmpYmd());
                String formattedDate = toFormatter.format(date);
                empVO.setJncmpYmd(formattedDate);
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
        String rrno = empVO.getRrno();
        String changeRrno = rrno.substring(0, 6) + "-" + rrno.substring(6);
        empVO.setRrno(changeRrno);
		model.addAttribute("empVO", empVO);
		model.addAttribute("update", "update");
		return "admin/employeeForm";
	}
	
	
	@RequestMapping(value = "/emplSearch")
	public String emplSearch(String select, String searchText, Model model) {
		List<CustomEmployeeVO> empListVO = new ArrayList<>();
		if(searchText.equals("")) {
			empListVO = service.employeeList();
		}else {
			empListVO = service.employeeSearchList(select, searchText);
		}
		
		model.addAttribute("empListVO", empListVO);
		model.addAttribute("selectBoxChk", select);
		
		return "admin/employeeManager";
	}
	
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@RequestMapping(value = "/empmain")
	public String emplMangamentMain(Model model) {
		List<CustomEmployeeVO> empListVO = new ArrayList<>();
		empListVO = service.employeeList();
		
		model.addAttribute("empListVO", empListVO);
		
		return "admin/employeeManager";
	}
	
	@RequestMapping(value = "/empForm")
	public String emplForm() {
		
		return "admin/employeeForm";
		
	}
	
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@PostMapping(value = "/employeeUpdateForm")
	public String employeeUpdateForm(CustomEmployeeVO emplVO, Model model) {
	    List<String> errorMessages = validationChk(emplVO);

	    
	    // 에러 메시지가 있는 경우 폼으로 돌아가기
	    if (!errorMessages.isEmpty()) {
	        model.addAttribute("errorMessages", errorMessages);
	        model.addAttribute("employeeVO", emplVO);
	        return "admin/employeeForm";
	    }

	    // 비밀번호 암호화
	    String rawPassword = emplVO.getEmplPswd();
	    String encryptedPassword = passwordEncoder.encode(rawPassword);
	    emplVO.setEmplPswd(encryptedPassword);

	    // 주민등록번호 포맷 변경
	    String rrno = emplVO.getRrno();
	    if (rrno != null) {
	        rrno = rrno.replace("-", "");
	        emplVO.setRrno(rrno);
	    }

	    // 입사날짜 포맷 변경
	    String jncmpYmd = emplVO.getJncmpYmd();
	    if (jncmpYmd != null && !jncmpYmd.isEmpty()) {
	        jncmpYmd = jncmpYmd.replaceAll("-", "");
	        emplVO.setJncmpYmd(jncmpYmd);
	    }

	    service.updateEmployee(emplVO);

	    // 권한 처리
	    List<EmployeeAuthVO> authList = emplVO.getAuthList();
	    if (authList != null) {
	        for (EmployeeAuthVO auth : authList) {
	            auth.setEmplId(emplVO.getEmplId());
	        }
	        service.updateEmployeeAuth(authList);
	    }

	    List<CustomEmployeeVO> empListVO = service.employeeList();
	    model.addAttribute("empListVO", empListVO);

	    return "admin/employeeManager";
	}

	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@PostMapping(value = "/employeeInsertForm")
	public String employeeInsertForm(CustomEmployeeVO emplVO, Model model) {
	    List<String> errorMessages = validationChk(emplVO);

	    // 에러 메시지가 있는 경우 폼으로 돌아가기
	    if (!errorMessages.isEmpty()) {
	        model.addAttribute("errorMessages", errorMessages);
	        model.addAttribute("employeeVO", emplVO);
	        return "admin/employeeForm";
	    }

	    // 비밀번호 암호화
	    String rawPassword = emplVO.getEmplPswd();
	    String encryptedPassword = passwordEncoder.encode(rawPassword);
	    emplVO.setEmplPswd(encryptedPassword);

	    // 주민등록번호 포맷 변경
	    String rrno = emplVO.getRrno();
	    if (rrno != null) {
	        rrno = rrno.replace("-", "");
	        emplVO.setRrno(rrno);
	    }

	    // 입사날짜 포맷 변경
	    String jncmpYmd = emplVO.getJncmpYmd();
	    if (jncmpYmd != null && !jncmpYmd.isEmpty()) {
	        jncmpYmd = jncmpYmd.replaceAll("-", "");
	        emplVO.setJncmpYmd(jncmpYmd);
	    }

	    service.insertEmployee(emplVO);

	    // 권한 처리
	    List<EmployeeAuthVO> authList = emplVO.getAuthList();
	    if (authList != null) {
	        for (EmployeeAuthVO auth : authList) {
	            auth.setEmplId(emplVO.getEmplId());
	        }
	        service.insertEmployeeAuth(authList);
	    }

	    List<CustomEmployeeVO> empListVO = service.employeeList();
	    model.addAttribute("empListVO", empListVO);

	    return "admin/employeeManager";
	}

	
	// 유효성 검사하는 메소드
	private List<String> validationChk(CustomEmployeeVO emplVO) {
	    List<String> errorMessages = new ArrayList<>();

	    // 사원이름 검증
	    if (emplVO.getEmplNm() == null || emplVO.getEmplNm().isEmpty()) {
	        errorMessages.add("사원이름은 필수 입력 항목입니다.");
	    } else if (emplVO.getEmplNm().length() < 2 || emplVO.getEmplNm().length() > 50) {
	        errorMessages.add("사원이름은 2자 이상 50자 이하로 입력해주세요.");
	    }

	    // 부서코드 검증
	    if (emplVO.getDeptCd() == null || emplVO.getDeptCd().isEmpty()) {
	        errorMessages.add("부서코드는 필수 입력 항목입니다.");
	    }

	    // 직급코드 검증
	    if (emplVO.getPositionCd() == null || emplVO.getPositionCd().isEmpty()) {
	        errorMessages.add("직급코드는 필수 입력 항목입니다.");
	    }

	    // 입사날짜 검증
	    if (emplVO.getJncmpYmd() == null || emplVO.getJncmpYmd().isEmpty()) {
	        errorMessages.add("입사날짜는 필수 입력 항목입니다.");
	    }

	    // 아이디 검증
	    if (emplVO.getEmplId() == null || emplVO.getEmplId().isEmpty()) {
	        errorMessages.add("아이디는 필수 입력 항목입니다.");
	    } else if (emplVO.getEmplId().length() < 4 || emplVO.getEmplId().length() > 20) {
	        errorMessages.add("아이디는 4자 이상 20자 이하로 입력해주세요.");
	    }

	    // 비밀번호 검증
	    if (emplVO.getEmplPswd() == null || emplVO.getEmplPswd().isEmpty()) {
	        errorMessages.add("비밀번호는 필수 입력 항목입니다.");
	    } else if (emplVO.getEmplPswd().length() < 4 || emplVO.getEmplPswd().length() > 20) {
	        errorMessages.add("비밀번호는 8자 이상 20자 이하로 입력해주세요.");
	    }

	    // 이메일 검증
	    if (emplVO.getEmail() == null || emplVO.getEmail().isEmpty()) {
	        errorMessages.add("이메일은 필수 입력 항목입니다.");
	    } else if (!emplVO.getEmail().matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
	        errorMessages.add("유효한 이메일 주소를 입력해주세요.");
	    }

	    // 전화번호 검증
	    if (emplVO.getTelno() == null || emplVO.getTelno().isEmpty()) {
	        errorMessages.add("전화번호는 필수 입력 항목입니다.");
	    } else if (!emplVO.getTelno().matches("^\\d{3}-\\d{3,4}-\\d{4}$")) {
	        errorMessages.add("전화번호는 000-0000-0000 형식으로 입력해주세요.");
	    }

	    // 주민등록번호 검증
	    if (emplVO.getRrno() == null || emplVO.getRrno().isEmpty()) {
	        errorMessages.add("주민등록번호는 필수 입력 항목입니다.");
	    } else if (!emplVO.getRrno().matches("\\d{6}-\\d{7}")) {
	        errorMessages.add("주민등록번호는 000000-0000000 형식으로 입력해주세요.");
	    }

	    // 우편번호 검증
	    if (emplVO.getZip() == null || emplVO.getZip().isEmpty()) {
	        errorMessages.add("우편번호는 필수 입력 항목입니다.");
	    } else if (!emplVO.getZip().matches("\\d{5}")) {
	        errorMessages.add("우편번호는 5자리 숫자로 입력해주세요.");
	    }

	    // 주소 검증
	    if (emplVO.getBscAddr() == null || emplVO.getBscAddr().isEmpty()) {
	        errorMessages.add("주소는 필수 입력 항목입니다.");
	    }

	    // 권한 검증
	    List<EmployeeAuthVO> authList = emplVO.getAuthList();
	    if (authList == null || authList.isEmpty()) {
	        errorMessages.add("권한은 최소 하나 이상 선택해야 합니다.");
	    }

	    return errorMessages;
	}

}
