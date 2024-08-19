package kr.or.ddit.vo;

import lombok.Data;

@Data
public class BoardVO {
	
	private int bbsNo;
	private String emplId;
	private String bbsTtl;
	private String bbsCn;
	private int bbsHit;
	private String bbsCtrDt ;
	private String bbsMdfcnDt;
	private String bbsTyCd;
	private int fileGroupNo;

}
