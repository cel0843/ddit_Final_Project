package kr.or.ddit.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.or.ddit.vo.CustomFileVO;
import kr.or.ddit.vo.EmployeeVO;
import kr.or.ddit.vo.MailReVO;
import kr.or.ddit.vo.MailSendVO;

public interface IMailMapper {
    
    //보낸메일함 리스트
    public List<MailSendVO> sendList(String emplId);
    
    //받은메일함 리스트
    public List<MailSendVO> reList(String emplId);
    
    //중요메일함 리스트
    public List<MailSendVO> impoList(String emplId);
    
    //임시보관함 리스트
    public List<MailSendVO> drfList(String emplId);
    
    //휴지통 리스트 
    public List<MailSendVO> trashList(String emplId);
    
    //나에게 보내는 메일함 리스트 
    public List<MailSendVO> mineList(String emplId);
    
    //파일 그룹번호 가져오기
    public int getNextFileGroupNo();
    
    //통합파일테이블에서 파일인서트하기
    public void insertAttachFile(CustomFileVO fileInfo);
    
    //참조인풋영역에서 리스트 가져오기
    public List<EmployeeVO> emplList();
    
    // 이메일 전송 관련 메서드
    public void insertEmailSend(MailSendVO mailSendVO);
    
    public void insertMailRe(MailReVO mailReVO);
    
    public void updateMscCode(@Param("mreNo") int mreNo, @Param("mscCode") String mscCode);
    
    public MailSendVO getMailDetail(@Param("mreNo") int mreNo);
    
    public MailSendVO getsendDetail(@Param("emlNo")int emlNo);
    
    public int reCount(String emplId);
    
    public int cntReList(String emplId);
    
    
    
    public List<CustomFileVO> getFilesByGroupNo(int fileGroupNo);
    
    public CustomFileVO getFile(@Param("fileGroupNo") int fileGroupNo, @Param("fileNo") int fileNo);

	public int groupSearch();

	public void deleteMailPermanently(int emlNo);

	public void readCheck(int mreNo);

	public void deleteDraft(int emlNo);
	
	public List<MailSendVO> selectReListPaged(@Param("emplId") String emplId, @Param("startRow") int startRow, @Param("endRow") int endRow);
	
	List<MailSendVO> selectImpoListPaged(@Param("emplId") String emplId, @Param("startRow") int startRow, @Param("endRow") int endRow);
	
	int cntImpoList(String emplId);
	
	List<MailSendVO> selectMineListPaged(@Param("emplId") String emplId, @Param("startRow") int startRow, @Param("endRow") int endRow);
	int cntMineList(String emplId);
	
	List<MailSendVO> selectTrashListPaged(@Param("emplId") String emplId, @Param("startRow") int startRow, @Param("endRow") int endRow);
	int cntTrashList(String emplId);
	
	
	int cntSendList(@Param("emplId") String emplId);
	List<MailSendVO> sendListPaged(@Param("emplId") String emplId, @Param("startRow") int startRow, @Param("endRow") int endRow);

	
	int cntDrfList(String emplId);
	List<MailSendVO> drfListPaged(@Param("emplId") String emplId, @Param("startRow") int startRow, @Param("endRow") int endRow);

	List<MailSendVO> searchMailsByTitle(@Param("emplId") String emplId, @Param("query") String query, @Param("startRow") int startRow, @Param("endRow") int endRow);
	List<MailSendVO> searchMailsByContent(@Param("emplId") String emplId, @Param("query") String query, @Param("startRow") int startRow, @Param("endRow") int endRow);
	int countSearchMailsByTitle(@Param("emplId") String emplId, @Param("query") String query);
	int countSearchMailsByContent(@Param("emplId") String emplId, @Param("query") String query);
	
	List<MailSendVO> ImposearchMailsByTitle(@Param("emplId") String emplId, @Param("query") String query, @Param("startRow") int startRow, @Param("endRow") int endRow);
	List<MailSendVO> ImposearchMailsByContent(@Param("emplId") String emplId, @Param("query") String query, @Param("startRow") int startRow, @Param("endRow") int endRow);
	
	List<MailSendVO> TrashsearchMailsByTitle(@Param("emplId") String emplId, @Param("query") String query, @Param("startRow") int startRow, @Param("endRow") int endRow);
	List<MailSendVO> TrashsearchMailsByContent(@Param("emplId") String emplId, @Param("query") String query, @Param("startRow") int startRow, @Param("endRow") int endRow);
	
	List<MailSendVO> MinesearchMailsByTitle(@Param("emplId") String emplId, @Param("query") String query, @Param("startRow") int startRow, @Param("endRow") int endRow);
	List<MailSendVO> MinesearchMailsByContent(@Param("emplId") String emplId, @Param("query") String query, @Param("startRow") int startRow, @Param("endRow") int endRow);
	
	List<MailSendVO> DrfesearchMailsByTitle(@Param("emplId") String emplId, @Param("query") String query, @Param("startRow") int startRow, @Param("endRow") int endRow);
	List<MailSendVO> DrfsearchMailsByContent(@Param("emplId") String emplId, @Param("query") String query, @Param("startRow") int startRow, @Param("endRow") int endRow);
	
	List<MailSendVO> SendesearchMailsByTitle(@Param("emplId") String emplId, @Param("query") String query, @Param("startRow") int startRow, @Param("endRow") int endRow);
	List<MailSendVO> SendsearchMailsByContent(@Param("emplId") String emplId, @Param("query") String query, @Param("startRow") int startRow, @Param("endRow") int endRow);
	
	
	void archiveMail(@Param("emlNo") int emlNo);
	
	void updateEmlSendCode(@Param("emlNo") int emlNo, @Param("mscCode") String mscCode);
	
	void updateEmlSendCodeAndDelYn(@Param("emlNo") int emlNo, @Param("emlDrfYn") String delyn,@Param("mscCode") String mscCode);


}
