package kr.or.ddit.controller.survey;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.service.survey.ISurveyService;
import kr.or.ddit.vo.CustomEmployeeVO;
import kr.or.ddit.vo.EmployeeVO;
import kr.or.ddit.vo.SurveyParticpantVO;
import kr.or.ddit.vo.SurveyVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/survey")
public class SurveyController {
	@Inject
	private ISurveyService surveyService;
	// 설문 메인페이지 이동 
	@GetMapping("/surveyMain")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String surveyList(HttpServletRequest request, Model model) {
		String goPage = "admin/survey/survey_main"; // 관리자

		HttpSession session = request.getSession();
		CustomEmployeeVO emplInfo = (CustomEmployeeVO) session.getAttribute("emplInfo");
		String emplId = emplInfo.getEmplId();

		if (emplInfo == null || session == null) {
			return "redirect:/egg/login"; // 세션에 정보가 없는 경우 로그인 페이지로 리디렉션
		}

		Map<String, Object> params = new HashMap<>();
		params.put("emplId", emplId);
		List<Map<String, Object>> surveyList = surveyService.selectSurveyList(params);
		model.addAttribute("surveyList", surveyList);


		return goPage;
	}
	
	// 설문 등록 폼  이동
	@GetMapping("/surveyInsert")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String surveyInsertForm(HttpServletRequest request, Model model) {

		model.addAttribute("surveyVO", new SurveyVO());
		
		// 설문 카테고리 
		List<SurveyVO> categoryList = surveyService.selectSurveyCatList();
		// 설문 참가 수 
		List<EmployeeVO> selectEmplSurvList = surveyService.selectEmplSurvList();

		int cnt = 0;

		model.addAttribute("categoryList", categoryList);
		model.addAttribute("employeeList", selectEmplSurvList);
		model.addAttribute("emplcnt", cnt);
		return "admin/survey/survey_form";
	}

	// 설문 재등록 
	@ResponseBody
	@PostMapping("/reloadSurveyForm")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String reloadSurveyForm(HttpServletRequest request, Model model, @RequestBody SurveyVO surveyVO) {
		SurveyVO newSurveyVO = new SurveyVO();

		newSurveyVO = surveyService.selectSurvey(surveyVO.getSurvNo());
		newSurveyVO.setSurvEndDt(surveyVO.getSurvEndDt());
		newSurveyVO.setSurvTtlNm(surveyVO.getSurvTtlNm());

		int a = surveyService.saveSurvey(newSurveyVO);

		return "success";
	}

	@ResponseBody
	@GetMapping("/{survNo}/selectResponCntSurvey")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public List<Map<String, Object>> selectResponCntSurvey(@PathVariable int survNo) {
		List<Map<String, Object>> resList = surveyService.selectResponCntSurvey(survNo);

		return resList;
	}

	@ResponseBody
	@PostMapping("/closeSurveys")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String closeSurveys(@RequestBody List<String> surveyNos) {
		int updatedCount = surveyService.closeSurveys(surveyNos);
		return updatedCount > 0 ? "success" : "fail";
	}

	@GetMapping("/surveyDetail")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String surveyInsertForm(@RequestParam("surveyNo") int surveyNo, Model model) {
		List<SurveyVO> categoryList = surveyService.selectSurveyCatList();
		model.addAttribute("categoryList", categoryList);

		SurveyVO surveyVO = new SurveyVO();
		surveyVO = surveyService.selectSurvey(surveyNo);

		if (surveyVO == null) {
			return "redirect:/egg/survey/surveyMain"; // 설문조사가 없는 경우 리디렉션
		}

		int cnt = 0;
		cnt = surveyService.countTotalEmpl();

		model.addAttribute("emplcnt", cnt);

		List<SurveyParticpantVO> ptcpList = surveyService.selectPrtcp(surveyNo);

		model.addAttribute("ptcpList", ptcpList);
		model.addAttribute("surveyVO", surveyVO);
		return "admin/survey/survey_form";
	}

	@PostMapping("/insertSurvey")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@ResponseBody
	public String insertSurvey(@RequestBody SurveyVO survey, BindingResult result, Model model) {
		String status = "success";

		if (result.hasErrors()) {
			status = "failed";
		}

		int a = surveyService.saveSurvey(survey);
		if (a < 1) {
			status = "failed";
		}

		return status;
	}

	@GetMapping("/checkSurvey")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@ResponseBody
	public ResponseEntity<Map<String, String>> checkSurvey() {
		Map<String, String> response = new HashMap<>();

		int surveyCount = surveyService.checkSurvey();

		if (surveyCount > 0) {
			response.put("status", "failed");
		} else {
			response.put("status", "success");
		}

		return ResponseEntity.ok(response);
	}

}
