package kr.or.ddit.vo;


import lombok.Data;

@Data
public class AddressBookVO {
	
	private String emplId;          //사원아디
	private String adresNm;         //외부인원이름
	private String adresTelno;      //외부인원연락처
	private String adresCoNm;       //외부인원 회사명
	private String adresJbttl;      //외부인원 직책
	private String adresEml;        //외부인원 메일
	private String adresRmrk;       //외부인원 등록시 비고 사항
	private Integer adresNo;            //기본키
}
