package kr.or.ddit.controller.addressController;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.service.addressService.IAddressService;
import kr.or.ddit.vo.AddressBookVO;
import kr.or.ddit.vo.CustomEmployeeVO;
import kr.or.ddit.vo.EmployeeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("egg/address")
public class AddressTest {

    @Inject
    private IAddressService service;

    @PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
    @RequestMapping(value = "/empllist", method = RequestMethod.GET)
    public String addressTest(@RequestParam(name = "select", required = false) String select,
                              @RequestParam(name = "searchText", required = false) String searchText,
                              @RequestParam(name = "page", defaultValue = "1") int page,
                              Model model) {
        int pageSize = 10;
        int startRow = (page - 1) * pageSize + 1;
        int endRow = page * pageSize;

        List<EmployeeVO> emplList;
        int totalRecords;

        if (select == null || select.isEmpty() || searchText == null || searchText.isEmpty()) {
            // 검색 조건이 없으면 전체 리스트를 가져옴
            emplList = service.selectEmployeeAllPaged(startRow, endRow);
            totalRecords = service.countAllEmployee();
        } else {
            // 검색 조건이 있으면 검색 리스트를 가져옴
            emplList = service.searchEmployeePaged(select, searchText, startRow, endRow);
            totalRecords = service.countEmployee(select, searchText);
        }

        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);
        int startPage = Math.max(1, page - 2);
        int endPage = Math.min(totalPages, page + 2);
        model.addAttribute("tab", "empl");
        model.addAttribute("emplList", emplList);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);

        model.addAttribute("selectBoxChk", select);
        model.addAttribute("searchText", searchText);

        return "egg/address/empladdress";
    }



    // 외부인원 전체 리스트 페이징 처리
    @PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
    @RequestMapping(value = "/adresclist", method = RequestMethod.GET)
    public String addressList(@RequestParam(name = "page", defaultValue = "1") int page, Model model) {
        int pageSize = 10;
        int startRow = (page - 1) * pageSize + 1;
        int endRow = page * pageSize;

        List<AddressBookVO> adresList = service.selectAllPaged(startRow, endRow);
        for (int j = 0; j < adresList.size(); j++) {
        	System.out.println("adresList 비고록 : "+adresList.get(j).getAdresRmrk());
		}
        
        int totalRecords = service.countAll();
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);
        int startPage = Math.max(1, page - 2);
        int endPage = Math.min(totalPages, page + 2);

        model.addAttribute("tab", "adres");
        model.addAttribute("adresList", adresList);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);

        return "egg/address/coaddress";
    }

    // 사내인원 주소록 상세보기
    @PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
    @RequestMapping(value = "/adresread", method = RequestMethod.GET)
    public @ResponseBody Map<String, Object> adresRead(@RequestParam("emplId") String emplId) throws Exception {
        EmployeeVO employee = service.adresRead(emplId);
        
        // 날짜 변환 로직
        String originalDateStr = employee.getJncmpYmd();
        SimpleDateFormat originalFormat = new SimpleDateFormat("yyyyMMdd");
        SimpleDateFormat targetFormat = new SimpleDateFormat("yyyy년 MM월 dd일");
        String formattedDate = null;
        try {
            Date date = originalFormat.parse(originalDateStr);
            formattedDate = targetFormat.format(date);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        
        Map<String, Object> result = new HashMap<>();
        result.put("employee", employee);
        result.put("formattedDate", formattedDate);
        return result;
    }

    // 외부인원 주소록 상세보기
    @PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
    @RequestMapping(value = "/coread", method = RequestMethod.GET)
    public @ResponseBody Map<String, Object> coRead(@RequestParam("adresNo") int adresNo) throws Exception {
        AddressBookVO adresBookVO = service.coRead(adresNo);
        Map<String, Object> result = new HashMap<>();
        result.put("adresBookVO", adresBookVO);
        return result;
    }

    // 외부인원 등록/수정 처리
    @PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public String coRegister(HttpServletRequest request, AddressBookVO adresBookVO, @RequestParam("status") String status, Model model) {
        HttpSession session = request.getSession();
        CustomEmployeeVO emplInfo = (CustomEmployeeVO) session.getAttribute("emplInfo");
        String emplId = emplInfo.getEmplId();
        
		/*
		 * System.out.println("@@@@@"+adresBookVO.getAdresNm());
		 * System.out.println("비고록1"+adresBookVO.getAdresRmrk());
		 */
        if ("u".equals(status)) {
            service.update(adresBookVO);
            System.out.println("@@@@@12"+adresBookVO.getAdresNm());
            System.out.println("비고록2"+adresBookVO.getAdresRmrk());
        } else {
        	adresBookVO.setEmplId(emplId);
            service.register(adresBookVO);
            
        }
        return "redirect:/egg/address/adresclist";
    }

    // 외부인원 주소록에서 삭제
    @PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
    @RequestMapping(value = "/coremove", method = RequestMethod.POST)
    public String coDelete(int adresNo, Model model) {
        service.codelete(adresNo);
        return "redirect:/egg/address/adresclist";
    }

    @PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
    @RequestMapping(value = "/search", method = RequestMethod.GET)
    public String coSearch(@RequestParam(name = "select", required = false) String select,
                           @RequestParam(name = "searchText", required = false) String searchText,
                           @RequestParam(name = "page", defaultValue = "1") int page,
                           Model model) {
        int pageSize = 10;
        int startRow = (page - 1) * pageSize + 1;
        int endRow = page * pageSize;

        List<AddressBookVO> adresList = service.searchAddressesPaged(select, searchText, startRow, endRow);
        int totalRecords = service.countAddresses(select, searchText);

        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);
        int startPage = Math.max(1, page - 2);
        int endPage = Math.min(totalPages, page + 2);

        model.addAttribute("adresList", adresList);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);

        model.addAttribute("selectBoxChk", select);
        model.addAttribute("searchText", searchText);

        return "egg/address/coaddress";
    }
    
    @PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
    @RequestMapping(value = "/testtest" , method = RequestMethod.GET)
    public String test02() {
    	return "egg/address/testtest";
    }


}