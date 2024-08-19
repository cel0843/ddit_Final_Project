package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import kr.or.ddit.vo.EmployeeVO;
import kr.or.ddit.vo.SurveyParticpantVO;
import kr.or.ddit.vo.SurveyQItemVO;
import kr.or.ddit.vo.SurveyQuestionVO;
import kr.or.ddit.vo.SurveyRspnsCnVO;
import kr.or.ddit.vo.SurveyVO;

public interface ISurveyMapper {

	List<Map<String, Object>> selectSurveyList(Map<String, Object> params);

	int insertSurvey(SurveyVO surveyVO);

	int insertQuestion(SurveyQuestionVO question);

	int insertQItem(SurveyQItemVO qItem);

	SurveyVO selectSurvey(int survNo);

	List<SurveyQuestionVO> selectQuestions(int survNo);

	List<SurveyQItemVO> selectQItems(int qstnNo);

	List<SurveyParticpantVO> selectPrtcp(int survNo);

	int isSurveyParticipated(String emplId);

	int submitSurvey(SurveyRspnsCnVO cnVO);

	int surveyParticipated(SurveyParticpantVO surveyParticpantVO);

	int endSurvey(Integer integer);

	int updateEndSurvey();

	int countTotalEmpl();

	List<SurveyVO> selectSurveyCatList();

	int closeSurveys(@Param("surveyNos") List<String> surveyNos);

	List<Map<String, Object>> selectResponCntSurvey(int surveyNo);

	List<Map<String, Object>> selectSurveyList(@Param("emplId") String emplId, @Param("select") String select, @Param("searchText") String searchText, @Param("searchText")String survStts, @Param("searchText")String survPatcpCnt);

	List<Map<String, Object>> selectSurveyList(String emplId);

	int checkSurvey();

	List<EmployeeVO> selectEmplSurvList();

}
