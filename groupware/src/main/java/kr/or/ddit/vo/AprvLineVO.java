package kr.or.ddit.vo;

import lombok.Data;

@Data
public class AprvLineVO {
	
	private int aprvLineNo;
	private int aprvId;
	private String agtId;
	
	private String agtNm;
	private String emplId;
	private String emplNm;				// join으로 추가
	private String positionCdNm;		// join으로 추가
	private String agtPositionNm;		// join으로 추가
	private int aprvOrder;
	private String aprvStatus;
	private String aprvDt;
	private String aprvOpnn;
	private String lastAprv;
	private String dcrbYn;
	private String finalAprvYn;
	private String esgn;
	private String cmptnYn;
	private String aprvStatusNm;
	private String formCd;
	private String bgngYmd;
	private String endYmd;
	private String useYn;
	private int projNo;
	
	private String lastEsgn;
	private String lastEmplNm;
}
