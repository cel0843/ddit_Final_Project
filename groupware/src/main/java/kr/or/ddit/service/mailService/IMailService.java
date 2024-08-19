package kr.or.ddit.service.mailService;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.vo.CustomFileVO;
import kr.or.ddit.vo.EmployeeVO;
import kr.or.ddit.vo.MailSendVO;
import kr.or.ddit.vo.MailReVO;

public interface IMailService {
    List<MailSendVO> sendList(String emplId);
    List<MailSendVO> reList(String emplId);
    List<MailSendVO> impoList(String emplId);
    List<MailSendVO> drfList(String emplId);
    List<MailSendVO> trashList(String emplId);
    List<MailSendVO> mineList(String emplId);
    int saveFiles(MultipartFile[] files) throws IOException;
    
    int insertEmailSend(MailSendVO mailSendVO);
    
    void insertMailRe(MailReVO mailReVO);
    List<EmployeeVO> emplList();
    void updateMscCode(int mreNo, String mscCode);
    MailSendVO getMailDetail(int mreNo);
    MailSendVO getsendDetail(int emlNo);
    
    int reCount(String emplId);
    
    List<CustomFileVO> getFilesByGroupNo(int fileGroupNo)
    ;
    CustomFileVO getFile(int fileNo,int fileGroupNo);
	int groupSearch();
	void deleteMailPermanently(int emlNo);
	void readCheck(int mreNo);
	
	void deleteDraft(int draftId);
	List<MailSendVO> reListPaged(String emplId, int startRow, int endRow);
	int cntReList(String emplId);

	List<MailSendVO> impoListPaged(String emplId, int startRow, int endRow);
	int cntImpoList(String emplId);
	
	List<MailSendVO> mineListPaged(String emplId, int startRow, int endRow);
	int cntMineList(String emplId);
	
	List<MailSendVO> trashListPaged(String emplId, int startRow, int endRow);
	int cntTrashList(String emplId);
	
	List<MailSendVO> sendListPaged(String emplId, int startRow, int endRow);
    int cntSendList(String emplId);
    
    List<MailSendVO> drfListPaged(String emplId, int startRow, int endRow);
    int cntDrfList(String emplId);

    List<MailSendVO> searchMails(String emplId, String query, String type, int startRow, int endRow);
    int countSearchMails(String emplId, String query, String type);
    
	List<MailSendVO> ImposearchMails(String emplId, String query, String type, int startRow, int endRow);
	int ImpocountSearchMails(String emplId, String query, String type);
	
	List<MailSendVO> TrashsearchMails(String emplId, String query, String type, int startRow, int endRow);
	int TrashcountSearchMails(String emplId, String query, String type);
	
	List<MailSendVO> MinesearchMails(String emplId, String query, String type, int startRow, int endRow);
	int MinecountSearchMails(String emplId, String query, String type);
	
	List<MailSendVO> drfSearchMails(String emplId, String query, String type, int startRow, int endRow);
	int drfCountSearchMails(String emplId, String query, String type);
	
	List<MailSendVO> searchSendMails(String emplId, String query, String type, int startRow, int endRow);
	int countSearchSendMails(String emplId, String query, String type);
	
	void archiveMail(int emlNo);
    
	void updateEmlSendCode(int emlNo, String mscCode);
	
	void updateEmlSendCodeAndDelYn(int emlNo,String delyn, String mscCode);
	 
}

