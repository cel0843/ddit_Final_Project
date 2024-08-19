package kr.or.ddit.controller.companySchedule;

import java.time.DayOfWeek;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.service.ICompanyScheduleService;
import kr.or.ddit.vo.CompanyScheduleVO;

@Controller
@RequestMapping("/admin")
public class CompanyScheduleController {

    @Autowired
    private ICompanyScheduleService service;

    @PreAuthorize("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')")
    @RequestMapping(value = "/csmain")
    public String scheduleMain(Model model) {
        // service.summaryInfo("07") 메서드를 호출하여 스케줄 정보를 가져옴
        List<CompanyScheduleVO> csVOList = service.summaryInfo("07");

        // 요약 정보를 저장할 리스트
        List<String> summuryInfo = new ArrayList<>();

        // 날짜 문자열을 LocalDateTime으로 파싱하기 위한 포맷터 생성
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

        // 각 스케줄 정보를 처리하여 요약 정보 생성
        for (int i = 0; i < csVOList.size(); i++) {
            String schdlNm = csVOList.get(i).getSchdlNm();
            String schdlBgngDtStr = csVOList.get(i).getSchdlBgngDt();
            String schdlEndDtStr = csVOList.get(i).getSchdlEndDt();

            // 문자열을 LocalDateTime으로 파싱
            LocalDateTime schdlBgngDt = LocalDateTime.parse(schdlBgngDtStr, formatter);
            LocalDateTime schdlEndDt = LocalDateTime.parse(schdlEndDtStr, formatter);

            // 시작 날짜의 요일 가져오기
            DayOfWeek startDayOfWeek = schdlBgngDt.getDayOfWeek();
            DayOfWeek endDayOfWeek = schdlEndDt.getDayOfWeek();

            // 요일을 한글 약어로 변환
            String startDayOfWeekKorean = startDayOfWeek.getDisplayName(java.time.format.TextStyle.SHORT, Locale.KOREAN);
            String endDayOfWeekKorean = endDayOfWeek.getDisplayName(java.time.format.TextStyle.SHORT, Locale.KOREAN);

            // 최종 문자열 생성
            String result;
            if (schdlBgngDt.toLocalDate().equals(schdlEndDt.toLocalDate())) {
                result = String.format("%d(%s) : %s", schdlBgngDt.getDayOfMonth(), startDayOfWeekKorean, schdlNm);
            } else {
                result = String.format("%d(%s)~%d(%s) : %s",
                        schdlBgngDt.getDayOfMonth(), startDayOfWeekKorean,
                        schdlEndDt.getDayOfMonth(), endDayOfWeekKorean,
                        schdlNm);
            }

            summuryInfo.add(result);
        }

        // 생성된 요약 정보를 모델에 추가
        model.addAttribute("summuryInfo", summuryInfo);

        // 반환할 뷰의 이름
        return "admin/companySchedule";
    }
    
    @RequestMapping(value = "/ajax/summuryInfo", method=RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<List<String>> summuryCSList(String month) {

    	 List<CompanyScheduleVO> csVOList = service.summaryInfo(month);

         // 요약 정보를 저장할 리스트
         List<String> summuryInfo = new ArrayList<>();

         // 날짜 문자열을 LocalDateTime으로 파싱하기 위한 포맷터 생성
         DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

         // 각 스케줄 정보를 처리하여 요약 정보 생성
         for (int i = 0; i < csVOList.size(); i++) {
             String schdlNm = csVOList.get(i).getSchdlNm();
             String schdlBgngDtStr = csVOList.get(i).getSchdlBgngDt();
             String schdlEndDtStr = csVOList.get(i).getSchdlEndDt();

             // 문자열을 LocalDateTime으로 파싱
             LocalDateTime schdlBgngDt = LocalDateTime.parse(schdlBgngDtStr, formatter);
             LocalDateTime schdlEndDt = LocalDateTime.parse(schdlEndDtStr, formatter);

             // 시작 날짜의 요일 가져오기
             DayOfWeek startDayOfWeek = schdlBgngDt.getDayOfWeek();
             DayOfWeek endDayOfWeek = schdlEndDt.getDayOfWeek();

             // 요일을 한글 약어로 변환
             String startDayOfWeekKorean = startDayOfWeek.getDisplayName(java.time.format.TextStyle.SHORT, Locale.KOREAN);
             String endDayOfWeekKorean = endDayOfWeek.getDisplayName(java.time.format.TextStyle.SHORT, Locale.KOREAN);

             // 최종 문자열 생성
             String result;
             if (schdlBgngDt.toLocalDate().equals(schdlEndDt.toLocalDate())) {
                 result = String.format("%d(%s) : %s", schdlBgngDt.getDayOfMonth(), startDayOfWeekKorean, schdlNm);
             } else {
                 result = String.format("%d(%s)~%d(%s) : %s",
                         schdlBgngDt.getDayOfMonth(), startDayOfWeekKorean,
                         schdlEndDt.getDayOfMonth(), endDayOfWeekKorean,
                         schdlNm);
             }

             summuryInfo.add(result);
         }
         
    	return ResponseEntity.ok(summuryInfo);
    }
    
    @GetMapping("/ajax/selectCSList")
    @ResponseBody
    public ResponseEntity<List<CompanyScheduleVO>> selectCSList() {
        List<CompanyScheduleVO> csVOList = service.selectCSList();
        return ResponseEntity.ok(csVOList);
    }

    @PreAuthorize("hasAnyRole('ROLE_ADMIN')")
    @PostMapping("/ajax/insertSchedul")
    @ResponseBody
    public ResponseEntity<String> insertSchedul(@RequestBody CompanyScheduleVO schedul) {
        service.insertSchedul(schedul);
        return ResponseEntity.ok("Schedule inserted successfully");
    }

    @PreAuthorize("hasAnyRole('ROLE_ADMIN')")
    @PostMapping("/ajax/updateSchedul")
    @ResponseBody
    public ResponseEntity<String> updateSchedul(@RequestBody CompanyScheduleVO schedul) {
        service.updateSchedul(schedul);
        return ResponseEntity.ok("Schedule updated successfully");
    }

    @PreAuthorize("hasAnyRole('ROLE_ADMIN')")
    @PostMapping("/ajax/updateDateSchedul")
    @ResponseBody
    public ResponseEntity<String> updateDateSchedul(@RequestBody CompanyScheduleVO schedul) {
        service.updateDateSchedul(schedul);
        return ResponseEntity.ok("Schedule date updated successfully");
    }

    @PreAuthorize("hasAnyRole('ROLE_ADMIN')")
    @PostMapping("/ajax/deleteSchedul")
    @ResponseBody
    public ResponseEntity<String> deleteSchedul(@RequestBody CompanyScheduleVO schedul) {
        service.deleteSchedul(schedul.getSchdlNo());
        return ResponseEntity.ok("Schedule deleted successfully");
    }
}
