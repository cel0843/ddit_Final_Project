package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import kr.or.ddit.vo.AddressBookVO;
import kr.or.ddit.vo.EmployeeVO;

public interface IAdresMapper {
    // 외부인원 관련 메서드들
   public List<AddressBookVO> colist();
   public AddressBookVO coRead(int adresNo);
   
   public void creat(AddressBookVO adresBookVO);   
   public void delete(int adresNo);
   public void update(AddressBookVO adresBookVO);

    // 외부인원 주소록 페이징 및 검색 메서드들
   public  List<AddressBookVO> selectAllPaged(Map<String, Integer> params);
   public List<AddressBookVO> searchByNamePaged(Map<String, Object> params);
   public List<AddressBookVO> searchByDepartmentPaged(Map<String, Object> params);
   public List<AddressBookVO> searchByEmailPaged(Map<String, Object> params);
   public int countAll();
   public int countByName(String adresNm);
   public int countByDepartment(String adresCoNm);
   public int countByEmail(String adresEml);

    // 사내인원 관련 메서드들
   public List<EmployeeVO> emplList();
   public EmployeeVO read(String emplId);

    // 사내인원 주소록 페이징 및 검색 메서드들
   public List<EmployeeVO> selectEmployeeAllPaged(Map<String, Integer> params);
   public List<EmployeeVO> searchEmployeeByNamePaged(Map<String, Object> params);
   public List<EmployeeVO> searchEmployeeByDepartmentPaged(Map<String, Object> params);
   public List<EmployeeVO> searchEmployeeByPositionPaged(Map<String, Object> params);
   public int countAllEmployee();
   public int countEmployeeByName(String emplNm);
   public int countEmployeeByDepartment(String deptCd);
   public int countEmployeeByPosition(String positionCd);
   
   public List<AddressBookVO> searchAddressesPaged(Map<String, Object> params);
   public int countAddresses(Map<String, Object> params);
   
	// 사내인원 주소록 페이징 및 검색 메서드들
   public List<EmployeeVO> searchEmployeePaged(Map<String, Object> params);
   public int countEmployee(Map<String, Object> params);

}