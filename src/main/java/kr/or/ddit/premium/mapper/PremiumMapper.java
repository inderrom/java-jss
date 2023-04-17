package kr.or.ddit.premium.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.InternshipChatVO;
import kr.or.ddit.vo.InternshipCommunityCommentVO;
import kr.or.ddit.vo.InternshipCommunityVO;
import kr.or.ddit.vo.InternshipEntryantVO;
import kr.or.ddit.vo.InternshipScheduleVO;
import kr.or.ddit.vo.InternshipVO;
import kr.or.ddit.vo.LectureSeriesVO;
import kr.or.ddit.vo.LectureVO;
import kr.or.ddit.vo.MemVO;
import kr.or.ddit.vo.PremiumVO;
import kr.or.ddit.vo.RecordVO;
import kr.or.ddit.vo.VipVO;

public interface PremiumMapper {

	//프리미엄 메인(전체 리스트)
	public List<PremiumVO> getPrmmList(String prmmClfc);

	//프리미엄 컨텐츠 개수 가져오기
	public int getTotalCount(String prmmClfc);

	//프리미엄 디테일
	public PremiumVO getPrmmDetail(PremiumVO premiumVO);

	//인턴십을 신청한다.
	public int applyInternship(InternshipEntryantVO internshipentryantVO);

	//인턴십 참가자 테이블에 기존 신청내역이 있는지 체크한다.
	public int checkInternshipEntryant(InternshipEntryantVO internshipEntryantVO);

	//최근 기록(record테이블)을 체크(이미 신청한 내역인지 확인)
	public int checkApply(RecordVO recordVO);

	//내가 신청한 강의 리스트를 조회한다.
	public List<PremiumVO> getmyLectureList(RecordVO recordVO);

	//내가 신청한 인턴십 리스트를 조회한다. (진행기간이 끝나지 않은 것만)
	public List<InternshipVO> getMyInternshipList(RecordVO recordVO);

	//내가 신청한 인턴십 리스트를 조회한다. (진행기간이 끝난 것만)
	public List<InternshipVO> getMyEndedInternshipList(RecordVO recordVO);

	//강의 시리즈를 포함하는 lectureDetail 조회
	public LectureVO getLectureDetail(PremiumVO premiumVO);

	//강의 디테일 정보를 가져온다(동영상 재생을 위해)
	public LectureSeriesVO getlecSrsDetail(LectureSeriesVO lectureSeriesVO);

	//수강신청 목록에서 강의를 삭제한다.
	public void deletemyLecture(RecordVO recordVO);

	//내가 신청한 인턴십 상세보기
	public InternshipVO getMyInternshipDetail(InternshipVO internshipVO);

	//내가 열람했던 프리미엄 리스트 기록을 가져온다.
	public List<PremiumVO> getMyPrmmRec(RecordVO recordVO);

	//다음 vipNo 가져오기
	public String getNextVipNo();

	//멤버십 결제 성공시 vip 테이블에 새로운 정보 insert
	public void insertVIP(VipVO vipVO);

	//기업회원이 등록한 인턴십 리스트 조회
	public List<InternshipVO> getEntItnsList(Map<String, String> paramMap);

	//기업회원이 인턴십 등록 ==> 프리미엄 테이블 추가
	public void insertPrmm(PremiumVO prmmVO);

	//기업회원이 인턴십 등록 ==> 인턴십 테이블 추가
	public void insertItns(InternshipVO itnsVO);

	//프리미엄 테이블 다음 기본키 값 조회
	public String getNxtPrmmNo();


	/**
	 * 인턴십 내 커뮤니티 리스트 조회
	 * @param map
	 *
	 * @return 커뮤니티 글 목록
	 */
	public List<InternshipCommunityVO> boardList(Map<String, Object> map);

	//인턴십 신청자 승인/반려
	public void updateEntrtAprv(InternshipEntryantVO itnsEntrtVO);

	/** 승인된 참가자 수
	 * @param itnsNo
	 * @return int
	 */
	public int getEntrtCount(String itnsNo);

	//인턴십 참가자 리스트
	public List<InternshipEntryantVO> getItnsEntrtList(String itnsNo);

	/**
	 * 인턴십 내 커뮤니티 디테일 조회
	 * @param InternshipCommunityVO 조회할 목록의 조건이 담긴 객체
	 *
	 * @return 글 내용이 담긴 InternshipCommunityVO
	 */
	public InternshipCommunityVO boardDetail(InternshipCommunityVO internVO);

	public int getTotal(Map<String, Object> map);

	public int cmntDelete(String cmntNo);

	public int cmntInsert(Map<String, String> map);

	public InternshipCommunityCommentVO cmntDetail(Map<String, String> map);

	public void boardInsert(InternshipCommunityVO internVO);

	//인턴십 삭제
	public void deleteItns(InternshipVO itnsVO);

	//인턴십 수정(프리미엄 테이블)
	public void editItnsPrmm(PremiumVO prmmVO);
	//인턴십 수정(인턴십 테이블)
	public void editItnsItns(InternshipVO itnsVO);

	int setInternshipSchedule(InternshipScheduleVO itnsScheduleVO);

	int deleteInternshipSchedule(InternshipScheduleVO itnsScheduleVO);

	List<InternshipChatVO> getChatList(InternshipVO internshipVO);

	public List<InternshipScheduleVO> getInternshipSchedule(InternshipVO internshipVO);

	public int chatMsgInsert(Map<String, String> map);

	public List<MemVO> getIntetnshipEntryant(InternshipVO internshipVO);

}
