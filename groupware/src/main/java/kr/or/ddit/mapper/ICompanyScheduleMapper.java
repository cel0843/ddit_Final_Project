package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.vo.CompanyScheduleVO;

public interface ICompanyScheduleMapper {

    public List<CompanyScheduleVO> selectCSList();
    
    public void insertSchedul(CompanyScheduleVO schedul);
    
    public void updateSchedul(CompanyScheduleVO schedul);
    
    public void updateDateSchedul(CompanyScheduleVO schedul);
    
    public void deleteSchedul(int schdlNo);

	public List<CompanyScheduleVO> summaryInfo(String month);
}