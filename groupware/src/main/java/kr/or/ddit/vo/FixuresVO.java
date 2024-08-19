package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

@Data
public class FixuresVO {

	private int fixNo;		// 비품번호
	private String fixNm;	// 비품명
	private String fixTyCd;	// 비품유형코드
	private String fixImg;	// 비품사진
	
	private List<FixuresRsvtVO> fixuresRsvtVOList;
}
