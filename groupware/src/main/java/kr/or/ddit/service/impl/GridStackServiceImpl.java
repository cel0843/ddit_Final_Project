package kr.or.ddit.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.IGridStackMapper;
import kr.or.ddit.service.IGridStackService;
import kr.or.ddit.vo.GridStackVO;

@Service
public class GridStackServiceImpl implements IGridStackService{

	@Inject
	IGridStackMapper mapper;

	@Override
	public void updateGridStack(GridStackVO gsVO) {
		mapper.updateGridStack(gsVO);
	}

	@Override
	public List<GridStackVO> selectGridStack(String emplId) {
		return mapper.selectGridStack(emplId);
	}
	
}
