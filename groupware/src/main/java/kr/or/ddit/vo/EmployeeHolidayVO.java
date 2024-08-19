package kr.or.ddit.vo;

import lombok.Data;

@Data
public class EmployeeHolidayVO {
	private String birthNo;
    private String emplId;
    private int hdSeNo;
    private int total;
    private double useCnt;
    private double leftCnt;
    private int ocrnYr;
}
