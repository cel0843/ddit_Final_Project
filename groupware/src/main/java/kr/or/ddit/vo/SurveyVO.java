package kr.or.ddit.vo;


import java.util.List;


import lombok.Data;

@Data
public class SurveyVO {
    private int survNo;
    private String survTtlNm;
    private String survCn;
    private String survRegDt;
    private String survEndDt;
    private String survStts;
    private String survDelYn;
	private int survPatcpCnt;
	private String survCat;
    private List<SurveyQuestionVO> questions;

}
