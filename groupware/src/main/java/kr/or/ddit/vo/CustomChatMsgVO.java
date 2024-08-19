package kr.or.ddit.vo;

import lombok.Data;

@Data
public class CustomChatMsgVO {
	private int chatMsgNo;
	private int chatRoomNo;
	private String emplId;
	private String emplName;
	private String emplProfileImg;
	private String chatMsgType;
	private String chatContent;
	private String chatWriteDate;
	private int fileGroupNo;
	private String imgFile;
	private int fileNo;
	private String filePath;
	private String fileStrgNm;
	private String fileOrgnlNm;
	private long fileSz;
	private String fileFancySize;
	private String fileCtrDt;
	private String fileType;
	
}
