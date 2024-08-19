package kr.or.ddit.vo;


import java.util.List;


import lombok.Data;

@Data
public class SurveyQuestionVO {
    private int qstnNo;
    private int survNo;
    private String qstnCn;
    private int qstnDispOrd;
    private List<SurveyQItemVO> answers;

}
