package kr.or.ddit.vo;

import org.apache.commons.io.FileUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class AttachFileVO {
	
	private MultipartFile item;
	public int fileGroupNo;
	public int fileNo;
	public String filePath;
	public String fileStrgNm;
	public String fileOrgnlNm;
	public long fileSz;
	public String fileFancysize;
	public String fileCtrDt;
	public String fileType;
	public String fileDelYn;
	
	public AttachFileVO() {}
	public AttachFileVO(MultipartFile item) {
		this.item = item;
		this.fileOrgnlNm = item.getOriginalFilename();
		this.fileSz = item.getSize();
		//600KB용량을 갖고 있는 파일을 MB로 환산하면 0.6MB
		this.fileFancysize = FileUtils.byteCountToDisplaySize(fileSz);
		this.fileType = item.getContentType();
	}
	
	@Override
	public String toString() {
		return "AttachFileVO [item=" + item + ", fileGroupNo=" + fileGroupNo + ", fileNo=" + fileNo + ", filePath="
				+ filePath + ", fileStrgNm=" + fileStrgNm + ", fileOrgnlNm=" + fileOrgnlNm + ", fileSz=" + fileSz
				+ ", fileFancysize=" + fileFancysize + ", fileCtrDt=" + fileCtrDt + ", fileType=" + fileType
				+ ", fileDelYn=" + fileDelYn + "]";
	}
	
}
