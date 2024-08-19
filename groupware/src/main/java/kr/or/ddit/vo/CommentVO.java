package kr.or.ddit.vo;

import lombok.Data;

@Data
public class CommentVO {
	private int cmntNo;
	private String emplId;
	private String emplNm;
	private int bbsNo;
	private String cmntWrtDt;
	private String cmntMdfcnDt;
	private String cmntCn;
}
