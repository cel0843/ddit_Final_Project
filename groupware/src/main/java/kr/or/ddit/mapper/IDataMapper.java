package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.util.ServiceResult;
import kr.or.ddit.vo.AttachFileVO;
import kr.or.ddit.vo.CustomFileVO;
import kr.or.ddit.vo.DataVO;
import kr.or.ddit.vo.EmployeeVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface IDataMapper {
// 공통	
	public int insertFileData(AttachFileVO fileVO); 
	public int getNextFileGroupNo(); // 파일 그룹 번호를 가져오는 메서드
	public int getNextFileNo(int fileGroupNo);
	public int insertFolderFileData(AttachFileVO fileVO);
	public void fileDelete(AttachFileVO fileVO);
	public CustomFileVO getFile(Map<String, Object> map);
	public void filegroupNoUpdate(DataVO filegroupNoUpdateDataVO);
	public List<DataVO> search(Map<String, Object> param);
	public int getFldNo(int fileGroupNo);
// 개인자료실	
	public Map<String, Object> selectTotalUsage(String emplId);
	public List<DataVO> selectDataList(String emplId);
	public List<AttachFileVO> selectFileList(int fileGroupNo);
	public List<DataVO> selectAllfileList(String emplId);
	public int insertFolderData(DataVO dataVO);
	
//	곻용자료실
	public List<DataVO> commonSearch(Map<String, Object> param);
	public List<DataVO> selectCommonAllfileList(String emplId);
	public List<DataVO> selectCommonDataList(String emplId);
	public int insertCommonFolderData(DataVO dataVO);
	public void deleteFolder(int fldNo);
	public List<DataVO> commonFolderSearch(Map<String, Object> param);
	
	
	public List<EmployeeVO> selectFileAllPaged(Map<String, Integer> params);
	public int countAllFile();
	public List<EmployeeVO> searchEmployeePaged(Map<String, Object> params);
	public int countEmployee(Map<String, Object> params);
	public List<DataVO> folderSearch(Map<String, Object> param);
	public int getFgn0(int fldNo);
	public int selectFileCount(String emplId);
	
}
