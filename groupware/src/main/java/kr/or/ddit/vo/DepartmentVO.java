package kr.or.ddit.vo;

import lombok.Data;

@Data
public class DepartmentVO {
	private String deptCd;		//부서코드
	private String deptNm;		//부서명
	private String deptUpperCd;	//상위부서코드
	private String dprlrNm;		//부서장명
	private String deptTelno;	//부서전화번호
	private String deptTySt;	//상태코드
}
 