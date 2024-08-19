package kr.or.ddit.service.data;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import kr.or.ddit.util.ServiceResult;
import kr.or.ddit.vo.AttachFileVO;
import kr.or.ddit.vo.CustomFileVO;
import kr.or.ddit.vo.DataVO;
import kr.or.ddit.vo.EmployeeVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface IDataService {
	public Map<String, Object> selectTotalUsage(String emplId);
	public List<DataVO> selectDataList(String emplId);
	public List<DataVO> selectAllfileList(String emplId);
	public List<DataVO> search(Map<String, Object> param);
	public List<AttachFileVO> selectFileList(int fileGroupNo);
	public ServiceResult createFolder(DataVO dataVO);
    public ServiceResult uploadFile(HttpServletRequest req, AttachFileVO fileVO);
    public int getNextFileGroupNo(); // 파일 그룹 번호를 가져오는 메서드
	public int getNextFileNo(int fileGroupNo);
	public int getFldNo(int fileGroupNo);
	public void uploadFolderFile(HttpServletRequest req, AttachFileVO fileVO);
	public void fileDelete(AttachFileVO fileVO);
	public void filegroupNoUpdate(DataVO filegroupNoUpdateDataVO);
	public CustomFileVO getFile(Map<String, Object> map);
	
//	공용자료실
	public List<DataVO> selectCommonDataList(String emplId);
	public List<DataVO> selectCommonAllfileList(String emplId);
	public List<DataVO> 
	commonSearch(Map<String, Object> param);
	public ServiceResult createCommonFolder(DataVO dataVO);
	public void deleteFolder(int fldNo);
	public List<DataVO> commonFolderSearch(Map<String, Object> param);
	public List<DataVO> folderSearch(Map<String, Object> param);
	public int getFgn0(int fldNo);
	public int selectFileCount(String emplId);
	
	
}
