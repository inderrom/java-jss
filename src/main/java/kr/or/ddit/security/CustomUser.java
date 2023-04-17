package kr.or.ddit.security;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import kr.or.ddit.vo.MemAuthVO;
import kr.or.ddit.vo.MemVO;

// User : 스프링 시큐리티가 제공하고 있는 사용자 정보 클래스
public class CustomUser extends User{
	// 이 memVO 객체는 JSP에서 사용할 수 있음
	private MemVO memVO;
	
	public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}
	
	// MemVO 타입의 객체 memVO를 스프링 시큐리티에서 제공해주고 있는 UsersDetails 타입으로 변환
	// 스프링 시큐리티에 회원정보를 전달해서 스프링 시큐리티에서 관리하게 됨
	public CustomUser(MemVO memVO) {
//		super(memVO.getMemId(), memVO.getMemPass(),
//				memVO.getMemAuthList().stream()
//				.map(auth->new SimpleGrantedAuthority(auth))
//				.collect(Collectors.toList()));
		super(memVO.getMemId(), memVO.getMemPass(), getCollect(memVO));
		this.memVO = memVO;
	}
	

	public MemVO getMemVO() {
		return memVO;
	}

	public void setMemVO(MemVO memVO) {
		this.memVO = memVO;
	}
	
	public static List<SimpleGrantedAuthority> getCollect(MemVO memVO){
		List<SimpleGrantedAuthority> authorities = new ArrayList<SimpleGrantedAuthority>();
//		List<MemAuthVO> memAuthVOList = memVO.getMemAuthVOList();
		
//		for(MemAuthVO memAuthVO : memAuthVOList) {
			SimpleGrantedAuthority authority = new SimpleGrantedAuthority(memVO.getMemAuth());
			authorities.add(authority);
//		}
		
		return authorities;
	}
}
