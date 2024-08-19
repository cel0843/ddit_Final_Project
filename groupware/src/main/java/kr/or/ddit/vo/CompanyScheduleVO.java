package kr.or.ddit.vo;


import java.text.SimpleDateFormat;
import java.util.Date;

import lombok.Data;

@Data
public class CompanyScheduleVO {
	private int schdlNo;		// 스케줄 번호 (기본키)
	private String schdlNm;		// 제목
	private String schdlDt;		// 작성일
	private String schdlCnt;	// 내용
	private String schdlBgngDt;	// 스케줄 시작일
	private String schdlEndDt;	// 스케줄 종료일
	private String schdlPstn;	// 장소
	private String schdlRegSn;	// 사용자인지 관리자인지 등록자(권한) 필요없음
	private String schdlEmplId;	// 등록자
	private String schdlVl;		// 중요도
	private String schdlColor;	// 색깔
    // 포맷터 추가
    private static final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    public void setSchdlBgngDt(Date date) {
        this.schdlBgngDt = dateFormat.format(date);
    }

    public void setSchdlEndDt(Date date) {
        this.schdlEndDt = dateFormat.format(date);
    }
}   
