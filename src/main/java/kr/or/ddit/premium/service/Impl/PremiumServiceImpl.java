package kr.or.ddit.premium.service.Impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.premium.mapper.PremiumMapper;
import kr.or.ddit.premium.service.PremiumService;
import kr.or.ddit.vo.ArticlePage;
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
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class PremiumServiceImpl implements PremiumService{

	@Autowired
	PremiumMapper premiumMapper;

	/** 프리미엄 전체 리스트를 조회한다.
	 * @return List
	 */
	public List<PremiumVO> getPrmmList(String prmmClfc){


		return this.premiumMapper.getPrmmList(prmmClfc);
	}

	/** 프리미엄 글을 상세조회한다.
	 * @param PremiumVO
	 * @return List
	 */
	@Override
	public PremiumVO getPrmmDetail(PremiumVO premiumVO) {
		return this.premiumMapper.getPrmmDetail(premiumVO);
	}

	/** 인턴십을 신청한다. (인턴십 참가자 테이블에 추가한다.)
	 * @param internshipVO
	 * @return void
	 */
	@Override
	public int applyInternship(InternshipEntryantVO internshipentryantVO) {
		return this.premiumMapper.applyInternship(internshipentryantVO);
	}


	/** 인턴십 참가자 테이블에 기존 신청내역이 있는지 체크한다.
	 * @param internshipEntryantVO
	 * @return int
	 */
	@Override
	public int checkInternshipEntryant(InternshipEntryantVO internshipEntryantVO) {
		return this.premiumMapper.checkInternshipEntryant(internshipEntryantVO);
	}

	/** 최근 기록(record테이블)을 체크(이미 신청한 내역인지 확인)
	 * @param recordVO
	 * @return
	 */
	@Override
	public int checkApply(RecordVO recordVO) {
		return this.premiumMapper.checkApply(recordVO);
	}


	///////////////////////////////////////////////////////////////////

	/** 내가 열람했던 프리미엄 리스트 기록을 가져온다.
	 * @param recordVO
	 * @return List<PremiumVO>
	 */
	@Override
	public List<PremiumVO> getMyPrmmRec(RecordVO recordVO){
		return this.premiumMapper.getMyPrmmRec(recordVO);
	}

	/** 내가 신청한 강의 리스트를 조회한다.
	 * @param recordVO
	 * @return List<PremiumVO>
	 */
	@Override
	public List<PremiumVO> getmyLectureList(RecordVO recordVO) {
		return this.premiumMapper.getmyLectureList(recordVO);
	}

	/** 내가 신청한 인턴십 리스트를 조회한다. (진행기간이 끝나지 않은 것만)
	 * @param recordVO
	 * @return List<PremiumVO>
	 */
	@Override
	public List<InternshipVO> getMyInternshipList(RecordVO recordVO) {
		return this.premiumMapper.getMyInternshipList(recordVO);
	}

	/** 내가 신청한 인턴십 리스트를 조회한다. (진행기간이 끝난 것만)
	 * @param recordVO
	 * @return premiumVO
	 */
	@Override
	public List<InternshipVO> getMyEndedInternshipList(RecordVO recordVO) {
		return this.premiumMapper.getMyEndedInternshipList(recordVO);
	}

	/** 강의 시리즈를 포함하는 lectureDetail 조회
	 * @param premiumVO
	 * @return LectureDetailVO
	 */
	@Override
	public LectureVO getLectureDetail(PremiumVO premiumVO) {
		return this.premiumMapper.getLectureDetail(premiumVO);
	}

	/** 강의 디테일 정보를 가져온다(동영상 재생을 위해)
	 * @param lectureSeriesVO
	 * @return LectureSeriesVO
	 */
	@Override
	public LectureSeriesVO getlecSrsDetail(LectureSeriesVO lectureSeriesVO) {
		return this.premiumMapper.getlecSrsDetail(lectureSeriesVO);
	}

	/** 수강신청목록에서 강의를 삭제한다.
	 * @param recordVO
	 */
	@Override
	public void deletemyLecture(RecordVO recordVO) {
		this.premiumMapper.deletemyLecture(recordVO);
	}

	/** 내가 신청한 인턴십 상세보기
	 * @param internshipVO
	 * @return InternshipVO
	 */
	@Override
	public InternshipVO getMyInternshipDetail(InternshipVO internshipVO) {
		return this.premiumMapper.getMyInternshipDetail(internshipVO);
	}

	/** 다음 vipNo 가져오기
	 * @param vipVO
	 * @return String
	 */
	@Override
	public String getNextVipNo() {
		return this.premiumMapper.getNextVipNo();
	}

	/** 멤버십 결제 성공시 vip 테이블에 새로운 정보 insert
	 *
	 */
	@Override
	public void insertVip(VipVO vipVO) {
		this.premiumMapper.insertVIP(vipVO);
	}

	/////////////////////////////////////////////////////////////////////////////////////////////
	//기업회원
	/** 기업회원이 등록한 인턴십 리스트 조회
	 * @param paramMap
	 * @return List<InternshipEntryantVO>
	 */
	@Override
	public List<InternshipVO > getEntItnsList(Map<String, String> paramMap){
		return this.premiumMapper.getEntItnsList(paramMap);
	}

	/** 기업회원이 인턴십 등록 ==> 프리미엄 테이블 추가
	 * @param prmmVO
	 */
	@Override
	public void insertPrmm(PremiumVO prmmVO) {
		this.premiumMapper.insertPrmm(prmmVO);
	}

	/** 기업회원이 인턴십 등록 ==> 인턴십 테이블 추가
	 * @param itnsVO
	 */
	@Override
	public void insertItns(InternshipVO itnsVO) {
		this.premiumMapper.insertItns(itnsVO);
	}


	/** 프리미엄 테이블 다음 기본키 값 조회
	 * @return
	 */
	@Override
	public String getNxtPrmmNo() {
		return this.premiumMapper.getNxtPrmmNo();
	}

	/**
	 * 인턴십 내 커뮤니티 리스트 조회
	 *
	 * @return 커뮤니티 글 목록
	 */
	@Override
	public List<InternshipCommunityVO> boardList(Map<String, Object> map) {
		return this.premiumMapper.boardList(map);
	}

	/** 인턴십 신청자 승인/반려
	 * @param itnsEntrtVO
	 */
	@Override
	public void updateEntrtAprv(InternshipEntryantVO itnsEntrtVO) {
		this.premiumMapper.updateEntrtAprv(itnsEntrtVO);
	}

	/** 승인된 참가자 수
	 * @param itnsNo
	 * @return int
	 */
	@Override
	public int getEntrtCount(String itnsNo) {
		return this.premiumMapper.getEntrtCount(itnsNo);
	}

	/** 인턴십 참가자 리스트
	 * @param itnsNo
	 * @return
	 */
	@Override
	public List<InternshipEntryantVO> getItnsEntrtList(String itnsNo){
		return this.premiumMapper.getItnsEntrtList(itnsNo);
	}


	/**
	 * 인턴십 내 커뮤니티 디테일 조회
	 * @param InternshipCommunityVO 조회할 목록의 조건이 담긴 객체
	 *
	 * @return 글 내용이 담긴 InternshipCommunityVO
	 */
	@Override
	public InternshipCommunityVO boardDetail(InternshipCommunityVO internVO) {
		return this.premiumMapper.boardDetail(internVO);
	}

	@Override
	public int getTotal(Map<String, Object> map) {
		return this.premiumMapper.getTotal(map);
	}

	@Override
	public int cmntDelete(String cmntNo) {
		return this.premiumMapper.cmntDelete(cmntNo);
	}

	@Override
	public int cmntInsert(Map<String, String> map) {
		return this.premiumMapper.cmntInsert(map);
	}

	@Override
	public InternshipCommunityCommentVO cmntDetail(Map<String, String> map) {
		return this.premiumMapper.cmntDetail(map);
	}

	@Override
	public void boardInsert(InternshipCommunityVO internVO) {
		this.premiumMapper.boardInsert(internVO);
	}

	/** 인턴십 삭제
	 * @param itnsVO
	 */
	@Override
	public void deleteItns(InternshipVO itnsVO) {
		this.premiumMapper.deleteItns(itnsVO);
	}

	/** 인턴십 수정(프리미엄 테이블)
	 * @param prmmVO
	 */
	@Override
	public void editItnsPrmm(PremiumVO prmmVO) {
		this.premiumMapper.editItnsPrmm(prmmVO);
	}

	/** 인턴십 수정(인턴십 테이블)
	 * @param itnsVO
	 */
	@Override
	public void editItnsItns(InternshipVO itnsVO) {
		this.premiumMapper.editItnsItns(itnsVO);
	}

	@Override
	public int setInternshipSchedule(InternshipScheduleVO itnsScheduleVO) {
		if(itnsScheduleVO.getItnsSchdNo().equals("")) {
			itnsScheduleVO.setItnsSchdNo("SCHE0000");
		}
		if(itnsScheduleVO.getIntsEndDt() == null) {
			itnsScheduleVO.setIntsEndDt("");
		}
		return this.premiumMapper.setInternshipSchedule(itnsScheduleVO);
	}

	@Override
	public int deleteInternshipSchedule(InternshipScheduleVO itnsScheduleVO) {
		return this.premiumMapper.deleteInternshipSchedule(itnsScheduleVO);
	}

	@Override
	public List<InternshipChatVO> getChatList(InternshipVO internshipVO) {
		return this.premiumMapper.getChatList(internshipVO);
	}

	@Override
	public List<InternshipScheduleVO> getInternshipSchedule(InternshipVO internshipVO) {
		return this.premiumMapper.getInternshipSchedule(internshipVO);
	}

	@Override
	public int chatMsgInsert(Map<String, String> map) {
		return this.premiumMapper.chatMsgInsert(map);
	}

	@Override
	public List<MemVO> getIntetnshipEntryant(InternshipVO internshipVO) {
		return this.premiumMapper.getIntetnshipEntryant(internshipVO);
	}
}
