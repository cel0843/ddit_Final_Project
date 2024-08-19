package kr.or.ddit.controller.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.service.board.IBoardService;
import kr.or.ddit.vo.BoardPaginationInfoVO;
import kr.or.ddit.vo.CommentVO;
import kr.or.ddit.vo.CustomBoardVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/egg")
public class UserBoardController {

	@Inject
	private IBoardService service;
	
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@RequestMapping(value = "/board", method = RequestMethod.GET)
	public String boardList(
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(name="bbsTyCd", required = false, defaultValue = "M010101") String bbsTyCd,
			@RequestParam(name="searchType", required = false, defaultValue = "title") String searchType,
			@RequestParam(name="searchWord", required = false) String searchWord,
			Model model
			) {
		
		BoardPaginationInfoVO<CustomBoardVO> pagingVO = new BoardPaginationInfoVO<CustomBoardVO>();
		
		if (StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			
			// 검색 후, 목록 페이지로 이동 할 때 검색된 내용을 적용시키기 위한 데이터 전달
			model.addAttribute("searchWord", searchWord);
			model.addAttribute("searchType", searchType);
		}
		
		// 게시판 타입 저장
		pagingVO.setBbsTyCd(bbsTyCd);
		
		// 총 4가지의 필드를 설정하기 위함
		// 현재 페이지를 전달 후, start/endRow, start/endPage 설정
		pagingVO.setCurrentPage(currentPage);
		
		// 총 게시글 수를 얻어온다.
		int totalRecord = service.selectBoardCount(pagingVO);
		
		// 총 게시글 수를 전달 후, 총 페이지 수를 설정
		pagingVO.setTotalRecord(totalRecord);
		
		// 총 게시글수가 포함된 BoardPaginationInfoVO객체를 넘겨주고 1페이지에 해당하는 10개(screenSize)의 게시글을 얻어온다. (dataList)
		// 총 게시글 수를 얻어온다 (dataList)
		List<CustomBoardVO> dataList = service.selectBoardList(pagingVO);
		pagingVO.setDataList(dataList);
		
		model.addAttribute("pagingVO", pagingVO);
		model.addAttribute("bbsTyCd", bbsTyCd);
		return "egg/board/userBoard";
	}
	
	// 상세보기 이동
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@RequestMapping(value = "/boardDetail", method = RequestMethod.GET)
	public String boardDetail(
		@RequestParam(name="bbsTyCd") String bbsTyCd
		, @RequestParam(name="bbsNo") int bbsNo
		, Model model) {
		log.info("boardDetail() 메서드 실행...!");
		log.info("##### bbsNo : " + bbsNo);
		
		CustomBoardVO boardVO = service.selectBoard(bbsNo);
		List<CommentVO> commentList = service.selectCommentList(bbsNo);
		log.info("##### 조회된 boardVO : " + boardVO);
		model.addAttribute("boardVO", boardVO);
		model.addAttribute("commentList", commentList);
		model.addAttribute("bbsNo", bbsNo);
		model.addAttribute("bbsTyCd", bbsTyCd);
		return "egg/board/userBoardDetail";
	}
	
	// 등록폼 이동
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@RequestMapping(value = "/boardRegisterForm", method = RequestMethod.GET)
	public String boardRegisterForm(@RequestParam(name="bbsTyCd") String bbsTyCd, Model model) {
		model.addAttribute("bbsTyCd", bbsTyCd);
		return "egg/board/userBoardRegisterForm";
	}
	
	// 게시글 등록
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@RequestMapping(value = "/registerBoard", method = RequestMethod.POST)
	public String registerBoard(HttpServletRequest req, RedirectAttributes ra, CustomBoardVO boardVO, Model model) throws Exception {
		log.info("registerBoard() 실행...!");
		String goPage = ""; // 이동할 페이지 정보
		
		Map<String, String> errors = new HashMap<String, String>();
		if (StringUtils.isBlank(boardVO.getBbsTtl())) {
			errors.put("bbsTtl", "제목을 입력해주세요!");
		}
		
		if (StringUtils.isBlank(boardVO.getBbsTtl())) {
			errors.put("bbsCn", "내용을 입력해주세요!");
		}
		
		if (errors.size() > 0) {
			model.addAttribute("errors", errors);
			model.addAttribute("boardVO", boardVO);
			goPage = "egg/userBoardRegisterForm";
		} else {
			int bbsNo = service.registerBorad(boardVO);
			if (bbsNo != 0) {
				goPage = "redirect:/egg/boardDetail?bbsTyCd="+boardVO.getBbsTyCd()+"&bbsNo=" + bbsNo;
			} else {
				model.addAttribute("boardVO", boardVO);
				model.addAttribute("message", "서버에서 다시 시도해주세요!");
				goPage = "egg/userBoardRegisterForm";
			}
		}
		
		return goPage;
	}
	
