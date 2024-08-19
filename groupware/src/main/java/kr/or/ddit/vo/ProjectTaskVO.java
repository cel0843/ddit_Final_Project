package kr.or.ddit.vo;

import lombok.Data;

@Data
public class ProjectTaskVO {
	private int taskNo;
	private int projNo;
	private String emplId;
	private String taskTtl;
	private String taskCn;
	private String taskBgngYmd;
	private String taskDdlnYmd;
	private String taskMdfcnYmd;
	private int taskPrgsPer;
	private String tkprCode;
	private String tkstCode;
	private String taskRegYmd;
	private String taskCtrSn;
	private String taskDelYn;
}
