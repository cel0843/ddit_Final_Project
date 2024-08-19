package kr.or.ddit.service;

import java.util.List;

import kr.or.ddit.vo.GridStackVO;

public interface IGridStackService {

	public void updateGridStack(GridStackVO gsVO);

	public List<GridStackVO> selectGridStack(String emplId);

}
