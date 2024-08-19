package kr.or.ddit.tiles;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.TextStyle;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.ddit.service.IGridStackService;
import kr.or.ddit.service.IWorkService;
import kr.or.ddit.service.approval.IApprovalService;
import kr.or.ddit.service.board.IBoardService;
import kr.or.ddit.service.mailService.IMailService;
import kr.or.ddit.service.project.IProjectService;
import kr.or.ddit.vo.CustomBoardVO;
import kr.or.ddit.vo.CustomEmployeeVO;
import kr.or.ddit.vo.GridStackVO;
import kr.or.ddit.vo.WorkVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class TilesController {
	
	@Inject
	private IWorkService service;
	
	@Inject
	private IGridStackService gridService;
	
	@Inject
	private IMailService mailService;
	
	@Inject
	private IApprovalService appService;
	

	@Inject
	private IBoardService boardService;
	
	// 관리자
	@PreAuthorize("hasAnyRole('ROLE_ADMIN')")
	@RequestMapping(value = "/admin/main", method = RequestMethod.GET)
	public String admin_main(HttpServletRequest request, Model model) {
		log.info("admin_main() 실행...!");
		HttpSession session = request.getSession();
		CustomEmployeeVO emplInfo = (CustomEmployeeVO) session.getAttribute("emplInfo");
		String emplId = emplInfo.getEmplId();
        // 오늘 날짜 가져오기
        LocalDate today = LocalDate.now();

        // 날짜 형식 지정
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy년 MM월 dd일");

        // 오늘 날짜를 형식에 맞게 변환
        String formattedDate = today.format(formatter);

        // 요일 가져오기
        String dayOfWeek = today.getDayOfWeek().getDisplayName(TextStyle.SHORT, Locale.KOREAN);

        // 최종 형식으로 출력
        String resultToday = formattedDate + "(" + dayOfWeek + ")";
		
		String sTime;
		String eTime;
		String startTime;
		String endTime;
		log.info("user_main() 실행...!");
		try {
			WorkVO times = service.todayWorkTime(emplId);
			
			startTime = times.getWorkBgngHr();
			endTime = times.getWorkEndHr();
			
			sTime = startTime.substring(11, 16);
			eTime = endTime.substring(11, 16);
		}catch (NullPointerException e) {
			sTime = "--:--";
			eTime = "--:--";
		}
		
	    List<GridStackVO> gridList = new ArrayList<>();
	    gridList = gridService.selectGridStack(emplId);
		
	    int uReadMailCount = mailService.reCount(emplId);
	    int aprvDocListCount = appService.aprvDocListCount(emplId);
	    
	    List<CustomBoardVO> boardList = boardService.mainSummaryBoardSelect();
	    
	    int playingworkCount = service.workingCount(emplId); 
	    
	    model.addAttribute("playingworkCount", playingworkCount);
	    model.addAttribute("boardList", boardList);
	    model.addAttribute("aprvDocListCount", aprvDocListCount);
	    model.addAttribute("uReadMailCount", uReadMailCount);
	    model.addAttribute("gridList", gridList);
		model.addAttribute("sTime", sTime);
		model.addAttribute("eTime", eTime);
		model.addAttribute("resultToday", resultToday);
		return "admin/home";
	}
	
	// 사용자
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@RequestMapping(value = "/egg/main", method = RequestMethod.GET)
	public String user_main(HttpServletRequest request, Model model) {
//		emplId = "A001";
		HttpSession session = request.getSession();
		CustomEmployeeVO emplInfo = (CustomEmployeeVO) session.getAttribute("emplInfo");
		String emplId = emplInfo.getEmplId();
        // 오늘 날짜 가져오기
        LocalDate today = LocalDate.now();

        // 날짜 형식 지정
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy년 MM월 dd일");

        // 오늘 날짜를 형식에 맞게 변환
        String formattedDate = today.format(formatter);

        // 요일 가져오기
        String dayOfWeek = today.getDayOfWeek().getDisplayName(TextStyle.SHORT, Locale.KOREAN);

        // 최종 형식으로 출력
        String resultToday = formattedDate + "(" + dayOfWeek + ")";
		
		String sTime;
		String eTime;
		String startTime;
		String endTime;
		log.info("user_main() 실행...!");
		try {
			WorkVO times = service.todayWorkTime(emplId);
			
			startTime = times.getWorkBgngHr();
			endTime = times.getWorkEndHr();
			
			sTime = startTime.substring(11, 16);
			eTime = endTime.substring(11, 16);
		}catch (NullPointerException e) {
			sTime = "--:--";
			eTime = "--:--";
		}
		
	    List<GridStackVO> gridList = new ArrayList<>();
	    gridList = gridService.selectGridStack(emplId);
		
	    int uReadMailCount = mailService.reCount(emplId);
	    
	    int aprvDocListCount = appService.aprvDocListCount(emplId);
	    
	    List<CustomBoardVO> boardList = boardService.mainSummaryBoardSelect();
	    
	    int playingworkCount = service.workingCount(emplId); 
	    
	    model.addAttribute("playingworkCount", playingworkCount);
	    model.addAttribute("boardList", boardList);
	    model.addAttribute("aprvDocListCount", aprvDocListCount);
	    model.addAttribute("uReadMailCount", uReadMailCount);
	    model.addAttribute("gridList", gridList);
		model.addAttribute("sTime", sTime);
		model.addAttribute("eTime", eTime);
		model.addAttribute("resultToday", resultToday);
		return "egg/home";
	}

	
	
}
