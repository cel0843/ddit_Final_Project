package kr.or.ddit.service.board;

import java.util.List;

import kr.or.ddit.vo.BoardPaginationInfoVO;
import kr.or.ddit.vo.CommentVO;
import kr.or.ddit.vo.CustomBoardVO;

public interface IBoardService {
	public int selectBoardCount(BoardPaginationInfoVO<CustomBoardVO> pagingVO);
	public List<CustomBoardVO> selectBoardList(BoardPaginationInfoVO<CustomBoardVO> pagingVO);
	public int registerBorad(CustomBoardVO boardVO) throws Exception;
	public CustomBoardVO selectBoard(int bbsNo);
	public List<CommentVO> selectCommentList(int bbsNo);
	public int updateBoard(CustomBoardVO boardVO) throws Exception;
	public int deleteBoard(int bbsNo);
	public int insertComment(CommentVO commentVO);
	public CommentVO selectComment(int cmntNo);
	public int deleteComment(int cmntNo);
	public int updateComment(CommentVO commentVO);
	public List<CustomBoardVO> mainSummaryBoardSelect();

}
