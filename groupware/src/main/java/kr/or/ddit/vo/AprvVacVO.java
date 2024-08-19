package kr.or.ddit.vo;
import lombok.Data;

@Data
public class AprvVacVO {
	private int formSeNo;
	private String emplId;
	private String hdCtrDt;
	private String hdBgngHr;
	private String hdEndHr;
	private String hdReson;
	private String hdCd;
	private int aprvId;
	
	//---휴가 구분
	private String formHdfSe;		//연차 반차 구분 H:연차, D:반차
	private double formHdfDdctn;	//차감 수
	private int workingDays;
	private double deductedDays;
	
	
    
	







}                          
