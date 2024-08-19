package kr.or.ddit.controller.reservation;

import java.security.Principal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.service.Reservation.IReservationService;
import kr.or.ddit.vo.FixuresRsvtVO;
import kr.or.ddit.vo.FixuresVO;
import kr.or.ddit.vo.MettingRoomRsvtVO;
import kr.or.ddit.vo.MettingRoomVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/egg")

public class ReservationController {
	
	@Inject
	IReservationService service;
	
	//회의실 목록
	@GetMapping("/mettingRoomRes")
	public String mettingRoomRes(MettingRoomRsvtVO mettingRoomRsvtVO, Model model, MettingRoomVO mettingRoomVO, Principal principal) {
		log.info("mettingRoomRes");
		
		// Service 연결
		//회의실 목록
		List<MettingRoomVO> mettingRoomRes = service.mettingRoomRes();
		log.info("mettingRoomRes->mettingRoomRes : " + mettingRoomRes);
		
		//회의실 예약 목록
		List<MettingRoomRsvtVO> mettingRoomResList = service.mettingRoomResList();
		log.info("mettingRoomRes->mettingRoomResList : " + mettingRoomResList);
		
		model.addAttribute("mettingRoomRes",mettingRoomRes);
		model.addAttribute("mettingRoomResList",mettingRoomResList);
		
		return "egg/reservation/mettingRoomRes";
	}
	
	//회의실 상세, int roomNo
	// /egg/mettingRoomResDet?roomNo=3
	@GetMapping("/mettingRoomResDet")
	public String mettingRoomResDet(Model model, int rsvtNo) {
		log.info("mettingRoomResDet 실행 !!!!!!!!!!!!!!!");
		log.info("mettingRoomResDet->rsvtNo : " + rsvtNo);
		
		// Service 연결
		List<MettingRoomVO> mettingRoomRes = service.mettingRoomRes();
		log.info("mettingRoomRes->mettingRoomRes : " + mettingRoomRes);
		
		//회의실 상세
		MettingRoomVO mettingRoomVO = this.service.mettingRoomResDet(rsvtNo);
		log.info("mettingRoomResDet->mettingRoomVO : " + mettingRoomVO);
		
		//회의실 예약 상세
		List<MettingRoomRsvtVO> mettingRoomRsvtVOList = mettingRoomVO.getMettingRoomRsvtVOList();
		log.info("mettingRoomResDet->mettingRoomRsvtVOList : " + mettingRoomRsvtVOList);
		
		model.addAttribute("mettingRoomRes",mettingRoomRes);
		model.addAttribute("mettingRoomVO",mettingRoomVO);
		model.addAttribute("mettingRoomRsvtVOList",mettingRoomRsvtVOList);
		
		return "egg/reservation/mettingRoomResDet";
	}
	
//	@ResponseBody
//    @PostMapping("/mettinginsertRes")
//    public MettingRoomRsvtVO mettingInsertAjax(@RequestBody MettingRoomRsvtVO mettingRoomRsvtVO) {
//	      log.info("mettingInsertAjax->mettingRoomRsvtVO : " + mettingRoomRsvtVO);
//	      
//	      int result = this.lecService.insertLectureNotice(lectureNoticeVO);
//	      log.info("mettingInsertAjax->result : " + result);
//	      
//
//       return mettingRoomRsvtVO;
//    }
	
	// 예약 가능 시간 확인 메소드[회의실]
	@ResponseBody
	@PostMapping("/resTime")
	public int mettingConfirmAjax(@RequestBody MettingRoomRsvtVO mettingRoomRsvtVO) throws ParseException {
		log.info("mettingInsertAjax->mettingRoomRsvtVO : " + mettingRoomRsvtVO);
		
		String beginDateStr = mettingRoomRsvtVO.getRsvtBgngDt().replace("T", " ");
		String endDateStr = mettingRoomRsvtVO.getRsvtEndDt().replace("T", " ");
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Date beginDate = sdf.parse(beginDateStr);
		Date endDate = sdf.parse(endDateStr);
		
		mettingRoomRsvtVO.setDateRsvstBgngDt(beginDate); 
		mettingRoomRsvtVO.setDateRsveEndDt(endDate);
		
		
		int confirm = service.mettingSelectDet(mettingRoomRsvtVO);
		
		
		return confirm;
	}
	
	
	
