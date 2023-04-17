package kr.or.ddit.matching.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.CommonCodeVO;
import kr.or.ddit.vo.ResumeVO;
import kr.or.ddit.vo.TicketVO;
import kr.or.ddit.vo.VipVO;

public interface MatchingService {

	// 매칭된 이력서 리스트 (전체)
	public List<ResumeVO> matchingList(Map<String, String> map);

	// 전체 직군/직무 리스트
	public List<CommonCodeVO> jobList(Map<String, String> map);

	// 페이징
	public int getTotal(Map<String, String> map);

	// 이력서 상세보기
	public ResumeVO resumeDetail(Map<String, String> map);

	// 찜한 목록 리스트
	public List<ResumeVO> wantList(Map<String, String> map);

	// 면접 제안
	public int jobOffer(Map<String, String> map);


}
