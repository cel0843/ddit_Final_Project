package kr.or.ddit.service.approval;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.mapper.IApprovalMapper;
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

@Service
public class ApprovalServiceImpl implements IApprovalService {
	
	@Inject
	private IApprovalMapper mapper;
	
	@Override
	public List<AprvFormVO> formList(AprvFormVO form) {
		return mapper.formList(form);
	}

	@Override
	public AprvFormVO formOne(String formCd) {
		
		return mapper.formOne(formCd);
	}

	@Override
	public int updateUse(AprvFormVO form) {
		return mapper.updateUse(form);
	}
	
	@Override
	public int updateDcrb(AprvFormVO form) {
		return mapper.updateDcrb(form);
	}

	@Override
	public int addForm(AprvFormVO addForm) {
		return mapper.addForm(addForm);
	}

	@Override
	public int updateForm(AprvFormVO updateForm) {
		return mapper.updateForm(updateForm);
	}

	@Override
	public int delForm(String formCd) {
		return mapper.delForm(formCd);
	}

	@Override
	public List<AprvDocumentVO> aprvDocList(AprvDocumentVO doc) {
		return mapper.aprvDocList(doc);
	}

	@Override
	public int insertProxy(AprvProxyVO proxy) {
		return mapper.insertProxy(proxy);
	}

	@Override
	public AprvProxyVO proxyOne(String emplId){
		return mapper.proxyOne(emplId);
	}

	@Override
	public List<EmployeeVO> emplList() {
		return mapper.emplList();
	}

	@Override
	public List<AprvFormVO> formList() {
		return mapper.formList();
	}

	@Override
	public int addAprvDoc(AprvDocumentVO aprvDoc) {
		return mapper.addAprvDoc(aprvDoc);
	}

	@Override
	public void insertRfrnc(Map<String, Object> param) {
		mapper.insertRfrnc(param);
	}

	@Override
	public void insertAprvLine(Map<String, Object> param) {
		mapper.insertAprvLine(param);
	}

	@Override
	public List<AprvDocumentVO> draftList(String emplId) {
		return mapper.draftList(emplId);
	}

	@Override
	public void endproxy() {
		mapper.endproxy();
	}

	@Override
	public AprvDocumentVO detailDoc(String aprvId) {
		return mapper.detailDoc(aprvId);
	}

	@Override
	public List<AprvLineVO> aprvLine(String aprvId) {
		return mapper.aprvLine(aprvId);
	}

	@Override
	public int insertProjectFormData(AprvProjectVO aprvProjectVo ) {
		return mapper.insertProjectFormData(aprvProjectVo);
	}

	@Override
	public AprvProjectVO detailProj(String aprvId) {
		return mapper.detailProj(aprvId);
	}

	@Override
	public int saveAprvLine(AprvLineVO param) {
		return mapper.saveAprvLine(param);
	}

	@Override
	public int updateAprvDocStts(AprvLineVO param) {
		
		return mapper.updateAprvDocStts(param);
	}

	@Override
	public int insertProjectData(AprvLineVO param) {
		return mapper.insertProjectData(param);
	}

	@Override
	public EmployeeVO getEmplInfo(String emplId) {
		return mapper.getEmplInfo(emplId);
	}

	@Override
	public int insertDeptMvnvFormData(AprvDeptVO aprvDepttVo) {
		return mapper.insertDeptMvnvFormData(aprvDepttVo);
	}

	@Override
	public AprvDeptVO detailDept(String aprvId) {
		return mapper.detailDept(aprvId);
	}

	@Override
	public int updateDeptMvnv(AprvLineVO param) {
		return mapper.updateDeptMvnv(param);
	}

	@Override
	public List<DepartmentVO> deptList() {
		return mapper.deptList();
	}

	@Override
	public int insertHdAplyFormData(AprvVacVO aprvVacVo) {
		return mapper.insertHdAplyFormData(aprvVacVo);
	}


	@Override
	public AprvVacVO detailVac(String aprvId) {
		return mapper.detailVac(aprvId);
	}

