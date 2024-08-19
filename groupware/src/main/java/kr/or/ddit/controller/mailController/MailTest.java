package kr.or.ddit.controller.mailController;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.service.mailService.IMailService;
import kr.or.ddit.vo.CustomEmployeeVO;
import kr.or.ddit.vo.CustomFileVO;
import kr.or.ddit.vo.EmployeeVO;
import kr.or.ddit.vo.MailReVO;
import kr.or.ddit.vo.MailSendVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("egg/mail")
public class MailTest {

    @Inject
    private IMailService service;
    
    @PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
    @RequestMapping(value = "/reList", method = RequestMethod.GET)
    public String reList(
        @RequestParam(name = "page", defaultValue = "1") int page, 
        @RequestParam(name = "query", required = false) String query,
        Model model, 
        HttpServletRequest request) {
        
        HttpSession session = request.getSession();
        CustomEmployeeVO emplInfo = (CustomEmployeeVO) session.getAttribute("emplInfo");
        String emplId = emplInfo.getEmplId();
        
        int pageSize = 15; // 한 페이지에 보여줄 레코드 수
        int startRow = (page - 1) * pageSize + 1;
        int endRow = page * pageSize;

        List<MailSendVO> reList;
        int totalRecords;
        if (query != null && !query.isEmpty()) {
            // 검색 쿼리가 있는 경우 검색 결과를 가져옴
            String type = "title"; // 기본 검색 타입을 title로 설정
            if (query.startsWith("content:")) {
                type = "content";
                query = query.substring(8); // 'content:'를 제거
            }
            reList = service.searchMails(emplId, query, type, startRow, endRow);
            totalRecords = service.countSearchMails(emplId, query, type);
        } else {
            // 검색 쿼리가 없는 경우 전체 목록을 가져옴
            reList = service.reListPaged(emplId, startRow, endRow);
            totalRecords = service.cntReList(emplId);
        }
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

        // 페이징 계산 로직 수정
        int visiblePages = 5; // 보여줄 페이지 수
        int startPage = Math.max(1, page - visiblePages / 2);
        int endPage = Math.min(totalPages, startPage + visiblePages - 1);

        // 만약 endPage가 visiblePages보다 작으면 startPage 조정
        if (endPage - startPage + 1 < visiblePages) {
            startPage = Math.max(1, endPage - visiblePages + 1);
        }
        int count = service.reCount(emplId);
        // 디버깅 정보 추가
        log.info("Total Records: " + totalRecords);
        log.info("Total Pages: " + totalPages);
        log.info("Current Page: " + page);
        log.info("Start Page: " + startPage);
        log.info("End Page: " + endPage);
        
        model.addAttribute("listCount", totalRecords);
        model.addAttribute("count", count);
        model.addAttribute("reList", reList);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("startRow", startRow);
        model.addAttribute("endRow", endRow);
        model.addAttribute("query", query); // 검색 쿼리 추가
        
        return "egg/email/reList";
    }


    










    @PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
    @RequestMapping(value = "/impoList", method = RequestMethod.GET)
    public String impoList(
        @RequestParam(name = "page", defaultValue = "1") int page,
        @RequestParam(name = "query", required = false) String query,
        Model model,
        HttpServletRequest request) {

        HttpSession session = request.getSession();
        CustomEmployeeVO emplInfo = (CustomEmployeeVO) session.getAttribute("emplInfo");
        String emplId = emplInfo.getEmplId();

        int pageSize = 15; // 한 페이지에 보여줄 레코드 수
        int startRow = (page - 1) * pageSize + 1;
        int endRow = page * pageSize;

        List<MailSendVO> impoList;
        int totalRecords;
        if (query != null && !query.isEmpty()) {
            // 검색 쿼리가 있는 경우 검색 결과를 가져옴
            String type = "title"; // 기본 검색 타입을 title로 설정
            if (query.startsWith("content:")) {
                type = "content";
                query = query.substring(8); // 'content:'를 제거
            }
            impoList = service.ImposearchMails(emplId, query, type, startRow, endRow);
            totalRecords = service.ImpocountSearchMails(emplId, query, type);
        } else {
            // 검색 쿼리가 없는 경우 전체 목록을 가져옴
            impoList = service.impoListPaged(emplId, startRow, endRow);
            totalRecords = service.cntImpoList(emplId);
        }
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

        // 페이징 계산 로직 수정
        int visiblePages = 5; // 보여줄 페이지 수
        int startPage = Math.max(1, page - visiblePages / 2);
        int endPage = Math.min(totalPages, startPage + visiblePages - 1);
        int listCount = service.reCount(emplId); 

        // 만약 endPage가 visiblePages보다 작으면 startPage 조정
        if (endPage - startPage + 1 < visiblePages) {
            startPage = Math.max(1, endPage - visiblePages + 1);
        }
        
        model.addAttribute("listCount", listCount);
        model.addAttribute("totalImpoRecords", totalRecords);
        model.addAttribute("impoList", impoList);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("startRow", startRow);
        model.addAttribute("endRow", endRow);
        model.addAttribute("query", query); // 검색 쿼리 추가

        return "egg/email/impoList";
    }


