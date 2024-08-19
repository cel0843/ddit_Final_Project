package kr.or.ddit.vo;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class CustomBoardVO {
	private int RNum;
	private int bbsNo;
	private String emplId;
	private String emplNm;
	private String bbsTtl;
	private String bbsCn;
	private String bbsHit;
	private String bbsCtrDt;
	private String bbsMdfcnDt;
	private String bbsTyCd;
	private int fileGroupNo;
	
	private Integer[] delFileNo;
	private MultipartFile[] boFileArr;
	private List<AttachFileVO> boardFileList;
	
	
	public void setBoFile(MultipartFile[] boFileArr) {
		this.boFileArr = boFileArr;
		if (boFileArr != null) {
			List<AttachFileVO> boardFileList = new ArrayList<AttachFileVO>();
			for (MultipartFile item : boFileArr) {
				if (StringUtils.isBlank(item.getOriginalFilename())) {
					continue;
				}
				
				AttachFileVO attachFileVO = new AttachFileVO(item);
				boardFileList.add(attachFileVO);
			}
			this.boardFileList = boardFileList;
		}
	}
	
}
