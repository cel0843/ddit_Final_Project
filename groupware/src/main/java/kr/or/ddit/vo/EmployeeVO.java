package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

@Data
public class EmployeeVO {
	private String emplId;					// 사원아이디
	private String deptCd;					// 부서코드
	private String deptNm;
	private String emplNm;					// 사원명
	private String emplPswd;				// 비밀번호
	private String rrno;					// 주민등록번호
	private String email;					// 이메일
	private String telno;					// 전화번호
	private String zip;						// 우편번호
	private String bscAddr;					// 기본주소
	private String dtlAddr;					// 상세주소
	private String jncmpYmd;				// 입사일자
	private String rsgntnYmd;				// 퇴사일자
	private String emsSttsCd;				// 사원상태콬드
	private String positionCd;				// 직급코드
	private String positionCdNm;				// 직급코드명
	private String jbttlNm;					// 직책명
	private String proflImageCours;			// 프로필이미지 경로
	private String esgn;					// 전자서명
	private List<EmployeeAuthVO> authList;	// 권한리스트
	
	
	
}
