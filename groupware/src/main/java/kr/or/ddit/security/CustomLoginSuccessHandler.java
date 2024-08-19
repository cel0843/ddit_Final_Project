package kr.or.ddit.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;

import kr.or.ddit.service.alarm.IAlarmService;
import kr.or.ddit.vo.AlarmVO;
import kr.or.ddit.vo.CustomEmployeeVO;
import kr.or.ddit.vo.CustomUser;
import lombok.extern.slf4j.Slf4j;

//인증(로그인) 전에 접근을 시도한 URL로 리다이렉트하는 기능을 가지고 있음
//스프링 시큐리티에서 기본적으로 사용되는 구현 클래스임
@Slf4j
public class CustomLoginSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {
	
	private RequestCache requestCache = new HttpSessionRequestCache();
	
	//요청파라미터 : {username=admin,password=java}
	@Override
	public void onAuthenticationSuccess(
			HttpServletRequest request
			, HttpServletResponse response
			, Authentication auth) throws ServletException, IOException {
		//******
		CustomUser customUser = (CustomUser)auth.getPrincipal();
		CustomEmployeeVO emplInfo = customUser.getCustomEmpl();
		log.info("username : " + customUser.getUsername()); //admin
		
		// HttpSession에 CustomEmployeeVO 저장
        HttpSession session = request.getSession();
        session.setAttribute("emplInfo", emplInfo);
        
		// 시큐니티 내 발생한 에러 세션정보 삭제
		clearAuthenticationAttribute(request);
		
		// 요청이 가지고 있는 request 내 타겟 정보
		// 타겟정보가 존재한다면 타겟으로 이동시켜준다.
		SavedRequest savedRequest = requestCache.getRequest(request, response);
		String targetUrl = "";
	
		if (savedRequest != null) {
			targetUrl = savedRequest.getRedirectUrl();
		}else {
			targetUrl = "/egg/main";
		}
		log.info("Login Success targetUrl : " + targetUrl);
		response.sendRedirect(targetUrl);
	}

	private void clearAuthenticationAttribute(HttpServletRequest request) {
		HttpSession session = request.getSession();
		if (session == null) {
			return;
		}
		session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
	}
	
	
	
}
