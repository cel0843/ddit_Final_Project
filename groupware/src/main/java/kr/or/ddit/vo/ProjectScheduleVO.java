package kr.or.ddit.vo;


import java.sql.Timestamp;

import lombok.Data;

@Data
public class ProjectScheduleVO {
	private int projSchdlNo;
	private int projNo;
	private String projSchdlNm;
	private String projSchdlCn;
	private String projSchdlColor;
	private Timestamp projSchdlBgngDt;
	private Timestamp projSchdlEndDt;

}