    @PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
    @RequestMapping(value = "/drfList", method = RequestMethod.GET)
    public String drfList(
        @RequestParam(name = "page", defaultValue = "1") int page, 
        @RequestParam(name = "query", required = false) String query,
        Model model, 
        HttpServletRequest request) {

        HttpSession session = request.getSession();
        CustomEmployeeVO emplInfo = (CustomEmployeeVO) session.getAttribute("emplInfo");
        String emplId = emplInfo.getEmplId();

        int pageSize = 15; // 한 페이지에 보여줄 레코드 수
        int startRow = (page - 1) * pageSize + 1;
        int endRow = page * pageSize;

        List<MailSendVO> drfList;
        int totalRecords;
        if (query != null && !query.isEmpty()) {
            // 검색 쿼리가 있는 경우 검색 결과를 가져옴
            String type = "title"; // 기본 검색 타입을 title로 설정
            if (query.startsWith("content:")) {
                type = "content";
                query = query.substring(8); // 'content:'를 제거
            }
            drfList = service.drfSearchMails(emplId, query, type, startRow, endRow);
            totalRecords = service.drfCountSearchMails(emplId, query, type);
        } else {
            // 검색 쿼리가 없는 경우 전체 목록을 가져옴
            drfList = service.drfListPaged(emplId, startRow, endRow);
            totalRecords = service.cntDrfList(emplId);
        }
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

        // 페이징 계산 로직 수정
        int visiblePages = 5; // 보여줄 페이지 수
        int startPage = Math.max(1, page - visiblePages / 2);
        int endPage = Math.min(totalPages, startPage + visiblePages - 1);

        // 만약 endPage가 visiblePages보다 작으면 startPage 조정
        if (endPage - startPage + 1 < visiblePages) {
            startPage = Math.max(1, endPage - visiblePages + 1);
        }
        int count = service.reCount(emplId);
        // 디버깅 정보 추가
        log.info("Total Records: " + totalRecords);
        log.info("Total Pages: " + totalPages);
        log.info("Current Page: " + page);
        log.info("Start Page: " + startPage);
        log.info("End Page: " + endPage);

        model.addAttribute("listCount", totalRecords);
        model.addAttribute("count", count);
        model.addAttribute("drfList", drfList);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("startRow", startRow);
        model.addAttribute("endRow", endRow);
        model.addAttribute("query", query); // 검색 쿼리 추가

        return "egg/email/drfList";
    }


