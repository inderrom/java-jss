package kr.or.ddit.matching.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.preauth.PreAuthenticatedAuthenticationToken;
import org.springframework.stereotype.Service;

import kr.or.ddit.matching.mapper.MatchingMapper;
import kr.or.ddit.matching.service.MatchingService;
import kr.or.ddit.security.CustomUserDetailsService;
import kr.or.ddit.vo.CommonCodeVO;
import kr.or.ddit.vo.ResumeVO;
import kr.or.ddit.vo.TicketVO;
import kr.or.ddit.vo.TicketViewResumeVO;
import kr.or.ddit.vo.VipVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MatchingServiceImpl implements MatchingService {

	@Autowired
	MatchingMapper matchingMapper;
	@Autowired
	CustomUserDetailsService customUserDetailsService;

	private String getUserName() {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails) principal;
		return userDetails.getUsername();
	}

	private void setUserDetails() {
		Authentication oldAuth = SecurityContextHolder.getContext().getAuthentication();
		Authentication newAuth = new PreAuthenticatedAuthenticationToken(
				customUserDetailsService.loadUserByUsername(this.getUserName()), oldAuth.getCredentials(), oldAuth.getAuthorities());
		SecurityContextHolder.getContext().setAuthentication(newAuth);
	}

	// 매칭 목록 리스트 (전체)
	@Override
	public List<ResumeVO> matchingList(Map<String, String> map) {
		return this.matchingMapper.matchingList(map);
	}

	// 전체 행의 수 가져오기
	@Override
	public int getTotal(Map<String, String> map) {
		return this.matchingMapper.getTotal(map);
	}
	// 직무 가져오기
	@Override
	public List<CommonCodeVO> jobList(Map<String, String> map) {
		return this.matchingMapper.jobList(map);
	}

	// 이력서 상세보기
	@Override
	public ResumeVO resumeDetail(Map<String, String> map) {
		log.debug("resumeDetail 시작");

		TicketVO ticketVO = new TicketVO();
		int result = 0;

		if (map.containsKey("vipNo")) {
			ticketVO = this.matchingMapper.searchInfo(map);
			result = this.matchingMapper.updateTicket(map);
			if(result > 0) {
				map.put("tcktNo", ticketVO.getTcktNo());
				this.matchingMapper.insertViewResume(map);
			}
		}

		this.setUserDetails();
		log.debug("resumeDetail rsmNo {}:", map.get("rsmNo"));
		return this.matchingMapper.resumeDetail(map.get("rsmNo"));
	}

	// 찜한 목록 리스트
	@Override
	public List<ResumeVO> wantList(Map<String, String> map) {
		return this.matchingMapper.wantList(map);
	}

	@Override
	public int jobOffer(Map<String, String> map) {
		return this.matchingMapper.jobOffer(map);
	}


}
