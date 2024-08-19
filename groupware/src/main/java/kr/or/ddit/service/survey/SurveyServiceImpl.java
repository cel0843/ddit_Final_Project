package kr.or.ddit.service.survey;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.ISurveyMapper;
import kr.or.ddit.vo.EmployeeVO;
import kr.or.ddit.vo.SurveyParticpantVO;
import kr.or.ddit.vo.SurveyQItemVO;
import kr.or.ddit.vo.SurveyQuestionVO;
import kr.or.ddit.vo.SurveyRspnsCnVO;
import kr.or.ddit.vo.SurveyVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class SurveyServiceImpl implements ISurveyService {
	@Inject
	private ISurveyMapper surveyMapper;
	
	@Override
	public List<Map<String, Object>> selectSurveyList(Map<String, Object> params) {
		
		return surveyMapper.selectSurveyList(params);
	}


	@Override
	public int saveSurvey(SurveyVO surveyVO) {
		int status = 0;
		status = surveyMapper.insertSurvey(surveyVO);
		
		if(status > 0) {
			int displayOrdQst = 0; 
	        for (SurveyQuestionVO question : surveyVO.getQuestions()) {
	        	log.debug("surveyVO.getQuestions() " + question.getQstnCn());
	        	
	        	displayOrdQst++;
	        	question.setQstnDispOrd(displayOrdQst);
	            question.setSurvNo(surveyVO.getSurvNo()); 
	            status =  surveyMapper.insertQuestion(question);
	            int displayOrd = 0; 
	            for (SurveyQItemVO qItem : question.getAnswers()) {
	            	displayOrd++;
	            	qItem.setQitemDispOrd(displayOrd); //표시순서 
	                qItem.setQstnNo(question.getQstnNo()); // 질문번호
	                status =  surveyMapper.insertQItem(qItem);
	            }
	        }
		}
		
		return status;
		
	}


	@Override
	public SurveyVO selectSurvey(int survNo) {
	    SurveyVO survey = surveyMapper.selectSurvey(survNo);
	    if (survey != null) {
	        List<SurveyQuestionVO> questions = surveyMapper.selectQuestions(survNo);
	        for (SurveyQuestionVO question : questions) {
	            List<SurveyQItemVO> qItems = surveyMapper.selectQItems(question.getQstnNo());
	            question.setAnswers(qItems);
	        }
	        survey.setQuestions(questions);
	    }
		return survey;
	}


	@Override
	public List<SurveyParticpantVO> selectPrtcp(int survNo) {
		List<SurveyParticpantVO> list = surveyMapper.selectPrtcp(survNo);
		return list;
	}


	@Override
	public int isSurveyParticipated(String emplId) {
		
		return surveyMapper.isSurveyParticipated(emplId);
	}


	@Override
	public int submitSurvey(SurveyRspnsCnVO cnVO) {
		return surveyMapper.submitSurvey(cnVO);
	}


	@Override
	public int surveyParticipated(SurveyParticpantVO surveyParticpantVO) {
		surveyMapper.surveyParticipated(surveyParticpantVO);
		return surveyParticpantVO.getSurvPatcpntNo();
	}


	@Override
	public int updateEndSurvey() {
		return surveyMapper.updateEndSurvey();
	}


	@Override
	public int countTotalEmpl() {
		return surveyMapper.countTotalEmpl();
	}


	@Override
	public List<SurveyVO> selectSurveyCatList() {
		return surveyMapper.selectSurveyCatList();
	}


	@Override
	public int closeSurveys(List<String> surveyNos) {
		return surveyMapper.closeSurveys(surveyNos);
	}


	@Override
	public List<Map<String, Object>> selectResponCntSurvey(int surveyNo) {
		return surveyMapper.selectResponCntSurvey(surveyNo);
	}


	@Override
	public List<Map<String, Object>> selectSurveyList(String emplId) {
		
		return surveyMapper.selectSurveyList(emplId);
	}


	@Override
	public int checkSurvey() {
		
		return surveyMapper.checkSurvey();
	}


	@Override
	public List<EmployeeVO> selectEmplSurvList() {
		// TODO Auto-generated method stub
		return surveyMapper.selectEmplSurvList();
	}





	
}
