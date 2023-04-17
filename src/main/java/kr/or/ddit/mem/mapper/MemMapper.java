package kr.or.ddit.mem.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.AcademicBackgroundVO;
import kr.or.ddit.vo.AchievementVO;
import kr.or.ddit.vo.AwardsVO;
import kr.or.ddit.vo.BoardCommentVO;
import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.CareerVO;
import kr.or.ddit.vo.CommonCodeVO;
import kr.or.ddit.vo.EnterpriseVO;
import kr.or.ddit.vo.LanguageScoreVO;
import kr.or.ddit.vo.LanguageVO;
import kr.or.ddit.vo.MemAuthVO;
import kr.or.ddit.vo.MemVO;
import kr.or.ddit.vo.MySkillVO;
import kr.or.ddit.vo.ResumeVO;
import kr.or.ddit.vo.TicketVO;
import kr.or.ddit.vo.VipVO;

public interface MemMapper {

	// 회원 로그인
	MemVO memLogin(MemVO memVO);

	// 일반 회원 가입
	int memJoin(MemVO memVO);

	// 기업 회원 가입
	int entJoinPost(EnterpriseVO coperationVO);

	// 회원 권한 부여
	int grantMemAuth(MemAuthVO memAuthVO);

	// 회원 존재 여부 체크(count)
	MemVO existMem(String memId111);

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
	List<Map<String, String>> getMyEmployStatus(MemVO memVO);

	// 회원정보 업데이트
	int updateMem(Map<String, String> param);

	// 내 이력서 조회
	List<ResumeVO> getMyResume(String memId);

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

	/** 이력서 정보 입력 시작 */
	void insertAcademicBackground(List<AcademicBackgroundVO> academicList);

	void insertCareer(CareerVO careerVO);

	void insertAchievement(List<AchievementVO> achievementVOList);

	void insertMySkill(List<MySkillVO> mySkillList);

	void insertLanguage(List<LanguageVO> languageVOList);

	void insertLanguageScore(List<LanguageScoreVO> languageScoreVOList);

	void insertAwards(List<AwardsVO> awardsVOList);
	/** 이력서 정보 입력 끝 */

	// 이력서 상세내역 조회
	ResumeVO resumeDetail(ResumeVO resumeVO);

	void deleteResumeData(Map<String, String> map);

	// 다음 vipNo 가져오기
	public String getNextVipNo();

	// vip insert
	public int insertVip(VipVO vipVO);

	void insertTicket(TicketVO ticketVO);

	// 이력서 삭제
	int deleteResume(ResumeVO resumeVO);

	// 대표이력서 설정
	int setRprsRsm(ResumeVO resumeVO);

	// 지원현황 목록
	List<Map<String, String>> getMyEmployStatusInfo(Map<String, String> map);

	List<Map<String, String>> getOfferList(String memId);

	List<Map<String, String>> getLikeList(String memId);

	List<Map<String, String>> getViewList(String memId);

	void acceptMatchingOffer(String mtchOfferNo);

	List<Map<String, String>> getSearchList(Map<String, String> map);

	List<CommonCodeVO> getMemJob(String cmcdDtl);


}