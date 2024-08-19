package kr.or.ddit.fingerprint;

import java.util.List;

import kr.or.ddit.vo.FingerprintVO;

public interface IFingerprintService {
	public List<FingerprintVO> getWorkList(boolean init);
	public int insertWorkBeginTime();
	public String resetModule();
}