    @PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
    @RequestMapping(value = "/sendList", method = RequestMethod.GET)
    public String sendList(
        @RequestParam(name = "page", defaultValue = "1") int page, 
        @RequestParam(name = "query", required = false) String query,
        Model model, 
        HttpServletRequest request) {

        HttpSession session = request.getSession();
        CustomEmployeeVO emplInfo = (CustomEmployeeVO) session.getAttribute("emplInfo");
        String emplId = emplInfo.getEmplId();

        int pageSize = 15; // 한 페이지에 보여줄 레코드 수
        int startRow = (page - 1) * pageSize + 1;
        int endRow = page * pageSize;

        List<MailSendVO> sendList;
        int totalRecords;

        if (query != null && !query.isEmpty()) {
            // 검색 쿼리가 있는 경우 검색 결과를 가져옴
            String type = "title"; // 기본 검색 타입을 title로 설정
            if (query.startsWith("content:")) {
                type = "content";
                query = query.substring(8); // 'content:'를 제거
            }
            sendList = service.searchSendMails(emplId, query, type, startRow, endRow);
            totalRecords = service.countSearchSendMails(emplId, query, type);
        } else {
            // 검색 쿼리가 없는 경우 전체 목록을 가져옴
            sendList = service.sendListPaged(emplId, startRow, endRow);
            totalRecords = service.cntSendList(emplId);
        }

        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

        // 페이징 계산 로직 수정
        int visiblePages = 5; // 보여줄 페이지 수
        int startPage = Math.max(1, page - visiblePages / 2);
        int endPage = Math.min(totalPages, startPage + visiblePages - 1);

        // 만약 endPage가 visiblePages보다 작으면 startPage 조정
        if (endPage - startPage + 1 < visiblePages) {
            startPage = Math.max(1, endPage - visiblePages + 1);
        }

        int count = service.reCount(emplId);

        // 디버깅 정보 추가
        log.info("Total Records: " + totalRecords);
        log.info("Total Pages: " + totalPages);
        log.info("Current Page: " + page);
        log.info("Start Page: " + startPage);
        log.info("End Page: " + endPage);
        
        /*
        // html 태그로 인해 목록 화면에 출력 시, 문제가 좀 있어 html태그를 날리고 글자 수를 70자로 제한한다.
        for(int i = 0; i < sendList.size(); i++) {
			// int cutSize = 130; 
        	MailSendVO msVO = sendList.get(i);
        	String content = msVO.getEmlCn();
        	int emlCnCnt = msVO.getEmlCn().length();
        	
        	int textSize = msVO.getEmlCn().replaceAll("<[^>]*>", " ").length();
        	if(textSize < emlCnCnt) {
        		emlCnCnt = content.replaceAll("<[^>]*>", " ").length()-1;
        	}
        	sendList.get(i).setEmlCn(content.replaceAll("<[^>]*>", " ").substring(0, emlCnCnt));
        }
    	*/
        
        model.addAttribute("listCount", totalRecords);
        model.addAttribute("count", count);
        model.addAttribute("sendList", sendList);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("startRow", startRow);
        model.addAttribute("endRow", endRow);
        model.addAttribute("query", query); // 검색 쿼리 추가

        return "egg/email/sendList";
    }


    @PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
    @RequestMapping(value = "/trashList", method = RequestMethod.GET)
    public String trashList(
        @RequestParam(name = "page", defaultValue = "1") int page, 
        @RequestParam(name = "query", required = false) String query,
        Model model, 
        HttpServletRequest request) {
        
        HttpSession session = request.getSession();
        CustomEmployeeVO emplInfo = (CustomEmployeeVO) session.getAttribute("emplInfo");
        String emplId = emplInfo.getEmplId();
        
        int pageSize = 15; // 한 페이지에 보여줄 레코드 수
        int startRow = (page - 1) * pageSize + 1;
        int endRow = page * pageSize;

        List<MailSendVO> trashList;
        int totalRecords;
        if (query != null && !query.isEmpty()) {
            // 검색 쿼리가 있는 경우 검색 결과를 가져옴
            String type = "title"; // 기본 검색 타입을 title로 설정
            if (query.startsWith("content:")) {
                type = "content";
                query = query.substring(8); // 'content:'를 제거
            }
            trashList = service.TrashsearchMails(emplId, query, type, startRow, endRow);
            totalRecords = service.TrashcountSearchMails(emplId, query, type);
        } else {
            // 검색 쿼리가 없는 경우 전체 목록을 가져옴
            trashList = service.trashListPaged(emplId, startRow, endRow);
            totalRecords = service.cntTrashList(emplId);
        }
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

        // 페이징 계산 로직 수정
        int visiblePages = 5; // 보여줄 페이지 수
        int startPage = Math.max(1, page - visiblePages / 2);
        int endPage = Math.min(totalPages, startPage + visiblePages - 1);

        // 만약 endPage가 visiblePages보다 작으면 startPage 조정
        if (endPage - startPage + 1 < visiblePages) {
            startPage = Math.max(1, endPage - visiblePages + 1);
        }
        int count = service.reCount(emplId);
        // 디버깅 정보 추가
        log.info("Total Records: " + totalRecords);
        log.info("Total Pages: " + totalPages);
        log.info("Current Page: " + page);
        log.info("Start Page: " + startPage);
        log.info("End Page: " + endPage);
        
        model.addAttribute("listCount", totalRecords);
        model.addAttribute("count", count);
        model.addAttribute("trashList", trashList);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("startRow", startRow);
        model.addAttribute("endRow", endRow);
        model.addAttribute("query", query); // 검색 쿼리 추가
        
        return "egg/email/trashList";
    }


