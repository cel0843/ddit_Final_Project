package kr.or.ddit.vo;

import org.apache.commons.io.FileUtils;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;

@Data
public class CustomFileVO {

	@JsonIgnore
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
    public String fileDelyn;

    public CustomFileVO() {}

    public CustomFileVO(MultipartFile item) {
        this.item = item;
        this.fileOrgnlNm = item.getOriginalFilename();
        this.fileSz = item.getSize();
        this.fileFancysize = FileUtils.byteCountToDisplaySize(fileSz);
        this.fileType = item.getContentType();
    }
}
