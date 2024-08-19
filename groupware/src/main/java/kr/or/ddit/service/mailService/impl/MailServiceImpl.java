package kr.or.ddit.service.mailService.impl;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.mapper.IMailMapper;
import kr.or.ddit.service.mailService.IMailService;
import kr.or.ddit.vo.CustomFileVO;
import kr.or.ddit.vo.EmployeeVO;
import kr.or.ddit.vo.MailReVO;
import kr.or.ddit.vo.MailSendVO;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MailServiceImpl implements IMailService {

    @Inject
    private IMailMapper mapper;

    @Override
    public List<MailSendVO> sendList(String emplId) {
        return mapper.sendList(emplId);
    }

    @Override
    public List<MailSendVO> reList(String emplId) {
        return mapper.reList(emplId);
    }
    //reList search
    @Override
    public List<MailSendVO> searchMails(String emplId, String query, String type, int startRow, int endRow) {
        if ("content".equals(type)) {
            return mapper.searchMailsByContent(emplId, query, startRow, endRow);
        } else {
            return mapper.searchMailsByTitle(emplId, query, startRow, endRow);
        }
    }

    @Override
    public int countSearchMails(String emplId, String query, String type) {
        if ("content".equals(type)) {
            return mapper.countSearchMailsByContent(emplId, query);
        } else {
            return mapper.countSearchMailsByTitle(emplId, query);
        }
    }
    
    //impoList search

	@Override
	public List<MailSendVO> ImposearchMails(String emplId, String query, String type, int startRow, int endRow) {
		 if ("content".equals(type)) {
	            return mapper.ImposearchMailsByContent(emplId, query, startRow, endRow);
         } else {
	            return mapper.ImposearchMailsByTitle(emplId, query, startRow, endRow);
         }
	}

	@Override
	public int ImpocountSearchMails(String emplId, String query, String type) {
		if ("content".equals(type)) {
            return mapper.countSearchMailsByContent(emplId, query);
        } else {
            return mapper.countSearchMailsByTitle(emplId, query);
        }
	}
	
	@Override
	public List<MailSendVO> TrashsearchMails(String emplId, String query, String type, int startRow, int endRow) {
	  if ("content".equals(type)) {
	            return mapper.TrashsearchMailsByContent(emplId, query, startRow, endRow);
      } else {
	            return mapper.TrashsearchMailsByTitle(emplId, query, startRow, endRow);
      }
	}

	@Override
	public int TrashcountSearchMails(String emplId, String query, String type) {
		if ("content".equals(type)) {
            return mapper.countSearchMailsByContent(emplId, query);
        } else {
            return mapper.countSearchMailsByTitle(emplId, query);
        }
	}
	
	@Override
	public List<MailSendVO> MinesearchMails(String emplId, String query, String type, int startRow, int endRow) {
		if ("content".equals(type)) {
            return mapper.MinesearchMailsByContent(emplId, query, startRow, endRow);
		} else {
		    return mapper.MinesearchMailsByTitle(emplId, query, startRow, endRow);
		}
	}

	@Override
	public int MinecountSearchMails(String emplId, String query, String type) {
		if ("content".equals(type)) {
            return mapper.countSearchMailsByContent(emplId, query);
        } else {
            return mapper.countSearchMailsByTitle(emplId, query);
        }
	}
	
	
	@Override
	public List<MailSendVO> drfSearchMails(String emplId, String query, String type, int startRow, int endRow) {
		if ("content".equals(type)) {
            return mapper.DrfsearchMailsByContent(emplId, query, startRow, endRow);
		} else {
		    return mapper.DrfesearchMailsByTitle(emplId, query, startRow, endRow);
		}
	}

	@Override
	public int drfCountSearchMails(String emplId, String query, String type) {
		if ("content".equals(type)) {
            return mapper.countSearchMailsByContent(emplId, query);
        } else {
            return mapper.countSearchMailsByTitle(emplId, query);
        }
	}
	
	@Override
	public List<MailSendVO> searchSendMails(String emplId, String query, String type, int startRow, int endRow) {
		if ("content".equals(type)) {
            return mapper.SendsearchMailsByContent(emplId, query, startRow, endRow);
		} else {
		    return mapper.SendesearchMailsByTitle(emplId, query, startRow, endRow);
		}
	}

	@Override
	public int countSearchSendMails(String emplId, String query, String type) {
		if ("content".equals(type)) {
            return mapper.countSearchMailsByContent(emplId, query);
        } else {
            return mapper.countSearchMailsByTitle(emplId, query);
        }
	}
    

    @Override
    public List<MailSendVO> impoList(String emplId) {
        return mapper.impoList(emplId);
    }

    @Override
    public List<MailSendVO> drfList(String emplId) {
        return mapper.drfList(emplId);
    }

    @Override
    public List<MailSendVO> trashList(String emplId) {
        return mapper.trashList(emplId);
    }

    @Override
    public List<MailSendVO> mineList(String emplId) {
        return mapper.mineList(emplId);
    }

    private static final String resourcePath = "C:/groupware_file_upload/upload_files/";

    @Override
    @Transactional
    public int saveFiles(MultipartFile[] files) throws IOException {
        int fileGroupNo = mapper.getNextFileGroupNo();
        for (int i = 0; i < files.length; i++) {
            MultipartFile file = files[i];
            CustomFileVO fileInfo = saveFile(file, fileGroupNo, i + 1);
            mapper.insertAttachFile(fileInfo);
        }
        return fileGroupNo;
    }

    private CustomFileVO saveFile(MultipartFile file, int fileGroupNo, int fileNo) throws IOException {
        String originalFilename = file.getOriginalFilename();
        String uuid = UUID.randomUUID().toString();
        String fileStrgNm = uuid + "_" + originalFilename;
        String filePath = resourcePath + fileStrgNm;

        File dest = new File(filePath);
        if (!dest.getParentFile().exists()) {
            dest.getParentFile().mkdirs();
        }
        file.transferTo(dest);

        CustomFileVO fileInfo = new CustomFileVO(file);
        fileInfo.setFileGroupNo(fileGroupNo);
        fileInfo.setFileNo(fileNo);
        fileInfo.setFilePath(filePath);
        fileInfo.setFileStrgNm(fileStrgNm);
        fileInfo.setFileOrgnlNm(originalFilename);
        fileInfo.setFileSz(file.getSize());
        fileInfo.setFileFancysize(convertSize(file.getSize()));
        fileInfo.setFileCtrDt(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
        fileInfo.setFileType(getFileExtension(originalFilename));
        fileInfo.setFileDelyn("N");
        return fileInfo;
    }

    private static String convertSize(long size) {
        if (size <= 0) return "0";
        final String[] units = new String[]{"B", "KB", "MB", "GB", "TB"};
        int digitGroups = (int) (Math.log10(size) / Math.log10(1024));
        return String.format("%.1f %s", size / Math.pow(1024, digitGroups), units[digitGroups]);
    }

    private static String getFileExtension(String fileName) {
        int lastIndex = fileName.lastIndexOf('.');
        return (lastIndex == -1) ? "" : fileName.substring(lastIndex + 1);
    }

    @Override
    public List<EmployeeVO> emplList() {
        return mapper.emplList();
    }

    @Override
    @Transactional
    public int insertEmailSend(MailSendVO mailSendVO) {
        // 날짜 형식을 올바르게 지정
        mailSendVO.setEmlDt(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
        if (mailSendVO.getFileGroupNo() != null && mailSendVO.getFileGroupNo() != 0 ) {
            mailSendVO.setFileGroupNo(mapper.groupSearch());
        }
        mapper.insertEmailSend(mailSendVO);
        return mailSendVO.getEmlNo();
    }

    @Override
    @Transactional
    public void insertMailRe(MailReVO mailReVO) {
        mapper.insertMailRe(mailReVO);
    }
    
    @Override
    public void updateMscCode(int mreNo, String mscCode) {
        mapper.updateMscCode(mreNo, mscCode);
    }
    
    @Override
    public MailSendVO getMailDetail(int mreNo) {
        return mapper.getMailDetail(mreNo);
    }

    @Override
    public MailSendVO getsendDetail(int emlNo) {
        return mapper.getsendDetail(emlNo);
    }

    @Override
    public int reCount(String emplId) {
        return mapper.reCount(emplId);
    }

    @Override
    public List<CustomFileVO> getFilesByGroupNo(int fileGroupNo) {
        return mapper.getFilesByGroupNo(fileGroupNo);
    }

    @Override
    public CustomFileVO getFile(int fileNo,int fileGroupNo) {
        return mapper.getFile(fileNo,fileGroupNo);
    }

	@Override
	public int groupSearch() {
		return mapper.groupSearch();
	}

	@Override
	@Transactional
	public void deleteMailPermanently(int emlNo) {
	    mapper.deleteMailPermanently(emlNo);
	}

	@Override
	public void readCheck(int mreNo) {
		mapper.readCheck(mreNo);
	}
	@Override
	public void deleteDraft(int emlNo) {
		mapper.deleteDraft(emlNo);
	}
	

	
	@Override
	public List<MailSendVO> reListPaged(String emplId, int startRow, int endRow) {
	    return mapper.selectReListPaged(emplId, startRow, endRow);
	}

	@Override
	public int cntReList(String emplId) {
		return mapper.cntReList(emplId);
	}

	@Override
	public List<MailSendVO> impoListPaged(String emplId, int startRow, int endRow) {
		return mapper.selectImpoListPaged(emplId, startRow , endRow);
	}

	@Override
	public int cntImpoList(String emplId) {
		return mapper.cntImpoList(emplId);
	}

	
	@Override
	public List<MailSendVO> mineListPaged(String emplId, int startRow, int endRow) {
	    return mapper.selectMineListPaged(emplId, startRow, endRow);
	}

	@Override
	public int cntMineList(String emplId) {
	    return mapper.cntMineList(emplId);
	}
	
	
	@Override
	public List<MailSendVO> trashListPaged(String emplId, int startRow, int endRow) {
	    return mapper.selectTrashListPaged(emplId, startRow, endRow);
	}

	@Override
	public int cntTrashList(String emplId) {
	    return mapper.cntTrashList(emplId);
	}

	@Override
    public int cntSendList(String emplId) {
        return mapper.cntSendList(emplId);
    }

    @Override
    public List<MailSendVO> sendListPaged(String emplId, int startRow, int endRow) {
        return mapper.sendListPaged(emplId, startRow, endRow);
    }
    
    @Override
    public List<MailSendVO> drfListPaged(String emplId, int startRow, int endRow) {
        return mapper.drfListPaged(emplId, startRow, endRow);
    }

    @Override
    public int cntDrfList(String emplId) {
        return mapper.cntDrfList(emplId);
    }

    @Override
    public void archiveMail(int emlNo) {
        mapper.archiveMail(emlNo);
    }

	
    @Override
    @Transactional
    public void updateEmlSendCode(int emlNo, String mscCode) {
        mapper.updateEmlSendCode(emlNo, mscCode);
    }
    
    @Override
    @Transactional
    public void updateEmlSendCodeAndDelYn(int emlNo,String delyn ,  String mscCode) {
    	mapper.updateEmlSendCodeAndDelYn(emlNo, delyn , mscCode);
    }
	



	
}
