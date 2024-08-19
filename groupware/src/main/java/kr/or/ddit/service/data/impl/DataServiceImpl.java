package kr.or.ddit.service.data.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import kr.or.ddit.mapper.IDataMapper;
import kr.or.ddit.service.data.IDataService;
import kr.or.ddit.util.ServiceResult;
import kr.or.ddit.vo.AttachFileVO;
import kr.or.ddit.vo.CustomFileVO;
import kr.or.ddit.vo.DataVO;
import kr.or.ddit.vo.EmployeeVO;
import kr.or.ddit.vo.PaginationInfoVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class DataServiceImpl implements IDataService {

    @Inject
    private IDataMapper mapper;

    @Transactional
    @Override
    public ServiceResult uploadFile(HttpServletRequest req, AttachFileVO fileVO) {
    	
        int cnt = mapper.insertFileData(fileVO);
        return cnt > 0 ? ServiceResult.OK : ServiceResult.FAILED;
    }

    @Override
    public ServiceResult createFolder(DataVO dataVO) {
        ServiceResult result = null;
        int status = mapper.insertFolderData(dataVO);
        if (status > 0) {
            result = ServiceResult.OK;
        } else {
            result = ServiceResult.FAILED;
        }
        return result;
    }
    
    @Override
    public ServiceResult createCommonFolder(DataVO dataVO) {
    	ServiceResult result = null;
    	int status = mapper.insertCommonFolderData(dataVO);
    	if (status > 0) {
    		result = ServiceResult.OK;
    	} else {
    		result = ServiceResult.FAILED;
    	}
    	return result;
    }

    @Override
	public List<DataVO> selectDataList(String emplId) {
		return mapper.selectDataList(emplId);
	}

    @Override
    public int getNextFileGroupNo() {
        return mapper.getNextFileGroupNo();
    }

	@Override
	public List<AttachFileVO> selectFileList(int fileGroupNo) {
		return mapper.selectFileList(fileGroupNo);
	}

	@Override
	public Map<String, Object> selectTotalUsage(String emplId) {
		return mapper.selectTotalUsage(emplId);
	}
	

	@Override
	public int getNextFileNo(int fileGroupNo) {
		return mapper.getNextFileNo(fileGroupNo);
	}

	@Override
	public void uploadFolderFile(HttpServletRequest req, AttachFileVO fileVO) {
		
	    mapper.insertFolderFileData(fileVO);
	}

	@Override
	public void fileDelete(AttachFileVO fileVO) {
		mapper.fileDelete(fileVO);
	}

	@Override
	public List<DataVO> selectAllfileList(String emplId) {
		log.info("selectAllfileList");
		System.out.println("emplId : " + emplId);
		return mapper.selectAllfileList(emplId);
	}


	@Override
	public CustomFileVO getFile(Map<String, Object> map) {
		return mapper.getFile(map);
	}

	@Override
	public void filegroupNoUpdate(DataVO filegroupNoUpdateDataVO) {
		mapper.filegroupNoUpdate(filegroupNoUpdateDataVO);
		
	}

	@Override
	public List<DataVO> search(Map<String, Object> param) {
		return mapper.search(param);
	}

	@Override
	public int getFldNo(int fileGroupNo) {
		return mapper.getFldNo(fileGroupNo);
	}

	@Override
	public List<DataVO> commonSearch(Map<String, Object> param) {
		return mapper.commonSearch(param);
	}

	@Override
	public List<DataVO> selectCommonAllfileList(String emplId) {
		return mapper.selectCommonAllfileList(emplId);
	}

	@Override
	public List<DataVO> selectCommonDataList(String emplId) {
		return mapper.selectCommonDataList(emplId);
	}

	@Override
	public void deleteFolder(int fldNo) {
		mapper.deleteFolder(fldNo);
	}

	@Override
	public List<DataVO> commonFolderSearch(Map<String, Object> param) {
		return mapper.commonFolderSearch(param);
	}

	@Override
	public List<DataVO> folderSearch(Map<String, Object> param) {
		return mapper.folderSearch(param);
	}

	@Override
	public int getFgn0(int fldNo) {
		return mapper.getFgn0(fldNo);
	}

	@Override
	public int selectFileCount(String emplId) {
		return mapper.selectFileCount(emplId);
	}

}