	// 회의실 예약 등록
	@ResponseBody
	@PostMapping("/mettingInsertRes")
	public MettingRoomRsvtVO mettingInsertRes(@RequestBody MettingRoomRsvtVO mettingRoomRsvtVO) {
		int result = service.mettinginsertRes(mettingRoomRsvtVO);
		
		return mettingRoomRsvtVO;
	}
	
	
//	// 예약 등록
//	@RequestMapping(value = "/mettinginsertRes", method = RequestMethod.POST)
//	public String mettingInsertRes(MettingRoomRsvtVO mettingRoomRsvtVO, Model model) throws ParseException {
//		String goPage = "";
//		log.info("====>>{}",mettingRoomRsvtVO);
//		// 예약 내역 확인 쿼리에서 조회 해야함
//		String beginDateStr = mettingRoomRsvtVO.getRsvtBgngDt().replace("T", " ");
//		String endDateStr = mettingRoomRsvtVO.getRsvtEndDt().replace("T", " ");
//		
//		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
//		Date beginDate = sdf.parse(beginDateStr);
//		Date endDate = sdf.parse(endDateStr);
//		
//		mettingRoomRsvtVO.setDateRsvstBgngDt(beginDate); 
//		mettingRoomRsvtVO.setDateRsveEndDt(endDate);
//		
//		
//		int confirm = service.mettingSelectDet(mettingRoomRsvtVO);
//		
//		
//		// 만약에 조회 내역이 0보다 크면 저장이 안되게 리턴해줘야 되고 
//		if (confirm > 0) {
//		    model.addAttribute("mettingRoomRsvtVO", mettingRoomRsvtVO);
//	        model.addAttribute("message", "해당 시간에는 예약 불가");
//	        goPage = "egg/reservation/mettingRoomRes";
//		}else {
//			log.info("확인 !!!!!: {}",mettingRoomRsvtVO );
//			service.mettinginsertRes(mettingRoomRsvtVO);
//			goPage = "redirect:/egg/mettingRoomResDet?rsvtNo=" +mettingRoomRsvtVO.getRsvtNo();
//		}
//		// else 이면 update 문 실행 하는 서비스로 연결 
//		
//		
//		
//		return goPage;
//	}
	
