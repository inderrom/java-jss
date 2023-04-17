package kr.or.ddit.enterprise.mapper;

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

public interface EnterpriseMapper {

	/** 채용공고 목록 리스트
	 * @param pagination 한번에 출력 개수 mSize, 현재 페이지 mCurrentPage, 자신의 채용공고인 entNo
	 * @return List<JobPostingVO> 본인 기업 채용공고 목록
	 */
	public List<JobPostingVO> jobPostingList(Map<String, String> pagination);

	/** 로그인한 기업회원의 모든 채용공고 총 개수 가져오기
	 * @param entNo 기업회원
	 * @return total
	 */
	public int getTotalJobPosting(String entNo);

	/** 채용공고 추가를 위한 새로운 채용공고 번호 가져오기
	 * @return
	 */
	public String getjobPstgNo();

	/**
	 * 채용 공고 추가
	 * @param jobPostingVO
	 * jobPstgAprvYn(승인여부), jobPstgBgngDt(채용시작일), jobPstgEndDate(채용종료일),jobPstgTitle(공고제목),jobPstgContent(공고내용),
	 * jobPstgMainWork(주요업무),jobPstgQlfc(자격요건),jobPstgRpfntm(우대사항),jobPstgBnf(혜택복지)jobPstgPrize(취업 축하금)을 값을 받는다.
	 *
	 * @return 성공 1, 실패 0
	 */
	public int jobPostingInsert(JobPostingVO jobPostingVO);

	/**
	 * 채용 태그 추가
	 * @param tagVOList 태그 JobPostingTagVO을 담은 List로 채용공고 태그 추가
	 * @return 성공 1, 실패 0
	 */
	public int insertTagList(List<JobPostingTagVO> tagVOList);

	/**
	 *  수정을 위한 REQUIRE_JOB 테이블 내용 삭제
	 * @param jobPstgNo으로 REQUIRE_JOB 테이블 안에 들어있는 내용을 모두 삭제함
	 * @return 성공 1, 실패 0
	 */
	public int deleteByJobJobPstgNo(String jobPstgNo);

	/**
	 * 채용 직군 추가
	 * @param requireJobVOList 직업 RequireJobVO을 담은 List로 채용 직군 추가
	 * @return 성공 1, 실패 0
	 */
	public int insertJobList(List<RequireJobVO> requireJobVOList);

	/**
	 * 채용 공고 스킬 추가
	 * @param jobPostingSkillVOList 직업 JobPostingSkillVO을 담은 List로 채용 공고 스킬 추가
	 * @return 성공 1, 실패 0
	 */
	public int insertSkillList(List<JobPostingSkillVO> jobPostingSkillVOList);

	/**
	 *  수정을 위한 JOB_POSTING_TAG 테이블 내용 삭제
	 * @param jobPstgNo으로 JOB_POSTING_TAG 테이블 안에 들어있는 내용을 모두 삭제함
	 * @return 성공 1, 실패 0
	 */
	public int deleteByTagJobPstgNo(String jobPstgNo);

	/**
	 *  수정을 위한 JOB_POSTING_SKILL 테이블 내용 삭제
	 * @param jobPstgNo으로 JOB_POSTING_TAG 테이블 안에 들어있는 내용을 모두 삭제함
	 * @return 성공 1, 실패 0
	 */
	public int deleteBySkillJobPstgNo(String jobPstgNo);

	/**
	 * 선택한 Tag 또는 Job List로 공통 코드 VO 가져오기
	 * @param cmcdDtl으로 WHERE CMCD_DTL = #{cmcdDtl}
	 * @return CommonCodeVO 가져온다. EX) DEVELOPER	 DVL001	 개발	 프론트엔드 개발자	 Y
	 */
	public CommonCodeVO getCommenCode(String cmcdDtl);

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

	/** 상세 채용공고 데이터 가져오기
	 * @param jobPstgNo를 이용해 상세 채용공고 데이터 가져온다.
	 * @return 성공 JobPostingVO, 실패 null?
	 */
	public JobPostingVO getDetailJobPosting(String jobPstgNo);

	/** 모든 공통 코드 가져오기
	 * @return
	 */
	public List<CommonCodeVO> getAllCommonCodeList();

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

	/** 채용공고 삭제
	 * @param jobPstgNo 채용공고 번호를 받아서 삭제
	 * @return 성공 양수, 실패 null
	 */
	public int deleteJobPosting(String jobPstgNo);

	/**
	 * 기업회원 정보등록
	 *
	 * @param entVO 등록할 정보가 담긴 entVO
	 * @return 등록한 기업의 번호
	 */
	public void enterpriseJoin(EnterpriseVO entVO);

	public void enterpriseMemInsert(EnterpriseMemVO entVO);

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

	public List<Map<String, String>> getEmployState(Map<String, String> map);

	public List<Map<String, String>> getApplyList(Map<String, String> map);

	public List<EnterpriseSkillVO> getEntSkillList(String memId);

	public Map<String, String> getEnterpriseDetail(String entNo);

	public List<String> getEntAllTag(String entNo);

	public void updateEmpState(Map<String, String> map);
}
