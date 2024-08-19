package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

@Data
public class ProjectPrtcpVO {
	private int projNo;
	private String emplId;
	private String projMngrYn;
	private String projJoinYn;
	private List<ProjectTaskVO> taskList;
}
