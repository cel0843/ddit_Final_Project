package kr.or.ddit.vo;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class AlarmVO {
	private int alarmNo;
	private String emplId;
	private String alarmTitle;
	private String alarmConts;
	private String alarmCtrDt;
	private String alarmTyCd;
	private String alarmReadYn;
}
