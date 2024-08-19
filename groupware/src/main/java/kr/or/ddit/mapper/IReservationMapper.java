package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.vo.FixuresRsvtVO;
import kr.or.ddit.vo.FixuresVO;
import kr.or.ddit.vo.MettingRoomRsvtVO;
import kr.or.ddit.vo.MettingRoomVO;

public interface IReservationMapper {

	//회의실 목록
	public List<MettingRoomVO> mettingRoomRes();
	
	//회의실 상세
	//int roomNo = 3;
	//<select id="mettingRoomResDet" parameterType="int" resultMap="mettingRoomMap">
	public MettingRoomVO mettingRoomResDet(int rsvtNo);

	
	public int insertmettingRes(MettingRoomRsvtVO mettingRoomRsvtVO);

	public int mettingUpdateRes(MettingRoomRsvtVO mettingRoomRsvtVO);

	public int mettingSelectDet(MettingRoomRsvtVO mettingRoomRsvtVO);

	public int mettinginsertRes(MettingRoomRsvtVO mettingRoomRsvtVO);

	// 회의실 예약 목록
	public List<MettingRoomRsvtVO> mettingRoomResList();

	// 회의실 예약 취소
	public int deleteReservation(int rsvtNo);
	
	// 비품 목록
	public List<FixuresVO> fixuresRes();

	// 비품 예약 목록
	public List<FixuresRsvtVO> fixuresResList();

	// 비품 상세
	public FixuresVO fixuresResDet(int fixRsvtNo);

	// 비품 등록
	public int fixuresInsertRes(FixuresRsvtVO fixuresRsvtVO);

	// 비품 내역 조회
	public int fixSelectDet(FixuresRsvtVO fixuresRsvtVO);

	// 비품 예약 수정
	public int fixuresUpdateRes(FixuresRsvtVO fixuresRsvtVO);

	// 비품 예약 취소
	public int fixdeleteReservation(int fixRsvtNo);


}
