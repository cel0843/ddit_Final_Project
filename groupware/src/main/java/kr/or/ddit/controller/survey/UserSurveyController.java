package kr.or.ddit.controller.survey;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


import kr.or.ddit.service.survey.ISurveyService;
import kr.or.ddit.vo.CustomEmployeeVO;
import kr.or.ddit.vo.SurveyParticpantVO;
import kr.or.ddit.vo.SurveyRspnsCnVO;
import kr.or.ddit.vo.SurveyVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/egg/survey")
public class UserSurveyController {
	
	@Inject
	private ISurveyService surveyService;
	

	@GetMapping("/surveyMain")
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_MEMBER')")
	public String surveyList(HttpServletRequest request, Model model, String select, String searchText, String survStts,
			String survPatcpCnt) {
		HttpSession session = request.getSession();
		CustomEmployeeVO emplInfo = (CustomEmployeeVO) session.getAttribute("emplInfo");

		if (emplInfo == null) {
			return "redirect:/egg/login"; // 세션에 정보가 없는 경우 로그인 페이지로 리디렉션
		}

		String emplId = emplInfo.getEmplId();
		List<Map<String, Object>> surveyList = null;
		int a = surveyService.updateEndSurvey();
		Map<String, Object> params = new HashMap<>();
		params.put("emplId", 		emplId);
		params.put("select", 		select != null ? select : "all");
		params.put("searchText", 	searchText != null ? searchText : "");
		params.put("survStts", 		survStts);
		params.put("survPatcpCnt", 	survPatcpCnt);

		surveyList = surveyService.selectSurveyList(params);

		model.addAttribute("surveyList",	surveyList);
		model.addAttribute("selectBoxChk", 	select);
		model.addAttribute("searchText", 	searchText);
		model.addAttribute("survStts", 		survStts);
		model.addAttribute("survPatcpCnt", 	survPatcpCnt);
		return "egg/survey/survey_user_main";
	}

	@GetMapping("/surveyDetail")
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_MEMBER')")
	public String surveyInsertForm(HttpServletRequest request, @RequestParam("surveyNo") int surveyNo, Model model) {

		SurveyVO surveyVO = new SurveyVO();

		surveyVO = surveyService.selectSurvey(surveyNo);

		if (surveyVO == null) {
			return "redirect:/egg/survey/surveyMain"; // 설문조사가 없는 경우 리디렉션
		}

		List<SurveyParticpantVO> ptcpList = surveyService.selectPrtcp(surveyNo);

		HttpSession session = request.getSession();
		CustomEmployeeVO emplInfo = (CustomEmployeeVO) session.getAttribute("emplInfo");
		if (emplInfo == null) {
			return "redirect:/egg/login"; // 세션에 정보가 없는 경우 로그인 페이지로 리디렉션
		}

		String emplId = emplInfo.getEmplId();

		int status = surveyService.isSurveyParticipated(emplId);

		if (status > 0) {
			model.addAttribute("isSurveyPrtcp", true);
		} else {
			model.addAttribute("isSurveyPrtcp", false);

		}

		if (ptcpList.size() != 0) {
			model.addAttribute("ptcpList", ptcpList);
		}
		model.addAttribute("surveyVO", surveyVO);
		return "egg/survey/survey_user_form";
	}

	@ResponseBody
	@PostMapping("/submitSurvey")
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_MEMBER')")
	public String submitSurvey(HttpServletRequest request, @RequestBody Map<String, Object> surveyData) {

		HttpSession session = request.getSession();
		CustomEmployeeVO emplInfo = (CustomEmployeeVO) session.getAttribute("emplInfo");
		String emplId = emplInfo.getEmplId();

		int survNo = Integer.parseInt(surveyData.get("surveyNo").toString());
		SurveyParticpantVO surveyParticpantVO = new SurveyParticpantVO();
		surveyParticpantVO.setEmplId(emplId);
		surveyParticpantVO.setSurvNo(survNo);
		
		// 오늘 날짜 변환
		LocalDate currentDate = LocalDate.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
		String formattedDate = currentDate.format(formatter);
		surveyParticpantVO.setPatcpYmd(formattedDate);

		int survPatcpntNo = surveyService.surveyParticipated(surveyParticpantVO);

		SurveyRspnsCnVO cnVO = new SurveyRspnsCnVO();

		List<Map<String, Object>> answers = (List<Map<String, Object>>) surveyData.get("answers");

		int status = 0;
		cnVO.setSurvPatpntNo(survPatcpntNo);
		for (Map<String, Object> answer : answers) {

			int questionNo = (Integer) answer.get("questionNo");
			int answerNo = (Integer) answer.get("answerNo");

			cnVO.setAnsNo(answerNo);
			cnVO.setQstnNo(questionNo);

			status = surveyService.submitSurvey(cnVO);
		}

		if (status < 1) {
			log.debug("잘못된 처리 입니다. ");
			return "failed";
		}

		return "success";
	}

}
