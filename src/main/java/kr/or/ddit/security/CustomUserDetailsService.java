package kr.or.ddit.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import kr.or.ddit.mem.mapper.MemMapper;
import kr.or.ddit.vo.MemVO;

public class CustomUserDetailsService implements UserDetailsService{
	
	private final MemMapper memMapper;
	
	@Autowired
	private CustomUserDetailsService(MemMapper memMapper) {
		this.memMapper = memMapper;
	}
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		MemVO memVO = new MemVO();
		memVO.setMemId(username);
		memVO = memMapper.memLogin(memVO);
		
		return memVO==null?null:new CustomUser(memVO);
	}
}
