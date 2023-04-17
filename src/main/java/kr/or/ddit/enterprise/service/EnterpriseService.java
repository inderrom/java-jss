package kr.or.ddit.enterprise.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.CommonCodeVO;
import kr.or.ddit.vo.EmployStatusVO;
import kr.or.ddit.vo.EnterpriseMemVO;
import kr.or.ddit.vo.EnterpriseSkillVO;
import kr.or.ddit.vo.EnterpriseVO;
import kr.or.ddit.vo.JobPostingSkillVO;
import kr.or.ddit.vo.JobPostingTagVO;
import kr.or.ddit.vo.JobPostingVO;
import kr.or.ddit.vo.RequireJobVO;

public interface EnterpriseService {

	/** 채용공고 목록 리스트
	 * @param pagination 한번에 출력 개수 mSize, 현재 페이지 mCurrentPage, 자신의 채용공고인 entNo
	 * @return List<JobPostingVO> 본인 기업 채용공고 목록
	 */
	public List<JobPostingVO> jobPostingList(Map<String, String> pagination);

	/**
	 * 세션에 등록된 회원 정보 중 memId를 이용해서 기업 회원 유무 검사 및 정보 가져오기
	 * @param memId 회원의 memeId를 가져와서 검사
	 * @return 성공 EnterpriseMemVO(기업,담당자 정보), 실패 null
	 */
	public Map<String, String> enterpriseCheck(String memId);

	/**
	 *
	 * @param jobCode로 원하는 공통코드 코드를 적으면 코드 해당 중분류 코드 리스트를 가져온다.
	 * @return 성공 List<CommonCodeVO>, 실패 null
	 */
	public List<CommonCodeVO> getCodeList(String jobCode);

	/**
	 *  채용공고 추가 데이터
	 *	@param jobPostingVO
	 * jobPstgAprvYn(승인여부), jobPstgBgngDt(채용시작일), jobPstgEndDate(채용종료일),jobPstgTitle(공고제목),jobPstgContent(공고내용),
	 * jobPstgMainWork(주요업무),jobPstgQlfc(자격요건),jobPstgRpfntm(우대사항),jobPstgBnf(혜택복지)jobPstgPrize(취업 축하금)을 값을 받는다.
	 *
	 *  채용 공고 태그 추가 데이터
	 * @param selectTagList selectTagList 태그 cmcdDtl를 담은 List
	 *
	 *  채용 직업 추가 데이터
	 * @param selectJobList selectJobList 직업 cmcdDtl을 담은 List
	 *  스킬 추가 데이터
	 * @param selectSkillList
	 * @return
	 */
	public int jobPostingInsert(JobPostingVO jobPostingVO, List<String> selectTagList, List<String> selectJobList, List<String> selectSkillList);

	/** 상세 채용공고 데이터 가져오기
	 * @param jobPstgNo를 이용해 상세 채용공고 데이터 가져온다.
	 * @return 성공 JobPostingVO, 실패 null?
	 */
	public JobPostingVO getDetailJobPosting(String jobPstgNo);

	/** 모든 공통 코드 가져오기
	 * @return
	 */
	public List<CommonCodeVO> getAllCommonCodeList();

	/** 공통코트 리펙토링
	 * AUTHORITY(분류중 입력)
		JOB(직군)
		DESIGN (직군-디자인)
		DEVELOPER (직군-개발)
		LANGUAGE_LEVEL (언어-언어 수준)
		MANAGEMENT (직군 - 경영/비즈니스)
		MARKETING (직군 - 마케팅/광고)
		LANGUAGE (언어)
		SKILL (기술)
		TAG (태그)
		PREMIUM (프리미엄 ex-강의 특강 인터십)
		EMPLOY_STATUS (채용상태)
		Classification (분류)
		CMCD (분류)
		CLFC (분류-권한)
	 * @param commonCodeVOList 원하는 CMCD_CLFC를 List에 담으면 원하는 CMCD_CLFC별 리스트 출력
	 * @return
	 */
	public Map<String, List<CommonCodeVO>> getAllCommonCodeList(List<String> commonCodeVOList);

	/**	채용공고 스킬 리스트 가져오기
	 * @param jobPstgNo으로 채용공고 등록시 선택한 SKILL들을 가져온다.
	 * @return 성공 List<JobPostingSkillVO>, 실패 null
	 */
	public List<JobPostingSkillVO> getSkillList(String jobPstgNo);

	/**	채용공고 태그 리스트 가져오기
	 * @param jobPstgNo으로 채용공고 등록시 선택한 TAG들을 가져온다.
	 * @return 성공 List<JobPostingTagVO>, 실패 null
	 */
	public List<JobPostingTagVO> getTagList(String jobPstgNo);

	/**	채용공고 직업 리스트 가져오기
	 * @param jobPstgNo으로 채용공고 등록시 선택한 JOB들을 가져온다.
	 * @return 성공 List<RequireJobVO>, 실패 null
	 */
	public List<RequireJobVO> getJobList(String jobPstgNo);

	/** 직군을 알기위해서 내가 선택한 직업 상세코트로 찾는다.
	 * @param rqrJobNo 내가 선택한 인덱스 0 번째 상세코트로 찾는다.
	 * @return 성공 직군, 실패 null
	 */
	public CommonCodeVO getselectJobGroup(String rqrJobNo);

	/** 채용공고 수정
	 * @param jobPostingVO		채용공고 수정 내용
	 * @param selectTagList 	수정할 채용공고 태그
	 * @param selectJobList 	수정할 채용공고 직무
	 * @param selectSkillList	수정할 채용공고 스킬
	 * @param model
	 * @return 성공 양수, 실패 음수
	 */
	public int modifyJobPosting(JobPostingVO jobPostingVO, List<String> selectJobList, List<String> selectSkillList, List<String> selectTagList);

	/** 채용공고 삭제
	 * @param jobPstgNo 채용공고 번호로 채용공고 삭제
	 * @return 성공 양수, 실패 음수
	 */
	public int deleteJobPosting(String jobPstgNo);

	/**
	 * 기업회원 정보등록
	 *
	 * @param entVO 등록할 정보가 담긴 entVO
	 * @return 등록한 기업의 번호
	 */
	public void enterpriseJoin(EnterpriseVO entVO);

	public void enterpriseMemInsert(EnterpriseMemVO entMemVO);

	/**
	 * 기업회원 기본정보 수정
	 *
	 * @param entVO 수정할 기업의 정보가 담긴 EnterpriseVO
	 */
	public void enterpriseUpdate(EnterpriseVO entVO);

	/**
	 * 기업회원 담당자정보 수정
	 *
	 * @param entMemVO 수정할 기업의 정보가 담긴 EnterpriseMemVO
	 */
	public void enterpriseMemUpdate(EnterpriseMemVO entMemVO);

	/**
	 * 기업회원 스킬정보 수정
	 *
	 * @param entVO 수정할 기업의 정보가 담긴 EnterpriseVO
	 */
	public void entSkillUpdate(EnterpriseVO entVO);

	/** 로그인한 기업회원의 모든 채용공고 총 개수 가져오기
	 * @param entNo 기업회원
	 * @return total
	 */
	public int getTotalJobPosting(String entNo);

	public List<Map<String, String>> getEmployState(Map<String, String> map);

	public List<Map<String, String>> getApplyList(Map<String, String> map);

	public List<EnterpriseSkillVO> getEntSkillList(String memId);

	public Map<String, String> getEnterpriseDetail(String entNo);

	public List<String> getEntAllTag(String entNo);

	CommonCodeVO getCommonCode(String cmcdDtl);

	public void updateEmpState(Map<String, String> map);
}
