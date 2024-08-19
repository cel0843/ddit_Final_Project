package kr.or.ddit.vo;

import lombok.Data;

@Data
public class AprvDeptVO {
	private int deptDataNo;
	private int aprvId;
	private String formCd;
	private String emplId;
	private String deptCd;
	private String deptNm;
	private String afterDeptCd;
	private String afterDeptNm;
	private String positionCdNm;
	private String emplNm;
}
