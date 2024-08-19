package kr.or.ddit.service.board;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.IBoardMapper;
import kr.or.ddit.util.UploadFileUtils;
import kr.or.ddit.vo.AttachFileVO;
import kr.or.ddit.vo.BoardPaginationInfoVO;
import kr.or.ddit.vo.CommentVO;
import kr.or.ddit.vo.CustomBoardVO;

@Service
public class BoardServiceImpl implements IBoardService {
	
	@Inject
	private IBoardMapper mapper;

	// 게시글 총 갯수 조회
	@Override
	public int selectBoardCount(BoardPaginationInfoVO<CustomBoardVO> pagingVO) {
		return mapper.selectBoardCount(pagingVO);
	}

	// 게시글 리스트 조회
	@Override
	public List<CustomBoardVO> selectBoardList(BoardPaginationInfoVO<CustomBoardVO> pagingVO) {
		return mapper.selectBoardList(pagingVO);
	}

	// letsgo
	// 게시글 등록
	@Override
	public int registerBorad(CustomBoardVO boardVO) throws Exception {
		
		if (boardVO.getBoardFileList() != null && boardVO.getBoardFileList().size() > 0) {
			int fileGroupNo = mapper.getFileGroupNo();
			boardVO.setFileGroupNo(fileGroupNo);
			List<AttachFileVO> fileList = UploadFileUtils.saveBoardFile(boardVO.getBoFileArr(), fileGroupNo);
			if (fileList != null && fileList.size() > 0) {
				for (AttachFileVO attachFileVO : fileList) {
					mapper.insertFileInfo(attachFileVO);
				}
			}
		}
		mapper.registerBoard(boardVO);
		int bbsNo = boardVO.getBbsNo();
		return bbsNo;
	}

	@Override
	public CustomBoardVO selectBoard(int bbsNo) {
		mapper.incrementHit(bbsNo);
		return mapper.selectBoard(bbsNo);
	}

	@Override
	public List<CommentVO> selectCommentList(int bbsNo) {
		return mapper.selectCommentList(bbsNo);
	}

	@Override
	public int updateBoard(CustomBoardVO boardVO) throws Exception {
		// 기존 파일 삭제
		if (boardVO.getDelFileNo() != null) {
			for (int fileNo : boardVO.getDelFileNo()) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("fileGroupNo", boardVO.getFileGroupNo());
				map.put("fileNo", fileNo);
				mapper.delBoardFile(map);
				System.out.println("### 게시글 수정 >> 파일 삭제 성공");
				
			}
		}
		
		// letsgo
		// 새로 등록한 파일 insert
//		if (boardVO.getBoardFileList() != null && boardVO.getBoardFileList().size() > 0) {
		if (boardVO.getBoFileArr() != null && boardVO.getBoFileArr().length > 0) {
			if (!"".equals(boardVO.getBoFileArr()[0].getOriginalFilename())) {
				if (boardVO.getFileGroupNo() == 0) {
					int fileGroupNo = mapper.getFileGroupNo();
					boardVO.setFileGroupNo(fileGroupNo);
					System.out.println("### 게시글 수정 >> 파일 번호 생성 성공");
				}
				List<AttachFileVO> fileList = UploadFileUtils.saveBoardFile(boardVO.getBoFileArr(), boardVO.getFileGroupNo());
				if (fileList != null && fileList.size() > 0) {
					for (AttachFileVO attachFileVO : fileList) {
							
						mapper.insertFileInfo(attachFileVO);
					}
				}
				System.out.println("### 게시글 수정 >> 파일 생성 성공");
			}
		}
		
		int status = mapper.updateBoard(boardVO);
		
		System.out.println("### 게시글 수정 >> 게시글 수정 성공");
		
		return status;
	}

	@Override
	public int deleteBoard(int bbsNo) {
		mapper.deleteBoardComment(bbsNo);
		return mapper.deleteBoard(bbsNo);
	}

	@Override
	public int insertComment(CommentVO commentVO) {
		int status = mapper.insertComment(commentVO);
		if (status > 0) {
			return commentVO.getCmntNo();
		}
		return 0;
	}

	@Override
	public CommentVO selectComment(int cmntNo) {
		return mapper.selectComment(cmntNo);
	}

	@Override
	public int deleteComment(int cmntNo) {
		return mapper.deleteComment(cmntNo);
	}

	@Override
	public int updateComment(CommentVO commentVO) {
		return mapper.updateComment(commentVO);
	}

	@Override
	public List<CustomBoardVO> mainSummaryBoardSelect() {
		return mapper.mainSummaryBoardSelect();
	}
	


}
