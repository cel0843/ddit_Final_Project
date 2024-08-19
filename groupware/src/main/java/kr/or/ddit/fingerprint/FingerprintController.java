package kr.or.ddit.fingerprint;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.ddit.vo.FingerprintVO;
import lombok.extern.slf4j.Slf4j;

@RequestMapping("/work")
@Controller
@Slf4j
public class FingerprintController {

	@Inject
	private IFingerprintService service;

	// 출근 메인 페이지
	@RequestMapping(value = "/fingerprint", method = RequestMethod.GET)
	public String workPage(Model model) throws Exception {
		log.info("workPage 실행...!");
		List<FingerprintVO> workList = service.getWorkList(true);
		model.addAttribute("workList", workList);
		return "/common/work_register_main";
	}
	
	// 재설정
	@RequestMapping(value = "/resetModule", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> resetModule(Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		String status = service.resetModule();
		map.put("status", status);
		model.addAttribute("status", map);
		return ResponseEntity.ok(map);
	}
	
	// 출근 등록
	@RequestMapping(value = "/insertWorkBeginTime", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> insertWorkBeginTime() {
		log.info("insertWorkBeginTime() 실행...!");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		// 지문인식 출근
		int resultCodeNo = service.insertWorkBeginTime();
		// 0 인식 실패, 1 출근, 2 이미 출근
		
		if (resultCodeNo == 0 ) {
			map.put("workInCheck", "error");
		} else if (resultCodeNo == 1 ) {
			map.put("workInCheck", "success");
		} else if (resultCodeNo == 2 ) {
			map.put("workInCheck", "already");
		} else {
			map.put("workInCheck", "notFound");
		}
		
		map.put("workList", service.getWorkList(false));
		
		return ResponseEntity.ok(map);
	}
	
	// 테스트 메서드
	@RequestMapping(value = "/testUrl", method = RequestMethod.GET)
	public ResponseEntity<List<FingerprintVO>> testUrl() {
		log.info("testUrl() 실행...!");
		return ResponseEntity.ok(service.getWorkList(false));
	}
	
	

}
