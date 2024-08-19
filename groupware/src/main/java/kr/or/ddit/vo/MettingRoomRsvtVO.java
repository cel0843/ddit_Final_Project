package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

@Data

public class MettingRoomRsvtVO {

	 private int rsvtNo;		// 회의실예약번호
	 private int roomNo;		// 회의실번호
	 private String roomNm;		// 회의실명
	 private String emplId;		// 사원번호(아이디)
	 private String rsvtBgngDt;	// 시작일시
	 private String rsvtEndDt;	// 종료일시
	 private Date dateRsvstBgngDt;
	 private Date dateRsveEndDt;
	 private String roomNope;
	 private String roomEqpmnt;
	 
	 //1의 예약에 1의 회의실
	 private MettingRoomVO mettingRoomVO;
}
