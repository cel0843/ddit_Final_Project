package kr.or.ddit.vo;

import lombok.Data;

@Data
public class NVO{
	private String v;
	private String f;
	
	public NVO(String v, String f) {
		this.v = v;
		this.f = f;
	}
	
}