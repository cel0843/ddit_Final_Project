package kr.or.ddit.service.Reservation;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.IReservationMapper;
import kr.or.ddit.vo.FixuresRsvtVO;
import kr.or.ddit.vo.FixuresVO;
import kr.or.ddit.vo.MettingRoomRsvtVO;
import kr.or.ddit.vo.MettingRoomVO;

@Service
public class ReservationServiceImpl implements IReservationService {

	@Inject
	IReservationMapper mapper;


	//회의실 목록
	@Override
	public List<MettingRoomVO> mettingRoomRes() {
		return mapper.mettingRoomRes();
	}

	//회의실 상세
	//int roomNo = 3;
	@Override
	public MettingRoomVO mettingRoomResDet(int rsvtNo) {
		return mapper.mettingRoomResDet(rsvtNo);
	}



	@Override
	public int insertmettingRes(MettingRoomRsvtVO mettingRoomRsvtVO) {
		return mapper.insertmettingRes(mettingRoomRsvtVO);
	}

	@Override
	public int mettingUpdateRes(MettingRoomRsvtVO mettingRoomRsvtVO) {
		int cnt = mapper.mettingUpdateRes(mettingRoomRsvtVO);
		return cnt;
	}

	// 회의실 내역 조회
	@Override
	public int mettingSelectDet(MettingRoomRsvtVO mettingRoomRsvtVO) {
		return mapper.mettingSelectDet(mettingRoomRsvtVO);
	}

	@Override
	public int mettinginsertRes(MettingRoomRsvtVO mettingRoomRsvtVO) {
		return mapper.mettinginsertRes(mettingRoomRsvtVO);
	}

	//예약 목록
	@Override
	public List<MettingRoomRsvtVO> mettingRoomResList() {
		return mapper.mettingRoomResList();
	}

//	// 회의실 예약 취소
//	@Override
//	public boolean mettingCancel(Long reservationId) {
//		return false;
//	}

	// 회의실 예약 취소
	@Override
	public int deleteReservation(int rsvtNo) {
		// TODO Auto-generated method stub
		return mapper.deleteReservation(rsvtNo);
	}

	// 비품 목록
	@Override
	public List<FixuresVO> fixuresRes() {
		return mapper.fixuresRes();
	}
	
	// 비품 예약 목록
	@Override
	public List<FixuresRsvtVO> fixuresResList() {
		return mapper.fixuresResList();
	}

	// 비품 상세
	@Override
	public FixuresVO fixuresResDet(int fixRsvtNo) {
		return mapper.fixuresResDet(fixRsvtNo);
	}

	@Override
	public int fixuresInsertRes(FixuresRsvtVO fixuresRsvtVO) {
		return mapper.fixuresInsertRes(fixuresRsvtVO);
	}

	//비품 내역 조회
	@Override
	public int fixSelectDet(FixuresRsvtVO fixuresRsvtVO) {
		return mapper.fixSelectDet(fixuresRsvtVO);
	}

	// 비품 예약 수정
	@Override
	public int fixuresUpdateRes(FixuresRsvtVO fixuresRsvtVO) {
		return mapper.fixuresUpdateRes(fixuresRsvtVO);
	}

	@Override
	public int fixdeleteReservation(int fixRsvtNo) {
		return mapper.fixdeleteReservation(fixRsvtNo);
	}



}