    @PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
    @RequestMapping(value = "/mineList", method = RequestMethod.GET)
    public String mineList(
        @RequestParam(name = "page", defaultValue = "1") int page, 
        @RequestParam(name = "query", required = false) String query,
        Model model, 
        HttpServletRequest request) {

        HttpSession session = request.getSession();
        CustomEmployeeVO emplInfo = (CustomEmployeeVO) session.getAttribute("emplInfo");
        String emplId = emplInfo.getEmplId();

        int pageSize = 15; // 한 페이지에 보여줄 레코드 수
        int startRow = (page - 1) * pageSize + 1;
        int endRow = page * pageSize;

        List<MailSendVO> mineList;
        int totalRecords;
        if (query != null && !query.isEmpty()) {
            // 검색 쿼리가 있는 경우 검색 결과를 가져옴
            String type = "title"; // 기본 검색 타입을 title로 설정
            if (query.startsWith("content:")) {
                type = "content";
                query = query.substring(8); // 'content:'를 제거
            }
            mineList = service.MinesearchMails(emplId, query, type, startRow, endRow);
            totalRecords = service.MinecountSearchMails(emplId, query, type);
        } else {
            // 검색 쿼리가 없는 경우 전체 목록을 가져옴
            mineList = service.mineListPaged(emplId, startRow, endRow);
            totalRecords = service.cntMineList(emplId);
        }
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

        // 페이징 계산 로직 수정
        int visiblePages = 5; // 보여줄 페이지 수
        int startPage = Math.max(1, page - visiblePages / 2);
        int endPage = Math.min(totalPages, startPage + visiblePages - 1);

        // 만약 endPage가 visiblePages보다 작으면 startPage 조정
        if (endPage - startPage + 1 < visiblePages) {
            startPage = Math.max(1, endPage - visiblePages + 1);
        }
        int count = service.reCount(emplId);
        // 디버깅 정보 추가
        log.info("Total Records: " + totalRecords);
        log.info("Total Pages: " + totalPages);
        log.info("Current Page: " + page);
        log.info("Start Page: " + startPage);
        log.info("End Page: " + endPage);

        model.addAttribute("listCount", totalRecords);
        model.addAttribute("count", count);
        model.addAttribute("mineList", mineList);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("startRow", startRow);
        model.addAttribute("endRow", endRow);
        model.addAttribute("query", query); // 검색 쿼리 추가

        return "egg/email/mineList";
    }

    @PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
    @RequestMapping(value = "/mailTest", method = RequestMethod.GET)
    public String testList(Model model) {
        return "egg/email/test";
    }
    @PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
    @RequestMapping(value = "/read", method = RequestMethod.GET)
    public String testRead(HttpServletRequest request,Model model) {
        HttpSession session = request.getSession();
        CustomEmployeeVO emplInfo = (CustomEmployeeVO) session.getAttribute("emplInfo");
        String emplId = emplInfo.getEmplId();
        
        int listCount = service.reCount(emplId); 
        model.addAttribute("listCount", listCount);
        return "egg/email/mailRead";
    }
    @PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
    @RequestMapping(value = "/compose", method = RequestMethod.GET)
    public String composeMail(HttpServletRequest request, Model model) {
        HttpSession session = request.getSession();
        CustomEmployeeVO emplInfo = (CustomEmployeeVO) session.getAttribute("emplInfo");
        String emplId = emplInfo.getEmplId();
        
        int listCount = service.reCount(emplId); 
        model.addAttribute("listCount", listCount);
        List<EmployeeVO> reference = service.emplList();
        model.addAttribute("reference", reference);
        return "egg/email/composeMail";
    }

    @PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
    @PostMapping("/upload")
    @ResponseBody
    public Map<String, Object> uploadFiles(MultipartFile[] attachments) {
        Map<String, Object> response = new HashMap<>();
        try {
            int fileGroupNo = service.saveFiles(attachments);
            response.put("success", true);
            response.put("fileGroupNo", fileGroupNo);
        } catch (Exception e) {
            log.error("File upload failed", e);
            response.put("success", false);
            response.put("message", "File upload failed: " + e.getMessage());
        }
        return response;
    }
    
