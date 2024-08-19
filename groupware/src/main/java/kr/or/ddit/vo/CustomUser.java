package kr.or.ddit.vo;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

public class CustomUser extends User {

	private CustomEmployeeVO customEmpl;
	
	public CustomUser(String username, String password, Collection<? extends GrantedAuthority> aythorities) {
		super(username, password, aythorities);
	}
	
	public CustomUser(CustomEmployeeVO customEmplVO) {
		// Java 스트림을 사용한 경우 (람다표현식)
		// - 자바 버전 8부터 추가된 기능
		// map : 컬렉션 (List, Map, Set 등), 배열 등의 설정되어 있는 각 타입의 값들을 하나씩 참조하여 람다식으로 반복 처리할 수 있게 해준다.
		// collection : Stream()을 돌려 발생되는 데이터를 가공 처리하고 원하는 형태의 자료형으로 변화을 돕는다.
		// 			회원정보 안에 들어있는 역할명들을 컬렉션 형태의 스트림으로 만들어서 보내준다.
		super(customEmplVO.getEmplId(), customEmplVO.getEmplPswd(), 
				customEmplVO.getAuthList().stream().map(
						auth -> new SimpleGrantedAuthority(auth.getAuth())).collect(Collectors.toList()));
		this.customEmpl = customEmplVO;
	}

	public CustomEmployeeVO getCustomEmpl() {
		return customEmpl;
	}

	public void setCustomEmpl(CustomEmployeeVO customEmpl) {
		this.customEmpl = customEmpl;
	}
	
}
