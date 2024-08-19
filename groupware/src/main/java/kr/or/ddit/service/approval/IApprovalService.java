package kr.or.ddit.service.approval;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.AprvDeptVO;
import kr.or.ddit.vo.AprvDocumentVO;
import kr.or.ddit.vo.AprvFormVO;
import kr.or.ddit.vo.AprvLineTempVO;
import kr.or.ddit.vo.AprvLineVO;
import kr.or.ddit.vo.AprvProjectVO;
import kr.or.ddit.vo.AprvProxyVO;
import kr.or.ddit.vo.AprvSearchVO;
import kr.or.ddit.vo.AprvVacVO;
import kr.or.ddit.vo.AttachFileVO;
import kr.or.ddit.vo.DepartmentVO;
import kr.or.ddit.vo.EmployeeHolidayVO;
import kr.or.ddit.vo.EmployeeVO;
import kr.or.ddit.vo.HdHistoryVO;

public interface IApprovalService {

	public List<AprvFormVO> formList(AprvFormVO form);				//양식목록 조회
	public List<AprvFormVO> formList();								//양식 목록조회
	public AprvFormVO formOne(String formCd);						//양식 코드로 양식 조회
	public int updateUse(AprvFormVO form);							//양식 사용여부 업데이트
	public int updateDcrb(AprvFormVO form);							//양식 전결여부 
	public int addForm(AprvFormVO addForm);							//양식 등록
	public int updateForm(AprvFormVO updateForm);					//양식 수정
	public int delForm(String formCd);								//양식 삭제
	public List<AprvDocumentVO> aprvDocList(AprvDocumentVO doc);	//결재할 문서 목록 조회	
	public int insertProxy(AprvProxyVO proxy);						//대결자 지정
	public AprvProxyVO proxyOne(String emplId);						//대결자 조회
	public List<EmployeeVO> emplList();								//사원조회
	public int addAprvDoc(AprvDocumentVO aprvDoc);					//새 기안 등록(결재문서등록)
	public void insertRfrnc(Map<String, Object> param);				//참조자 등록
	public void insertAprvLine(Map<String, Object> param);			//결재라인 등록
	public List<AprvDocumentVO> draftList(String emplId);			//내가 올린 기안(결재문서) 목록 조회
	public void endproxy();											//대결자 기간 종료시 사용여부 'n'업데이트 scheduled	
	public AprvDocumentVO detailDoc(String aprvId);					//결재할 문서 상세조회	
	public List<AprvLineVO> aprvLine(String aprvId);						//결재라인 조회
	public int insertProjectFormData(AprvProjectVO aprvProjectVo);
	public int insertProjFormPrtcp(Map<String, Object> param);	// 프로젝트 참가자 등록
	public AprvProjectVO detailProj(String aprvId);
	public int saveAprvLine(AprvLineVO param);
	public int updateAprvDocStts(AprvLineVO param);
	public int insertProjectData(AprvLineVO param);
	public EmployeeVO getEmplInfo(String emplId);
	public int insertDeptMvnvFormData(AprvDeptVO aprvDepttVo);
	public AprvDeptVO detailDept(String aprvId);
	public int updateDeptMvnv(AprvLineVO param);
	public List<DepartmentVO> deptList();
	public int insertHdAplyFormData(AprvVacVO aprvVacVo);
	public AprvVacVO detailVac(String aprvId);
	public AprvVacVO selectCountDay(int aprvId);
	public int insertHdHistory(HdHistoryVO hdHistory);
	public int updateEmployeeHoliday(HdHistoryVO hdHistory);
	public EmployeeHolidayVO selectEmployeeHoliday(String emplId);
	public List<AprvDocumentVO> aprvProxyList(String agtId);
	public List<AprvLineVO> agtAprvLine(String aprvId);	//대리결재 상세보기
	public AprvProxyVO selectAgtName(String emplId);//대리결재자 이름 조회
	public int aprvDocListCount(String emplId);	// 메인화면에 결재 대기문서 갯수
	public int insertProjectPrtcp(AprvLineVO lineVO);
	public List<AttachFileVO> getFile(int fileGroupNo);
	public List<AprvSearchVO> selectSearchList(AprvSearchVO aprvSearch);
	public List<AprvLineTempVO> getlineTemplate(String emplId);
	public int insertLineTemp(AprvLineTempVO altVO);
	public int getNewGroupNo();
	public List<AprvDocumentVO> rfrncList(String emplId);
	public int deleteLineTemplates(Integer group);



}
