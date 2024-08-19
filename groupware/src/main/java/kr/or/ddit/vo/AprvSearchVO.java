package kr.or.ddit.vo;

import lombok.Data;

@Data
public class AprvSearchVO {
	private int aprvId;
	private String[] atrzDmndDts;
	private String atrzDmndDt;
	private String atrzDmndDt1;
	private String atrzDmndDt2;
	private String[] atrzCmptnDts;
	private String atrzCmptnDt;
	private String atrzCmptnDt1;
	private String atrzCmptnDt2;
	private String emplNm;
	private String deptNm;
	private String lastAprv;
	private String aprvTtl;
	private String prgrsSttsTy;
	private String aprvStatus;
	private String searchFlag;
}                              
