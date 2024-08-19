package kr.or.ddit.vo;


import java.util.Date;

import lombok.Data;

@Data

public class FixuresRsvtVO {
	private String fixRsvtCd;		// 비품코드
	private int fixRsvtNo;			// 비품예약코드
	private String emplId;			// 비품예약자(사번)
    private int fixNo;			// 비품번호
    private String fixRsvtBgngDt;	// 시작일시
    private String fixRsvtEndDt;	// 종료일시
    private Date dateFixRsvtBgngDt;	// 시작일시
    private Date dateFixRsvtEndDt;	// 종료일시
    
    // test용 코드
    private String fixNm;	// 비품명
    
  //1의 예약에 1의 비품
    private FixuresVO fixuresVO;
}
