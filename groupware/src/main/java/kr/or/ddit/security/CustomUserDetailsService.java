package kr.or.ddit.security;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import kr.or.ddit.mapper.ILogInfoMapper;
import kr.or.ddit.vo.CustomEmployeeVO;
import kr.or.ddit.vo.CustomUser;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomUserDetailsService implements UserDetailsService {

	@Inject
	private ILogInfoMapper logInfoMapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		log.info("# loadUserByUsername() 실행...!");
		log.info("# loadUserByUsername() username : " + username);
		
		CustomEmployeeVO empVO;
		try {
			empVO = logInfoMapper.readByEmplInfo(username);
			log.info("query by member mapper : " + empVO);
			
			return empVO == null? null : new CustomUser(empVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}

}
