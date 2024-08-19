package kr.or.ddit.service;

import java.util.List;

import kr.or.ddit.vo.CompanyScheduleVO;

public interface ICompanyScheduleService {

    public List<CompanyScheduleVO> selectCSList();
    
    public void insertSchedul(CompanyScheduleVO schedul);
    
    public void updateSchedul(CompanyScheduleVO schedul);
    
    public void updateDateSchedul(CompanyScheduleVO schedul);
    
    public void deleteSchedul(int schdlNo);

	public List<CompanyScheduleVO> summaryInfo(String currentMonth);
}
