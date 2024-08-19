package kr.or.ddit.service.survey;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.EmployeeVO;
import kr.or.ddit.vo.SurveyParticpantVO;
import kr.or.ddit.vo.SurveyRspnsCnVO;
import kr.or.ddit.vo.SurveyVO;

public interface ISurveyService {

	/**
	 * 설문 리스트 
	 * @param emplId
	 * @return List
	 */
	List<Map<String, Object>> selectSurveyList(String emplId);
	
	
	/**
	 * 설문지 저장(제작)
	 * @param survey
	 * @return int
	 */
	int saveSurvey(SurveyVO survey);

	SurveyVO selectSurvey(int surveyNo);
	
	/**
	 * 설문 정보 
	 * @param surveyNo
	 * @return List
	 */
	List<SurveyParticpantVO> selectPrtcp(int surveyNo);
	
	/**
	 * 설문 참가 여부 
	 * @param emplId
	 * @return int
	 */
	int isSurveyParticipated(String emplId);

	/**
	 * 설문 제출 
	 * @param cnVO
	 * @return int
	 */
	int submitSurvey(SurveyRspnsCnVO cnVO);

	/**
	 * 설문 참가자 등록 
	 * @param surveyParticpantVO
	 * @return int
	 */
	int surveyParticipated(SurveyParticpantVO surveyParticpantVO);

	/**
	 * 설문 마감, 최종 전체 인원 업데이트   
	 * @return int
	 */
	int updateEndSurvey();
	
	/**
	 * 사원 전체 인원
	 * @return int
	 */
	int countTotalEmpl();


	/**
	 * 설문 카테고리 조회
	 * @return List
	 */
	List<SurveyVO> selectSurveyCatList();


	/**
	 * 설문 선택 마감 
	 * @return int
	 */
	int closeSurveys(List<String> surveyNos);


	/**
	 * 설문질문의 설문 문항   
	 * @return List
	 */
	List<Map<String, Object>> selectResponCntSurvey(int surveyNo);


	/**
	 * 설문 질문 
	 * @return List
	 */
	List<Map<String, Object>> selectSurveyList(Map<String, Object> params);

	
	/**
	 * 설문 질문 
	 * @return
	 */
	int checkSurvey();

	
	/**
	 * 설문 참여 유무  
	 * @return
	 */
	List<EmployeeVO> selectEmplSurvList();



}
