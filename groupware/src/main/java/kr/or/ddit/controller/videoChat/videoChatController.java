package kr.or.ddit.controller.videoChat;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.vo.CustomEmployeeVO;
import lombok.extern.slf4j.Slf4j;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

@Controller
@Slf4j
@RequestMapping(value = "/egg")
public class videoChatController {

	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@RequestMapping(value = "/videoChat", method = RequestMethod.GET)
	public String videoChat_main(Model model) throws Exception {
		OkHttpClient client = new OkHttpClient();
		Request request = new Request.Builder()
				.url("https://openapi.gooroomee.com/api/v1/room/list?page=1&limit=10&sortCurrJoinCnt=true")
				.get()
				.addHeader("accept", "application/json")
				.addHeader("X-GRM-AuthToken", "12056163501988613cf51b7b51cdd8140bb172761d02211a8b")
				.build();

		Response response = client.newCall(request).execute();
		// org.json.simple 사용
		JSONParser jsonParser = new JSONParser();
		Object obj = jsonParser.parse(response.body().string());
		JSONObject jsonObj = (JSONObject) obj;

		log.info("##### jsonObject : \n" + jsonObj + "\n");

		model.addAttribute("roomList", jsonObj);

		return "egg/videoChat/videoChat";
	}

	@RequestMapping(value = "/videoChatJoin", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject join(@RequestBody Map<String, Object> jsonObj, HttpServletRequest request, Model model) throws Exception {
		log.info("join메소드 실행!");
		HttpSession session = request.getSession();
		
		String emplId = ((CustomEmployeeVO) session.getAttribute("emplInfo")).getEmplId();
		String roomId = jsonObj.get("roomId").toString();

		OkHttpClient client = new OkHttpClient();

		MediaType mediaType = MediaType.parse("application/x-www-form-urlencoded");
		okhttp3.RequestBody body = okhttp3.RequestBody.create(mediaType, "roomId=" + roomId + "&username=" + emplId
				+ "&roleId=participant&apiUserId=gooroomee-" + emplId + "&ignorePasswd=false");
		Request req = new Request.Builder()
				.url("https://openapi.gooroomee.com/api/v1/room/user/otp/url")
				.post(body)
				.addHeader("accept", "application/json").addHeader("content-type", "application/x-www-form-urlencoded")
				.addHeader("X-GRM-AuthToken", "12056163501988613cf51b7b51cdd8140bb172761d02211a8b").build();

		Response response = client.newCall(req).execute();
		
		JSONParser jsonParser = new JSONParser();
		Object obj = jsonParser.parse(response.body().string());
		JSONObject jsonObj2 = (JSONObject) obj;

		return jsonObj2;
	}

	@RequestMapping(value = "/deleteRoom", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject deleteRoom(@RequestBody Map<String, Object> jsonObj) throws Exception {
		String roomId = jsonObj.get("roomId").toString();
		OkHttpClient client = new OkHttpClient();

		Request req = new Request.Builder()
				.url("https://openapi.gooroomee.com/api/v1/room/" + roomId)
				.delete(null).addHeader("accept", "application/json")
				.addHeader("X-GRM-AuthToken", "12056163501988613cf51b7b51cdd8140bb172761d02211a8b").build();

		Response res = client.newCall(req).execute();

		client = new OkHttpClient();

		req = new Request.Builder()
				.url("https://openapi.gooroomee.com/api/v1/room/list?page=1&limit=10&sortCurrJoinCnt=true")
				.get()
				.addHeader("accept", "application/json")
				.addHeader("X-GRM-AuthToken", "12056163501988613cf51b7b51cdd8140bb172761d02211a8b")
				.build();

		res = client.newCall(req).execute();

		JSONParser jsonParser = new JSONParser();
		Object obj = jsonParser.parse(res.body().string());
		JSONObject jsonObj2 = (JSONObject) obj;

		return jsonObj2;
	}

	@ResponseBody
	@RequestMapping(value = "/createRoom", method = RequestMethod.POST)
	public JSONObject createroom(@RequestBody Map<String, Object> jsonObj) throws Exception {

		String roomName = jsonObj.get("roomName").toString();
		String password = jsonObj.get("password").toString();
		String maxJoinCount = jsonObj.get("maxJoinCount").toString();

		log.info("##### 회의실 생성 정보 >> 이름 : " + roomName +" 비밀번호 : "+ password + " 인원 : " + maxJoinCount);
		
		OkHttpClient client = new OkHttpClient();
		MediaType mediaType = MediaType.parse("application/x-www-form-urlencoded");
		okhttp3.RequestBody body = okhttp3.RequestBody.create(mediaType,
				"callType=P2P&liveMode=false&maxJoinCount="+maxJoinCount+"&liveMaxJoinCount=100&passwd="+password+"&layoutType=4&roomTitle=" + roomName
				+ "&durationMinutes=3000");
		Request req = new Request.Builder().url("https://openapi.gooroomee.com/api/v1/room")
				.post(body)
				.addHeader("accept", "application/json")
				.addHeader("content-type", "application/x-www-form-urlencoded")
				.addHeader("X-GRM-AuthToken", "12056163501988613cf51b7b51cdd8140bb172761d02211a8b")
				.build();

		Response res = client.newCall(req).execute();

		client = new OkHttpClient();
		req = new Request.Builder()
				.url("https://openapi.gooroomee.com/api/v1/room/list?page=1&limit=10&sortCurrJoinCnt=true")
				.get()
				.addHeader("accept", "application/json")
				.addHeader("X-GRM-AuthToken", "12056163501988613cf51b7b51cdd8140bb172761d02211a8b")
				.build();

		res = client.newCall(req).execute();

		JSONParser jsonParser = new JSONParser();
		Object obj = jsonParser.parse(res.body().string());
		JSONObject jsonObj2 = (JSONObject) obj;

		return jsonObj2;

	}

}
