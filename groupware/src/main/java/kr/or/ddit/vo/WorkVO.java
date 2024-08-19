package kr.or.ddit.vo;


import lombok.Data;

@Data
public class WorkVO {
	private int workNo;			// 근무번호
	private String emplId;		// 사원번호
	private String workBgngHr;	// 시작시간
	private String workEndHr;	// 종료시간
	private String attDt;		// 출근일시
	
	
	private String workDayHours;	// 하루 근무 시간
	private String workWeekHours;	// 일주일 근무 시간
	
	private String overTime;	// 연장시간 계산
	
	private String workMonth;	// 근태현황 조회할 월
	private String numWeek;	// 몇주차인지
	
	private String workState;	// 정상, 지각, 결근
	
	private String hdBgngHr;	// 휴가 시작일 
	private String hdEndHr;		// 휴가 종료일
}   
