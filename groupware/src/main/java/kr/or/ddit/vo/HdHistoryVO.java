package kr.or.ddit.vo;

import lombok.Data;

@Data
public class HdHistoryVO {
	private int hdNo;
	private String emplId;
	private int aprvId;
	private String aplyDt;
	private String hdBgngHr;
	private String hdEndHr;
	private String hdCd;
	private double hdCnt;
	private String hdReson;
	private double leftCnt;
}
