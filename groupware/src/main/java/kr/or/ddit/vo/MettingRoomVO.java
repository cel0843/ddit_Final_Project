package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

@Data

public class MettingRoomVO {
	private int roomNo;			// 회의실번호
	private String roomNm;		// 회의실이름
	private String roomPstn;	// 회의실위치
    private String roomEqpmnt;	// 장비
    private String roomNope; 	// 수용인원
    private int rnum;
    
    //METTING_ROOM : METTING_ROOM_RSVT = 1 : N
    private List<MettingRoomRsvtVO> mettingRoomRsvtVOList;
}
