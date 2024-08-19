package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

@Data
public class ProjectsVO {
	private int projNo;
	private String projName;
	private String projCrtYmd;		// 생성일자 
	private String projDdlnYmd;		// 마감일자
	private String projMdfcnYmd;		//수정일자
	private String projExpln;			
	private int projProgPer;
	private String projDelYn;
	private List<ProjectPrtcpVO> prtcpList;	// 참가자 리스트
}
