package kr.or.ddit.matching.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.CommonCodeVO;
import kr.or.ddit.vo.ResumeVO;
import kr.or.ddit.vo.TicketVO;
import kr.or.ddit.vo.VipVO;

public interface MatchingMapper {
	// 매칭 리스트
	public List<ResumeVO>  matchingList(Map<String, String> map);

	// 전체 직군/직무 리스트
	public List<CommonCodeVO> jobList(Map<String, String> map);

	// 페이징 처리
	public int getTotal(Map<String, String> map);

	// 이력서 상세보기
	public ResumeVO resumeDetail(String rsmNo);

	// 열람권 사용시 수량 변경
	public int updateTicket(Map<String, String> map);

	// 열람권 사용시 열람한 이력서 insert
	public void insertViewResume(Map<String, String> map);

	public TicketVO searchInfo(Map<String, String> map);

	// 찜한 목록 리스트
	public List<ResumeVO> wantList(Map<String, String> map);

	// 면접 제안
	public int jobOffer(Map<String, String> map);

}
