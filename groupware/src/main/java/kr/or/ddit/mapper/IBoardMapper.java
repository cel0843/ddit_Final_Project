package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.AttachFileVO;
import kr.or.ddit.vo.BoardPaginationInfoVO;
import kr.or.ddit.vo.CommentVO;
import kr.or.ddit.vo.CustomBoardVO;

public interface IBoardMapper {

	public int selectBoardCount(BoardPaginationInfoVO<CustomBoardVO> pagingVO);
	public List<CustomBoardVO> selectBoardList(BoardPaginationInfoVO<CustomBoardVO> pagingVO);
	public int getFileGroupNo();
	public int registerBoard(CustomBoardVO boardVO, List<AttachFileVO> fileList);
	public int insertFileInfo(AttachFileVO attachFileVO);
	public int registerBoard(CustomBoardVO boardVO);
	public CustomBoardVO selectBoard(int bbsNo);
	public int incrementHit(int bbsNo);
	public List<CommentVO> selectCommentList(int bbsNo);
	public int delBoardFile(Map<String, Object> map);
	public int deleteBoard(int bbsNo);
	public int deleteBoardComment(int cmntNo);
	public int updateBoard(CustomBoardVO boardVO);
	public int insertComment(CommentVO commentVO);
	public CommentVO selectComment(int cmntNo);
	public int deleteComment(int cmntNo);
	public int updateComment(CommentVO commentVO);
	public List<CustomBoardVO> mainSummaryBoardSelect();
}
