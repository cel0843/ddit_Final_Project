package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.vo.FingerprintVO;

public interface IFingerprintMapper {

	public List<FingerprintVO> getWorkList();
	public String selectEmplIdbyFid(String fid);
	public int insertWorkBeginTime(String emplId);
	
}
