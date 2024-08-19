package kr.or.ddit.vo;


import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class DataVO {
	
	private int fldNo;
	private int upFldNo;
	private String emplId;
	private Date fldCrtDt;
	private Date lastMdfcnDt;
	private String fldDelYn;
	private int fileGroupNo;
	private String fldTyCd;
	private String fldNm;
	private String upFldNm;
	private String isMakeFolder;
	
	private MultipartFile[] file;
	private List<AttachFileVO> attachFileList;
	
	public void setFile(MultipartFile[] file) {
		this.file = file;
		if(file != null) {
			List<AttachFileVO> attachFileList = new ArrayList<AttachFileVO>();
			for (MultipartFile item : file) {
				if(StringUtils.isBlank(item.getOriginalFilename())) {
					continue;
				}
				AttachFileVO attachFileVO = new AttachFileVO(item);
				attachFileList.add(attachFileVO);
			}
			this.attachFileList = attachFileList;
		}
	}

	}

