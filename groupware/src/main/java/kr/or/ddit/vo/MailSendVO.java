package kr.or.ddit.vo;

import lombok.Data;

@Data
public class MailSendVO {

	private int emlNo;
	private int mreNo;
    private String emplId;
    private String sendId;
    private String emlTtl;
    private String emlCn;
    private String emlDt; // 날짜 필드를 String 타입으로 유지
    private String emlDrfYn;
    private String mscCode;
    private Integer fileGroupNo;
    private String emplNm;
    private String mreYn;
    private String gubun;	//EMAIL_SEND와 MAIL_RE의 구분(휴지통 전용)
}