	@Override
	public AprvVacVO selectCountDay(int aprvId) {
		return mapper.selectCountDay(aprvId);
	}

	@Override
	public EmployeeHolidayVO selectEmployeeHoliday(String emplId) {
		return mapper.selectEmployeeHoliday(emplId);
	}

	@Override
	public int insertHdHistory(HdHistoryVO hdHistory) {
		return mapper.insertHdHistory(hdHistory);
	}

	@Override
	public int updateEmployeeHoliday(HdHistoryVO hdHistory) {
		return mapper.updateEmployeeHoliday(hdHistory);
	}

	@Override
	public List<AprvDocumentVO> aprvProxyList(String agtId) {
		return mapper.aprvProxyList(agtId);
	}

	@Override
	public List<AprvLineVO> agtAprvLine(String aprvId) {
		return mapper.agtAprvLine(aprvId);
	}

	@Override
	public AprvProxyVO selectAgtName(String emplId) {
		return mapper.selectAgtName(emplId);
	}

	@Override
	public int aprvDocListCount(String emplId) {
		return mapper.aprvDocListCount(emplId);
	}

	@Override
	public int insertProjFormPrtcp(Map<String, Object> param) {
		return mapper.insertProjFormPrtcp(param);
	}

	@Override
	public int insertProjectPrtcp(AprvLineVO lineVO) {
		return mapper.insertProjectPrtcp(lineVO);
	}

	@Override
	public List<AttachFileVO> getFile(int fileGroupNo) {
		return mapper.getFile(fileGroupNo);
	}

	@Override
	public List<AprvSearchVO> selectSearchList(AprvSearchVO aprvSearchVO) {
		List<AprvSearchVO> resultList = new ArrayList<AprvSearchVO>();
		if(aprvSearchVO.getSearchFlag() != null && aprvSearchVO.getSearchFlag().equals("search")) {
			String[] atrzCmpt = aprvSearchVO.getAtrzCmptnDts();
			String[] atrzDmnd = aprvSearchVO.getAtrzDmndDts();
			if(atrzCmpt != null && StringUtils.isNotBlank(atrzCmpt[0])) {
				aprvSearchVO.setAtrzCmptnDt1(atrzCmpt[0]);
				aprvSearchVO.setAtrzCmptnDt2(atrzCmpt[1]);
			}
			if(atrzDmnd != null && StringUtils.isNotBlank(atrzDmnd[0])) {
				aprvSearchVO.setAtrzDmndDt1(atrzDmnd[0]);
				aprvSearchVO.setAtrzDmndDt2(atrzDmnd[1]);
			}
		}else {
			aprvSearchVO.setSearchFlag("empty");
		}
		List<AprvSearchVO> aprvSearchList = mapper.selectSearchList(aprvSearchVO);
		if(aprvSearchList != null && aprvSearchList.size() > 0) {
			int aprvId = aprvSearchList.get(0).getAprvId();
			for(int i = 0; i < aprvSearchList.size(); i++){
				AprvSearchVO aprvVO = aprvSearchList.get(i);
				if(i > 0) {
					if(aprvId == aprvVO.getAprvId()) {
						continue;
					}
				}
				resultList.add(aprvVO);
				aprvId = aprvVO.getAprvId();
			}
		}
		return resultList; 
	}

	@Override
	public List<AprvLineTempVO> getlineTemplate(String emplId) {
		return mapper.getlineTemplate(emplId);
	}

	@Override
	public int insertLineTemp(AprvLineTempVO altVO) {
		return mapper.insertLineTemp(altVO);
	}

	@Override
	public int getNewGroupNo() {
		return mapper.getNewGroupNo() + 1;
	}

	@Override
	public List<AprvDocumentVO> rfrncList(String emplId) {
		return mapper.rfrncList(emplId);
	}

	@Override
	public int deleteLineTemplates(Integer group) {
		return mapper.deleteLineTemplates(group);
	}



}
