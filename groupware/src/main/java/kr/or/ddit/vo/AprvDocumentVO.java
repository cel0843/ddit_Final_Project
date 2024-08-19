package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

@Data
public class AprvDocumentVO {
	private int aprvId;
	private String formCd;
	private String emplId;
	private String AgtId;
	private String emplNm;
	private String deptNm;	// 기안자의 부서가 필요
	private String aprvTtl;
	private String aprvCn;
	private Date atrzDmndDt;
	private Date atrzCmptnDt;
	private String prgrsSttsTy;
	private Integer fileGroupNo;
	
	
	// 결재 라인 관련 컬럼
	private Integer aprvOrder;
	private String aprvStatus;
	
}
