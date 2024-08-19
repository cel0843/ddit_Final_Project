
package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

@Data
public class AprvProjectVO {
	private String projNm;
	private String projCrtYmd;		// 생성일자 
	private String projDdlnYmd;		// 마감일자
	private String projMdfcnYmd;		//수정일자
	private String projExpln;		//수정일자
	private List<String> prtcpList;	// 참가자 리스트->참조자
	private List<String> prtcpAuthList;	// 참가자 리스트->참조자
	
	private int aprvId;
}
