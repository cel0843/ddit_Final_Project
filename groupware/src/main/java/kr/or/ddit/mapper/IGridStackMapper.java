package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.vo.GridStackVO;

public interface IGridStackMapper {

	public void updateGridStack(GridStackVO gsVO);

	public List<GridStackVO> selectGridStack(String emplId);

}
