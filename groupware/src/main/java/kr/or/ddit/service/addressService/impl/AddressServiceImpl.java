package kr.or.ddit.service.addressService.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.IAdresMapper;
import kr.or.ddit.service.addressService.IAddressService;
import kr.or.ddit.vo.AddressBookVO;
import kr.or.ddit.vo.EmployeeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class AddressServiceImpl implements IAddressService {
    
    @Inject
    private IAdresMapper mapper;
    
    // 사내인원 주소록 리스트
    @Override
    public List<EmployeeVO> emplList() {
        return mapper.emplList();
    }
    
    // 외부인원 주소록 리스트
    @Override
    public List<AddressBookVO> colist() {
        return mapper.colist();
    }
    
    // 사내인원 주소록 상세보기
    @Override
    public EmployeeVO adresRead(String emplId) {
        return mapper.read(emplId);
    }
    
    // 외부인원 주소록 상세보기
    @Override
    public AddressBookVO coRead(int adresNo) {
        return mapper.coRead(adresNo);
    }
    
    // 외부인원 주소록 등록
    @Override
    public void register(AddressBookVO adresBookVO) {
        mapper.creat(adresBookVO);
    }
    
    // 외부인원 주소록 삭제
    @Override
    public void codelete(int adresNo) {
        mapper.delete(adresNo);
    }

    // 외부인원 주소록 수정
    @Override
    public void update(AddressBookVO adresBookVO) {
        mapper.update(adresBookVO);
    }

    // 전체 주소록 페이징
    @Override
    public List<AddressBookVO> selectAllPaged(int startRow, int endRow) {
        Map<String, Integer> params = new HashMap<>();
        params.put("startRow", startRow);
        params.put("endRow", endRow);
        return mapper.selectAllPaged(params);
    }

    // 이름으로 검색된 주소록 페이징
    @Override
    public List<AddressBookVO> searchByNamePaged(String adresNm, int startRow, int endRow) {
        Map<String, Object> params = new HashMap<>();
        params.put("adresNm", adresNm);
        params.put("startRow", startRow);
        params.put("endRow", endRow);
        return mapper.searchByNamePaged(params);
    }

    // 부서로 검색된 주소록 페이징
    @Override
    public List<AddressBookVO> searchByDepartmentPaged(String adresCoNm, int startRow, int endRow) {
        Map<String, Object> params = new HashMap<>();
        params.put("adresCoNm", adresCoNm);
        params.put("startRow", startRow);
        params.put("endRow", endRow);
        return mapper.searchByDepartmentPaged(params);
    }

    // 이메일로 검색된 주소록 페이징
    @Override
    public List<AddressBookVO> searchByEmailPaged(String adresEml, int startRow, int endRow) {
        Map<String, Object> params = new HashMap<>();
        params.put("adresEml", adresEml);
        params.put("startRow", startRow);
        params.put("endRow", endRow);
        return mapper.searchByEmailPaged(params);
    }

    // 전체 레코드 수
    @Override
    public int countAll() {
        return mapper.countAll();
    }

    // 이름으로 검색된 전체 레코드 수
    @Override
    public int countByName(String adresNm) {
        return mapper.countByName(adresNm);
    }

    // 부서로 검색된 전체 레코드 수
    @Override
    public int countByDepartment(String adresCoNm) {
        return mapper.countByDepartment(adresCoNm);
    }

    // 이메일로 검색된 전체 레코드 수
    @Override
    public int countByEmail(String adresEml) {
        return mapper.countByEmail(adresEml);
    }
    
    // 사내인원 검색 및 페이징 기능
    public List<EmployeeVO> selectEmployeeAllPaged(int startRow, int endRow) {
        Map<String, Integer> params = new HashMap<>();
        params.put("startRow", startRow);
        params.put("endRow", endRow);
        return mapper.selectEmployeeAllPaged(params);
    }

    @Override
    public List<EmployeeVO> searchEmployeeByNamePaged(String emplNm, int startRow, int endRow) {
        Map<String, Object> params = new HashMap<>();
        params.put("emplNm", emplNm);
        params.put("startRow", startRow);
        params.put("endRow", endRow);
        return mapper.searchEmployeeByNamePaged(params);
    }

    @Override
    public List<EmployeeVO> searchEmployeeByDepartmentPaged(String deptCd, int startRow, int endRow) {
        Map<String, Object> params = new HashMap<>();
        params.put("deptCd", deptCd);
        params.put("startRow", startRow);
        params.put("endRow", endRow);
        return mapper.searchEmployeeByDepartmentPaged(params);
    }

    @Override
    public List<EmployeeVO> searchEmployeeByPositionPaged(String positionCd, int startRow, int endRow) {
        Map<String, Object> params = new HashMap<>();
        params.put("positionCd", positionCd);
        params.put("startRow", startRow);
        params.put("endRow", endRow);
        return mapper.searchEmployeeByPositionPaged(params);
    }

    @Override
    public int countAllEmployee() {
        return mapper.countAllEmployee();
    }

    @Override
    public int countEmployeeByName(String emplNm) {
        return mapper.countEmployeeByName(emplNm);
    }

    @Override
    public int countEmployeeByDepartment(String deptCd) {
        return mapper.countEmployeeByDepartment(deptCd);
    }

    @Override
    public int countEmployeeByPosition(String positionCd) {
        return mapper.countEmployeeByPosition(positionCd);
    }

    
    @Override
    public List<AddressBookVO> searchAddressesPaged(String select, String searchText, int startRow, int endRow) {
        Map<String, Object> params = new HashMap<>();
        params.put("select", select);
        params.put("searchText", searchText);
        params.put("startRow", startRow);
        params.put("endRow", endRow);
        return mapper.searchAddressesPaged(params);
    }

    @Override
    public int countAddresses(String select, String searchText) {
        Map<String, Object> params = new HashMap<>();
        params.put("select", select);
        params.put("searchText", searchText);
        return mapper.countAddresses(params);
    }


    @Override
    public List<EmployeeVO> searchEmployeePaged(String select, String searchText, int startRow, int endRow) {
        Map<String, Object> params = new HashMap<>();
        params.put("select", select);
        params.put("searchText", searchText);
        params.put("startRow", startRow);
        params.put("endRow", endRow);
        return mapper.searchEmployeePaged(params);
    }

    @Override
    public int countEmployee(String select, String searchText) {
        Map<String, Object> params = new HashMap<>();
        params.put("select", select);
        params.put("searchText", searchText);
        return mapper.countEmployee(params);
    }


}