	// 수정폼 이동
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@RequestMapping(value = "/boardUpdateForm", method = RequestMethod.GET)
	public String boardUpdateForm(
			@RequestParam(name="bbsTyCd") String bbsTyCd
			, @RequestParam(name="bbsNo") int bbsNo
			, Model model) { // 게시글 번호 가져와야함
		CustomBoardVO boardVO = service.selectBoard(bbsNo);
		model.addAttribute("boardVO", boardVO);
		model.addAttribute("bbsNo", bbsNo);
		model.addAttribute("bbsTyCd", bbsTyCd);
		model.addAttribute("status", "u");
		return "egg/board/userBoardRegisterForm";
	}
	
	// 게시글 수정
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@RequestMapping(value = "/updateBoard", method = RequestMethod.POST)
	public String updateBoard(HttpServletRequest req, RedirectAttributes ra, CustomBoardVO boardVO, Model model) throws Exception { // 게시글 번호 가져와야함
		log.info("updateBoard() 실행...!");
		log.info("##### updateBoard() 요청 boardVO : " + boardVO);
		
		String goPage = "";
		int status = service.updateBoard(boardVO);
		if (status == 0) {
			log.info("### 게시글 수정 컨트롤러 >> 수정 실패");
			model.addAttribute("boardVO", boardVO);
			model.addAttribute("bbsNo", boardVO.getBbsNo());
			model.addAttribute("bbsTyCd", boardVO.getBbsTyCd());
			model.addAttribute("status", "u");
			goPage = "egg/board/userBoardRegisterForm";
		} else {
			ra.addFlashAttribute("message", "게시글이 수정되었습니다!");
			goPage = "redirect:/egg/boardDetail?bbsTyCd="+boardVO.getBbsTyCd()+"&bbsNo=" + boardVO.getBbsNo();
		}
		
		return goPage;
	}
	
	// 게시글 삭제
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@RequestMapping(value = "/deleteBoard", method = RequestMethod.POST)
	public String deleteBoard(
			@RequestParam(name="bbsTyCd", required = false, defaultValue = "M010101") String bbsTyCd
			, @RequestParam(name="bbsNo") int bbsNo
			, Model model) {
		log.info("deleteBoard() 실행...!");
		
		String goPage = "";
		
		int status = service.deleteBoard(bbsNo);
		if (status > 0) { // 삭제 성공
			goPage = "redirect:/egg/board?bbsTyCd=" + bbsTyCd;
		}else { // 삭제 실패
			goPage = "redirect:/egg/boardDetail?bbsTyCd="+bbsTyCd+"&bbsNo=" + bbsNo;
		}
		return goPage;
	}
	
	
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@RequestMapping(value = "/deleteComment", method = RequestMethod.POST)
	public ResponseEntity<Boolean> deleteComment(@RequestParam("cmntNo") int cmntNo) {
		log.info("deleteComment() 실행...!");
		// 서비스
		int status = service.deleteComment(cmntNo);
		return status == 0 ? ResponseEntity.ok(false) : ResponseEntity.ok(true);
	}
	
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@RequestMapping(value = "/insertComment", method = RequestMethod.POST)
	public ResponseEntity<CommentVO> insertComment(@RequestBody CommentVO commentVO) {
		log.info("insertComment() 실행...!");
		int resultCommentNo = service.insertComment(commentVO);
		if (resultCommentNo != 0) {
			CommentVO savedCommentVO = service.selectComment(resultCommentNo);
			return ResponseEntity.ok(savedCommentVO);
		} else {
			return ResponseEntity.ok(null);
		}
	}
	
	@PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
	@RequestMapping(value = "/updateComment", method = RequestMethod.POST)
	public ResponseEntity<CommentVO> updateComment(@RequestBody CommentVO commentVO) {
		log.info("updateComment() 실행...!");
		int status = service.updateComment(commentVO);
		if (status != 0) {
			CommentVO savedCommentVO = service.selectComment(commentVO.getCmntNo());
			return ResponseEntity.ok(savedCommentVO);
		} else {
			return ResponseEntity.ok(null);
		}
	}
	
	
}
