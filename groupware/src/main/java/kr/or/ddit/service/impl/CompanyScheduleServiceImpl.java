package kr.or.ddit.service.impl;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.ICompanyScheduleMapper;
import kr.or.ddit.service.ICompanyScheduleService;
import kr.or.ddit.vo.CompanyScheduleVO;

@Service
public class CompanyScheduleServiceImpl implements ICompanyScheduleService {

    @Autowired
    private ICompanyScheduleMapper mapper;

    @Override
    public List<CompanyScheduleVO> selectCSList() {
        return mapper.selectCSList();
    }

    @Override
    public void insertSchedul(CompanyScheduleVO schedul) {
        mapper.insertSchedul(schedul);
    }

    @Override
    public void updateSchedul(CompanyScheduleVO schedul) {
        mapper.updateSchedul(schedul);
    }

    @Override
    public void updateDateSchedul(CompanyScheduleVO schedul) {
        mapper.updateDateSchedul(schedul);
    }

    @Override
    public void deleteSchedul(int schdlNo) {
        mapper.deleteSchedul(schdlNo);
    }

	@Override
	public List<CompanyScheduleVO> summaryInfo(String currentMonth) {
		return mapper.summaryInfo(currentMonth);
	}
}