package kr.or.ddit.mapper;

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

public interface IApprovalMapper {

	public List<AprvFormVO> formList(AprvFormVO form);
	public AprvFormVO formOne(String formCd);
	public int updateUse(AprvFormVO form);
	public int addForm(AprvFormVO addForm);
	public int updateForm(AprvFormVO updateForm);
	public int delForm(String formCd);
	public int updateDcrb(AprvFormVO form);
	public List<AprvDocumentVO> aprvDocList(AprvDocumentVO doc);
	public int insertProxy(AprvProxyVO proxy);
	public AprvProxyVO proxyOne(String emplId);
	public List<EmployeeVO> emplList();
	public List<AprvFormVO> formList();
	public int addAprvDoc(AprvDocumentVO aprvDoc);
	public void insertRfrnc(Map<String, Object> param);
	public void insertAprvLine(Map<String, Object> param);
	public List<AprvDocumentVO> draftList(String emplId);
	public void endproxy();
	public AprvDocumentVO detailDoc(String aprvId);
	public List<AprvLineVO> aprvLine(String aprvId);
	public int insertProjectFormData(AprvProjectVO aprvProjectVo);
	public int insertProjFormPrtcp(Map<String, Object> param);
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
	public List<AprvLineVO> agtAprvLine(String aprvId); // 대리결재자라인 조회
	public AprvProxyVO selectAgtName(String emplId);
	public int aprvDocListCount(String emplId);
	public int insertProjectPrtcp(AprvLineVO lineVO);
	public List<AttachFileVO> getFile(int fileGroupNo);
	public List<AprvSearchVO> selectSearchList(AprvSearchVO aprvSearchVO);
	public List<AprvLineTempVO> getlineTemplate(String emplId);
	public int insertLineTemp(AprvLineTempVO altVO);
	public int getNewGroupNo();
	public List<AprvDocumentVO> rfrncList(String emplId);
	public int deleteLineTemplates(Integer group);


}
