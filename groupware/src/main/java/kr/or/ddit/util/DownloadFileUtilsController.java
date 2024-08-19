package kr.or.ddit.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;

import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/egg")
public class DownloadFileUtilsController {
	
	private static String resourcePath = "C:/groupware_file_upload/upload_files/";
	
	@RequestMapping(value = "/downloadFile", method = RequestMethod.POST)
	public ResponseEntity<InputStreamResource> downloadFile(@RequestParam String fileName, @RequestParam String originalFileName) throws FileNotFoundException {
		File file = new File(resourcePath + fileName);
        if (!file.exists()) {
            throw new FileNotFoundException("File not found with name " + fileName);
        }

        FileInputStream fileInputStream = new FileInputStream(file);
        InputStreamResource resource = new InputStreamResource(fileInputStream);

        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment;filename=" + originalFileName)
                .contentType(MediaType.APPLICATION_OCTET_STREAM)
                .contentLength(file.length())
                .body(resource);
    }
	
	
}