    @PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
    @PostMapping("/sendEmail")
    @ResponseBody
    public Map<String, Object> sendEmail(
            HttpServletRequest request,
            @RequestParam("subject") String subject,
            @RequestParam("content") String content,
            @RequestParam("recipientIds") List<String> recipientIds,
            @RequestParam("attachments") MultipartFile[] attachments,
            @RequestParam(value = "draftId", required = false) Integer draftId) {

        Map<String, Object> response = new HashMap<>();
        
        HttpSession session = request.getSession();
        CustomEmployeeVO emplInfo = (CustomEmployeeVO) session.getAttribute("emplInfo");
        String emplId = emplInfo.getEmplId();
        
        try {
        	Integer fileGroupNo = null;
        	log.info("attachments ===>{}", attachments.length );
        	if(attachments != null && attachments.length != 0) {
        		fileGroupNo = service.groupSearch();
        	}
            
            MailSendVO mailSendVO = new MailSendVO();
            mailSendVO.setEmplId(emplId); // 보낸 사람의 ID, 고정값으로 설정
            mailSendVO.setEmlTtl(subject);
            mailSendVO.setEmlCn(content);
            mailSendVO.setEmlDt(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date())); // 날짜 형식을 맞춤
            mailSendVO.setEmlDrfYn("N");
            mailSendVO.setMscCode("MSC001");
            mailSendVO.setFileGroupNo(fileGroupNo);

            int emlNo = service.insertEmailSend(mailSendVO);

            for (String recipientId : recipientIds) {
            	
                MailReVO mailReVO = new MailReVO();
                mailReVO.setEmplId(recipientId);
                mailReVO.setEmlNo(emlNo); // 삽입된 이메일의 키 값 사용

                if (recipientId.equals(emplId)) {
                    mailReVO.setMscCode("MSC003"); // 자신에게 보내는 경우
                } else {
                    mailReVO.setMscCode("MSC001"); // 다른 사람에게 보내는 경우
                }

                mailReVO.setMreYn("N");
                service.insertMailRe(mailReVO);
                response.put("emlNo", emlNo);
            }

            // 임시 저장된 이메일 삭제
            if (draftId != null) {
                service.deleteDraft(draftId);
            }

            response.put("emlSenderName", emplInfo.getEmplNm());
            response.put("success", true);
        } catch (Exception e) {
            log.error("보내기실패로그", e);
            response.put("success", false);
            response.put("message", "왜 그럴까요? " + e.getMessage());
        }

