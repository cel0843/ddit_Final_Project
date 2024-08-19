package kr.or.ddit.service.addressService;

import java.util.List;

import kr.or.ddit.vo.AddressBookVO;
import kr.or.ddit.vo.EmployeeVO;

public interface IAddressService {
    // 전체 주소록 페이징
    public List<AddressBookVO> selectAllPaged(int startRow, int endRow);

    // 이름으로 검색된 주소록 페이징
    public List<AddressBookVO> searchByNamePaged(String adresNm, int startRow, int endRow);

    // 부서로 검색된 주소록 페이징
    public List<AddressBookVO> searchByDepartmentPaged(String adresCoNm, int startRow, int endRow);

    // 이메일로 검색된 주소록 페이징
    public List<AddressBookVO> searchByEmailPaged(String adresEml, int startRow, int endRow);

    // 전체 레코드 수
    public int countAll();

    // 이름으로 검색된 전체 레코드 수
    public int countByName(String adresNm);

    // 부서로 검색된 전체 레코드 수
    public int countByDepartment(String adresCoNm);

    // 이메일로 검색된 전체 레코드 수
    public int countByEmail(String adresEml);

    // 사내 인원 주소록 리스트
    public List<EmployeeVO> emplList();

    // 외부 인원 주소록 리스트
    public List<AddressBookVO> colist();

    // 사내 인원 주소록 상세보기
    public EmployeeVO adresRead(String  emplId);

    // 외부 인원 주소록 상세보기
    public AddressBookVO coRead(int adresNo);

    // 외부 인원 주소록 등록
    public void register(AddressBookVO adresBookVO);
    
    

    // 외부 인원 주소록 삭제
    public void codelete(int adresNo);

    // 외부 인원 주소록 수정
    public void update(AddressBookVO adresBookVO);
    
    // 추가된 메서드들
    List<EmployeeVO> selectEmployeeAllPaged(int startRow, int endRow);
    
    List<EmployeeVO> searchEmployeeByNamePaged(String emplNm, int startRow, int endRow);
    List<EmployeeVO> searchEmployeeByDepartmentPaged(String deptCd, int startRow, int endRow);
    List<EmployeeVO> searchEmployeeByPositionPaged(String positionCd, int startRow, int endRow);
    
    int countAllEmployee();
    
    int countEmployeeByName(String emplNm);
    int countEmployeeByDepartment(String deptCd);
    int countEmployeeByPosition(String positionCd);
    
    
    
    // 다중 x 통합검색 페이징
    public List<AddressBookVO> searchAddressesPaged(String select, String searchText, int startRow, int endRow);
    public int countAddresses(String select, String searchText);
    
    
    
    
    List<EmployeeVO> searchEmployeePaged(String select, String searchText, int startRow, int endRow);
    int countEmployee(String select, String searchText);

    
    
}