	// 회의실 예약 수정
	@PostMapping(value = "/mettingUpdateRes")
	public String mettingUpdateRes(Model model, MettingRoomRsvtVO mettingRoomRsvtVO) {
		System.out.println("@@@@@@@@@@@@!!!!!!!!!!!!!!");
		mettingRoomRsvtVO.setRsvtBgngDt(mettingRoomRsvtVO.getRsvtBgngDt().replace("T", " "));
		mettingRoomRsvtVO.setRsvtEndDt(mettingRoomRsvtVO.getRsvtEndDt().replace("T", " "));

		int test = this.service.mettingUpdateRes(mettingRoomRsvtVO);
		System.out.println(mettingRoomRsvtVO.getRsvtNo() + " | " + mettingRoomRsvtVO.getRsvtBgngDt() + " | " + mettingRoomRsvtVO.getRsvtEndDt() +"@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		
//		model.addAttribute("mettingRoomRsvtVO2", mettingRoomRsvtVO2);
			
		///////////////////////// 예약 리스트를 다시 가져와서 예약 메인으로 이동하는 코드 시작
		List<MettingRoomVO> mettingRoomRes = service.mettingRoomRes();
		log.info("mettingRoomRes->mettingRoomRes : " + mettingRoomRes);
		
		//예약 목록
		List<MettingRoomRsvtVO> mettingRoomResList = service.mettingRoomResList();
		log.info("mettingRoomRes->mettingRoomResList : " + mettingRoomResList);
		
		model.addAttribute("mettingRoomRes",mettingRoomRes);
		model.addAttribute("mettingRoomResList",mettingRoomResList);
		///////////////////////// 예약 리스트를 다시 가져와서 예약 메인으로 이동하는 코드	끝	
		
		return "redirect:/egg/mettingRoomResDet?rsvtNo="+mettingRoomRsvtVO.getRsvtNo();
	}
	
//	// 회의실 예약 취소
//	@PostMapping(value = "/mettingDelete")
//	public String mettingDelete(MettingRoomRsvtVO mettingRoomRsvtVO, Principal principal) {
//		// 로그인한 사용자 ID 가져오기
//		String loggedInUserId = principal.getName(); // 또는 세션에서 사용자 정보 가져오기
//		
//		//예약 목록
//		List<MettingRoomRsvtVO> mettingRoomResList = service.mettingRoomResList();
//		log.info("mettingRoomRes->mettingRoomResList : " + mettingRoomResList);
//		
//		// 예약이 존재하지는 확인하고 사용자가 예약한 것인지 확인
//		
//		// 사용자가 예약한 회의실 삭제
//		
//		return "";
//	}
	
	
	// 회의실 예약 삭제 
	@ResponseBody
	@PostMapping("/deleteReservation")
	public int deleteReservation(@RequestBody String rsvtNo) {
		int status = service.deleteReservation(Integer.parseInt(rsvtNo));
		log.info("확인{}", rsvtNo);
		return status;
	}


	
	// 비품 목록
	@RequestMapping(value = "/fixuresRes", method = RequestMethod.GET)
	public String fixuresRes(FixuresRsvtVO fixuresRsvtVO, Model model, FixuresVO fixuresVO,  Principal principal) {
		log.info("fixuresRes");
		
		//Service 연결
		// 비품 목록
		List<FixuresVO> fixuresRes = service.fixuresRes();
		log.info("fixuresRes->fixuresRes:" + fixuresRes);
		
		// 비품 예약 목록
		List<FixuresRsvtVO> fixuresResList = service.fixuresResList();
		log.info("fixuresRes->fixuresResList:" + fixuresResList);

		model.addAttribute("fixuresRes", fixuresRes);
		model.addAttribute("fixuresResList", fixuresResList);
		
		return "egg/reservation/fixuresRes";
	}
	
	//비품 상세, 비품 예약 상세
		// /egg/fixuresResDet?fixRsvtNo=3
		@GetMapping("/fixuresResDet")
		public String fixuresResDet(Model model, 
				@RequestParam(value="fixRsvtNo",required=false,defaultValue="1") int fixRsvtNo) {
			log.info("fixuresResDet 실행 !!!!!!!!!!!!!!!");
			log.info("fixuresResDet->fixRsvtCd : " + fixRsvtNo);
			
			// Service 연결
			List<FixuresVO> fixuresRes = service.fixuresRes();
			log.info("fixuresRes->fixuresRes : " + fixuresRes);
			
			//비품 상세
			FixuresVO fixuresVO = this.service.fixuresResDet(fixRsvtNo);
			log.info("fixuresResDet->FixuresVO : " + fixuresVO);
			
			//비품 예약 상세
			List<FixuresRsvtVO> fixuresRsvtVOList = fixuresVO.getFixuresRsvtVOList();
			log.info("fixuresResDet->fixuresRsvtVOList : " + fixuresRsvtVOList);
			
			model.addAttribute("fixuresRes",fixuresRes);
			model.addAttribute("fixuresVO",fixuresVO);
			model.addAttribute("fixuresRsvtVOList",fixuresRsvtVOList);
			
			return "egg/reservation/fixuresResDet";
		}
	
		
		// 비품 예약 등록
		@ResponseBody
		@PostMapping("/fixuresInsertRes")
		public FixuresRsvtVO fixuresInsertRes(@RequestBody FixuresRsvtVO fixuresRsvtVO) throws ParseException {
			//{"fixNo": "1","emplId": "20240624"
			//	,"fixRsvtBgngDt": "2024-07-29T21:13","fixRsvtEndDt": "2024-07-29T21:19",
			//	"dateFixRsvtBgngDt":null,"dateFixRsvtEndDt":null}
			
			log.info("fixuresInsertRes->fixuresRsvtVO : " + fixuresRsvtVO);
			
			int result = service.fixuresInsertRes(fixuresRsvtVO);
			log.info("fixuresInsertRes->result : " + result);
			
			return fixuresRsvtVO;
		}	
		
		
		// 예약 가능 시간 확인 메소드[비품]
		// {"fixNo": "1","emplId": "20240624"
		//		,"fixRsvtBgngDt": "2024-07-27T09:53","fixRsvtEndDt": "2024-07-27T11:55"}
		@ResponseBody
		@PostMapping("/resFixTime")
		public int resFixTimeAjax(@RequestBody FixuresRsvtVO fixuresRsvtVO) throws ParseException {
			log.info("mettingConfirmAjax->fixuresRsvtVO : " + fixuresRsvtVO);
			
			//2024-07-27T09:53 -> 2024-07-27 09:53
			String beginDateStr = fixuresRsvtVO.getFixRsvtBgngDt().replace("T", " ");
			String endDateStr = fixuresRsvtVO.getFixRsvtEndDt().replace("T", " ");
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			Date beginDate = sdf.parse(beginDateStr);
			Date endDate = sdf.parse(endDateStr);
			
			fixuresRsvtVO.setDateFixRsvtBgngDt(beginDate); 
			fixuresRsvtVO.setDateFixRsvtEndDt(endDate);
			
			
			int confirm = service.fixSelectDet(fixuresRsvtVO);
			
			
			return confirm;
		}
		
		
		// 비품 예약 수정
		@PostMapping(value = "/fixuresUpdateRes")
		public String fixuresUpdateRes(Model model, FixuresRsvtVO fixuresRsvtVO) {
			System.out.println("@@@@@@@@@@@@!!!!!!!!!!!!!!");
			fixuresRsvtVO.setFixRsvtBgngDt(fixuresRsvtVO.getFixRsvtBgngDt().replace("T", " "));
			fixuresRsvtVO.setFixRsvtEndDt(fixuresRsvtVO.getFixRsvtEndDt().replace("T", " "));

			int test = this.service.fixuresUpdateRes(fixuresRsvtVO);
			System.out.println(fixuresRsvtVO.getFixRsvtNo() + " | " + fixuresRsvtVO.getFixRsvtBgngDt() + " | " + fixuresRsvtVO.getFixRsvtEndDt() +"@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
			
//			model.addAttribute("mettingRoomRsvtVO2", mettingRoomRsvtVO2);
				
			///////////////////////// 예약 리스트를 다시 가져와서 예약 메인으로 이동하는 코드 시작
			List<FixuresVO> fixuresRes = service.fixuresRes();
			log.info("fixuresRes->fixuresRes : " + fixuresRes);
			
			//예약 목록
			List<FixuresRsvtVO> fixuresResList = service.fixuresResList();
			log.info("fixuresRes->fixuresResList : " + fixuresResList);
			
			model.addAttribute("fixuresRes",fixuresRes);
			model.addAttribute("fixuresResList",fixuresResList);
			///////////////////////// 예약 리스트를 다시 가져와서 예약 메인으로 이동하는 코드	끝	
			
			return "redirect:/egg/fixuresResDet?fixRsvtNo="+fixuresRsvtVO.getFixRsvtNo();
		}
		
		
		// 비품 예약 삭제 
		@ResponseBody
		@PostMapping("/fixdeleteReservation")
		public int fixdeleteReservation(@RequestBody String fixRsvtNo) {
			int status = service.fixdeleteReservation(Integer.parseInt(fixRsvtNo));
			log.info("확인{}", fixRsvtNo);
			return status;
		}
		
	

}