        return response;
    }
    
    @PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
    @RequestMapping(value = "/deleteDrfMails", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> deleteDrfMails(@RequestBody Map<String, List<Integer>> request) {
        List<Integer> draftIds = request.get("draftIds");
        boolean success = true;
        String errorMessage = "";

        // draftIds 로그 출력
        log.info("Received draftIds: " + draftIds);

        // draftIds가 null인지 확인하고 로그에 출력
        if (draftIds == null || draftIds.isEmpty()) {
            log.error("draftIds is null or empty");
            success = false;
            errorMessage = "No draftIds provided";
        } else {
            try {
                for (Integer draftId : draftIds) {
                    if (draftId != null) {
                        log.info("Deleting draft with ID: " + draftId);
                        service.deleteDraft(draftId);
                    } else {
                        log.warn("Encountered null draftId in the list");
                    }
                }
            } catch (Exception e) {
                log.error("Error while deleting drafts: " + e.getMessage(), e);
                success = false;
                errorMessage = e.getMessage();
            }
        }

        Map<String, Object> response = new HashMap<>();
        response.put("success", success);
        if (!success) {
            response.put("message", errorMessage);
        }

        return response;
    }





    @PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
    @PostMapping("/saveDraft")
    @ResponseBody
    public Map<String, Object> saveDraft(
            HttpServletRequest request ,
            @RequestParam("subject") String subject,
            @RequestParam("content") String content) {

        Map<String, Object> response = new HashMap<>();
        
        HttpSession session = request.getSession();
        CustomEmployeeVO emplInfo = (CustomEmployeeVO) session.getAttribute("emplInfo");
        String emplId = emplInfo.getEmplId();
        
        try {
            MailSendVO mailSendVO = new MailSendVO();
            mailSendVO.setEmplId(emplId); // 보낸 사람의 ID, 고정값으로 설정
            mailSendVO.setEmlTtl(subject);
            mailSendVO.setEmlCn(content);
            mailSendVO.setEmlDt(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date())); // 날짜 형식을 맞춤
            mailSendVO.setEmlDrfYn("Y");
            mailSendVO.setMscCode("MSC001");

            service.insertEmailSend(mailSendVO);

            response.put("success", true);
        } catch (Exception e) {
            log.error("임시저장실패로그", e);
            response.put("success", false);
            response.put("message", "임시저장 실패: " + e.getMessage());
        }

        return response;
    }
    
    @PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
    @RequestMapping(value = "/markStar", method = RequestMethod.POST)
    @ResponseBody
    public String markStar(@RequestBody Map<String, List<Integer>> requestData) {
        List<Integer> mreNos = requestData.get("mreNos");
        for (int mreNo : mreNos) {
            log.info("수신메일번호: " + mreNo);
            service.updateMscCode(mreNo, "MSC004");
        }
        return "success";
    }



    
    @PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
    @RequestMapping(value = "/cancelStart", method = RequestMethod.POST)
    @ResponseBody
    public String cancelStart(@RequestBody Map<String, List<Integer>> requestData) {
        List<Integer> mreNos = requestData.get("mreNos");
        for (int mreNo : mreNos) {
            log.info("수신메일번호: " + mreNo);
            service.updateMscCode(mreNo, "MSC001");
        }
        return "success";
    }
    
    @PostMapping("/deleteMail")
    @ResponseBody
    public String deleteMail(@RequestBody Map<String, List<Integer>> requestData) {
        List<Integer> mreNos = requestData.get("mreNos");
        for (int mreNo : mreNos) {
            log.info("Deleting mail with mreNo: " + mreNo);
            service.updateMscCode(mreNo, "MSC002");
        }
        return "success";
    }
    
    @PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
    @RequestMapping(value = "/deleteCancel", method = RequestMethod.POST)
    @ResponseBody
    public String deleteCancel(@RequestBody Map<String, List<Integer>> requestData) {
        List<Integer> mreNos = requestData.get("mreNos");
        for (int mreNo : mreNos) {
            log.info("수신메일번호: " + mreNo);
            service.updateMscCode(mreNo, "MSC001");
        }
        return "success";
    }
    
    @PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
    @PostMapping("/archiveMail")
    @ResponseBody
    public String archiveMail(@RequestBody Map<String, List<Integer>> requestData) {
        List<Integer> emlNos = requestData.get("emlNos");
        log.info("메일번호"+emlNos);
        for (int emlNo : emlNos) {
            service.archiveMail(emlNo);
        }
        return "success";
    }


    
    @PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
    @RequestMapping(value = "/download", method = RequestMethod.GET)
    public void downloadFile(@RequestParam("fileGroupNo") int fileGroupNo, @RequestParam("fileNo") int fileNo, HttpServletResponse response) {
        try {
            CustomFileVO file = service.getFile(fileGroupNo, fileNo);
            Path filePath = Paths.get(file.getFilePath());

            // 파일 이름 인코딩
            String encodedFileName = java.net.URLEncoder.encode(file.getFileOrgnlNm(), "UTF-8").replaceAll("\\+", "%20");
            response.setContentType(file.getFileType());
            response.setHeader("Content-Disposition", "attachment; filename=\"" + encodedFileName + "\"");
            response.setCharacterEncoding("UTF-8");

            Files.copy(filePath, response.getOutputStream());
            response.getOutputStream().flush();
        } catch (IOException e) { 
            log.error("File download error", e);
        }
    }
    
    @PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
    @RequestMapping(value = "/sendDetail", method = RequestMethod.GET)
    public String sendDetail(HttpServletRequest request,@RequestParam("emlNo") int emlNo, Model model) {
        MailSendVO mail = service.getsendDetail(emlNo);
        model.addAttribute("mail", mail);
        HttpSession session = request.getSession();
        CustomEmployeeVO emplInfo = (CustomEmployeeVO) session.getAttribute("emplInfo");
        String emplId = emplInfo.getEmplId();
        int listCount = service.reCount(emplId); 
        model.addAttribute("listCount", listCount);
        return "egg/email/sendRead";
    }
    
    @PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
    @RequestMapping(value = "/drfDetail", method = RequestMethod.GET)
    public String drfDetail(HttpServletRequest request,@RequestParam("emlNo") int emlNo, Model model) {
        HttpSession session = request.getSession();
        CustomEmployeeVO emplInfo = (CustomEmployeeVO) session.getAttribute("emplInfo");
        String emplId = emplInfo.getEmplId();
        MailSendVO mail = service.getsendDetail(emlNo);
        model.addAttribute("mail", mail);
        int listCount = service.reCount(emplId); 
        model.addAttribute("listCount", listCount);
        return "egg/email/drfRead";
    }
    @PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
    @RequestMapping(value = "/detail", method = RequestMethod.GET)
    public String mailDetail(HttpServletRequest request, @RequestParam("mreNo") int mreNo, Model model) {
        MailSendVO mail = service.getMailDetail(mreNo);
        model.addAttribute("mail", mail);
        HttpSession session = request.getSession();
        CustomEmployeeVO emplInfo = (CustomEmployeeVO) session.getAttribute("emplInfo");
        String emplId = emplInfo.getEmplId();

        if (mail.getFileGroupNo() != null && mail.getFileGroupNo() != 0) {
            List<CustomFileVO> files = service.getFilesByGroupNo(mail.getFileGroupNo());
            model.addAttribute("files", files);
            log.info("파일있나?" + mail.getFileGroupNo());
            log.info("files?" + files);
        } else {
            model.addAttribute("files", Collections.emptyList()); // 파일 목록이 없을 경우 빈 리스트 설정
            log.info("파일이 없나?");
        }

        int listCount = service.reCount(emplId); 
        model.addAttribute("listCount", listCount);
        return "egg/email/mailRead";
    }

    
    @PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
    @RequestMapping(value = "/trashDetail", method = RequestMethod.GET)
    public String trashDetail(HttpServletRequest request,@RequestParam("emlNo") int emlNo,@RequestParam("mreNo") int mreNo, Model model) {
        MailSendVO mail = service.getsendDetail(emlNo);
        HttpSession session = request.getSession();
        CustomEmployeeVO emplInfo = (CustomEmployeeVO) session.getAttribute("emplInfo");
        String emplId = emplInfo.getEmplId();
        model.addAttribute("mail", mail);
        model.addAttribute("mreNo", mreNo);
        int listCount = service.reCount(emplId); 
        model.addAttribute("listCount", listCount);
        return "egg/email/trashRead";
    }
    
    @PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
    @RequestMapping(value = "/deletePermanently", method = RequestMethod.POST)
    @ResponseBody
    public String deleteMailPermanently(@RequestBody Map<String, List<Integer>> requestData) {
        List<Integer> mreNos = requestData.get("mreNos");
        for (int mreNo : mreNos) {
            try {
                service.deleteMailPermanently(mreNo);
            } catch (Exception e) {
                return "fail";
            }
        }
        return "success";
    }

    
    @PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
    @RequestMapping(value = "/readCheck", method = RequestMethod.POST)
    @ResponseBody
    public String readCheck(@RequestBody Map<String, Integer> requestData) {
        int mreNo = requestData.get("mreNo");
        service.readCheck(mreNo);
        return "success";
    }
    
    
    @PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
    @RequestMapping(value = "/deleteSendMail", method = RequestMethod.POST)
    @ResponseBody
    public String deleteSendMail(@RequestBody Map<String, List<Integer>> requestData) {
        List<Integer> emlNos = requestData.get("emlNos");
        for (int emlNo : emlNos) {
            service.updateEmlSendCode(emlNo, "MSC005");
        }
        return "success";
    }

    @PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
    @RequestMapping(value = "/cancelDeleteSendMail", method = RequestMethod.POST)
    @ResponseBody
    public String cancelDeleteSendMail(@RequestBody Map<String, List<Integer>> requestData) {
        List<Integer> emlNos = requestData.get("emlNos");
        for (int emlNo : emlNos) {
            service.updateEmlSendCodeAndDelYn(emlNo, "N" , "MSC001");
        }
        return "success";
    }


    
    
}
