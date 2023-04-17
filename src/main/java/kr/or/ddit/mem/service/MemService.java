package kr.or.ddit.mem.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.BoardCommentVO;
import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.CommonCodeVO;
import kr.or.ddit.vo.EnterpriseVO;
import kr.or.ddit.vo.InternshipScheduleVO;
import kr.or.ddit.vo.MemVO;
import kr.or.ddit.vo.ResumeVO;
import kr.or.ddit.vo.VipVO;

public interface MemService {

	// 일반 회원 가입
	int memJoin(MemVO memVO);

	// 기업 회원 가입
	int entJoinPost(EnterpriseVO corpVO);

	// 회원 존재 여부 체크(count)
	int existMem(String memId);

	// 카카오 로그인
	void kakaoLogin(MemVO memVO);

	// 회원 프로필 및 직업 조회
	MemVO memSearch(String memId);

	// 내 멤버십상태 조회
	List<VipVO> myMembership(String memId);

	// 내 게시글 조회
	List<BoardVO> myBoardList(String memId);

	// 페이징 작업을 위한 총 게시물 갯수
	int getTotal(Map<String, Object> map);

	// 내 댓글 조회
	List<BoardCommentVO> myCmntList(String memId);

	// 내 지원현황 조회
	List<Map<String, String>> getMyEmployStatus();

	//
	List<Map<String, String>> getMyEmployStatusInfo(String emplClfcNo);

	// 회원정보 업데이트
	int updateMem(Map<String, String> param);

	// 내 이력서 조회
	List<ResumeVO> getMyResume();

	// 공통코드 조회
	List<CommonCodeVO> getCommonCode(Map<String, String> map);

	// 이력서 작성
	int createResume(ResumeVO resumeVO);

	// 카카오 로그인시 추가정보 등록
	void insertInformation(MemVO memVO);

	// 비밀번호 재설정
	int updatePass(Map<String, String> map);

	// 이력서 수정
	void updateResume(ResumeVO resumeVO);

	// 이력서 상세내역 조회
	ResumeVO resumeDetail(ResumeVO resumeVO);

	// 다음 vipNo 가져오기
	public String getNextVipNo();

	// vip insert
	public int insertVip(VipVO vipVO);

	// 이력서 삭제
	int deleteResume(ResumeVO resumeVO);

	int setRprsRsm(String rsmNo);

	List<Map<String, String>> getOfferList();

	List<Map<String, String>> getLikeList();

	List<Map<String, String>> getViewList();

	void acceptMatchingOffer(String mtchOfferNo);

	List<Map<String, String>> getSearchList(Map<String, String> map);

	List<CommonCodeVO> getMemJob(String cmcdClfc);

	void profileUpdate(MemVO memVO);

}