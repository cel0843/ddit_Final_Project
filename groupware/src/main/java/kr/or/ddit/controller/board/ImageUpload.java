package kr.or.ddit.controller.board;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ImageUpload {
	//CKEDITOR 본문 내용에 이미지 업로드하기
	@RequestMapping(value = "/boardImageUpload.do")
	public String imageUpload(
              MultipartHttpServletRequest multiFile,
			  HttpServletRequest req,
			  HttpServletResponse resp
			  //CKEDITOR4 특정 버전 이후부터 html형식의 데이터를 리턴하는 방법에서 json 데이터를 구성해서
			  //리턴하는 방식으로 변경됨
			) throws IOException {
		log.info("들어오긴하니?"); // del
		JsonObject json = new JsonObject();//json객체를 만들기 위한 준비
		//파일뿐만이 아닌 여러데이터를 보내야하기 때문에 json타입으로 만든다
		PrintWriter printWriter = null;// 외부 응답으로 내보낼때 사용할 객체
		OutputStream out = null; //본문 내용에 추가한 이미지를 파일로 생성할 객체
		long limitSize = 1024 * 1024 * 10; //업로드 파일 최대 크기 (10mb)
		
		
		//CKEDITOR 본문 내용에 이미지를 업로드 해보면 'upload'라는 키로 파일 데이터가 전달되는걸 확인할 수 있습니다
		MultipartFile file = multiFile.getFile("upload");
		
		//파일 객체가 null이 아니고 파일 사이즈가 0보다 크고 파일명이 공백이 아닌 경우는 무조건 파일 데이터가 존재하는 경우
		if(file != null && file.getSize() > 0 && StringUtils.isNotBlank(file.getName())) {
			if(file.getContentType().toLowerCase().startsWith("image/")) {
				if(file.getSize() > limitSize) { //업로드한 파일 사이즈가 촤대 크기보다 클 때
					/*
					 *{
					 *	"uploaded" : 0,
					 *  "error" : [
					 *  	{
					 *  		"massage" : "10MB미만의 이미지만 업로드 가능합니다."
					 *      }
					 *  ]
					 *} 
					 */
					JsonObject jsonMsg = new JsonObject();
					JsonArray jsonArr = new JsonArray();
					jsonMsg.addProperty("message", "10MB 미만의 이미지만 업로드 가능합니다.");
					jsonArr.add(jsonMsg);
					json.addProperty("uploaded", 0);
					json.add("error", jsonArr.get(0));
					
					resp.setCharacterEncoding("UTF-8");
					// 위 형식의 데이터를 출력한다
					printWriter = resp.getWriter();
					printWriter.print(json);
				}else { //정상 범위 내 파일 일 떄
					/*
					 * {
					 * 	"uploaded" : 1,
					 *  "fileName" : "xxxxxxxx-xxxxxx.jpg",
					 *  "url" : "/resources/img/xxxxxxxxx-xxxxxxx.jpg"
					 * } 
					 */
					try {
						String fileName = file.getOriginalFilename(); // 파일명 얻어오기
						byte[] bytes = file.getBytes(); //파일 데이터 얻어오기
						String uploadPath = req.getServletContext().getRealPath("/resources/upload/");
						
						File uploadFile = new File(uploadPath);
						if(!uploadFile.exists()) {
							uploadFile.mkdirs();
						}
						
						fileName = UUID.randomUUID().toString() + "_" + fileName;
						uploadPath = uploadPath + "/" + fileName; //업로드 경로 + 파일명
						out = new FileOutputStream(new File(uploadPath));
						out.write(bytes); //파일 복사
						
						printWriter = resp.getWriter();
						String fileUrl = "/resources/upload/" + fileName;
						
						json.addProperty("uploaded",1);
						json.addProperty("fileName", fileName);
						json.addProperty("url",fileUrl);
						
						printWriter.println(json);
						
					} catch (IOException e) {
						e.printStackTrace();
					}finally {
						if(out != null) {
							out.close();
						}
						if(printWriter != null) {
							printWriter.close();
						}
					}
				}
			}
		}
		return null;
		
		
	}
}
