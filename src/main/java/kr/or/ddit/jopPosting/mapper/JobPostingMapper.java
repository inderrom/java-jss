package kr.or.ddit.jopPosting.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.AttachmentVO;
import kr.or.ddit.vo.EmployStatusVO;
import kr.or.ddit.vo.EnterpriseVO;
import kr.or.ddit.vo.JobPostingSkillVO;
import kr.or.ddit.vo.JobPostingTagVO;
import kr.or.ddit.vo.JobPostingVO;
import kr.or.ddit.vo.MemVO;

public interface JobPostingMapper {

	/** JobPosting의 등록된 회사 EntNO를 모두 가져오기
	 * @param pageingMap
	 * 현재 페이지 currentPage, 원하는 게시글 개수 size
	 * @return EntNo가 담긴 List
	 */
	List<JobPostingVO> getAllJobPost(Map<String, String> pageingMap);


	/** 태그및 직군 선택시 총 게시글 갯수 출력
	 * @param searchType TAG,JOB,JOB Group
	 * @return 게시글 개수
	 */
	int getTotal(Map<String, List<String>> searchType);

	/**  총 게시글 개수 출력
	 * @param searchType TAG,JOB,JOB Group
	 * @return 게시글 개수
	 */
	int getALLTotal();


	/** 조건 게시글 개수 출력
	 * @param searchWord
	 * @return
	 */
	int getSearchTotal(Map<String, List<String>> searchWord);

	/** JobPosting의 등록된 회사 EntNO를 모두 가져오기
	 * @param pageingMap
	 * 현재 페이지 currentPage, 원하는 게시글 개수 size
	 * @return EntNo가 담긴 List
	 */
	List<JobPostingVO> getSearchJobPost(Map<String, List<String>> searchWord);

	/** 로그인한 회원의 직업을 가져오기 위한 메서드
	 * @param memId 회원 아이디로 회원 정보를 가져온다.
	 * @return MemVO 회원 정보를 담은 VO
	 */
	MemVO getloginMemVO(String memId);


	/** 회원이 선택한 직업의 직군 채용공고
	 * @param pagination 회원의 직업 직군, size, currentPage
	 * @return 회원 직군 채용리스트
	 */
	List<JobPostingVO> getMemSelectedJobPosting(Map<String, String> pagination);


	/** 회원의 직군 채용공고 총 total
	 * @param memJobGroup
	 * @return total 총 채용공개 수
	 */
	int getTotalMemSelectedJobPosting(String memJobGroup);


	/** 기업 대표이미지 1개 가져오기
	 * @param entNo 기업번호
	 * @return 기업 이미지
	 */
	List<AttachmentVO> getOneEntImages(String entNo);


	/** 조건 x 채용공고 total 가져오기
	 * @return total
	 */
	int getTotalJobPosting();




	/** 조건 o 채용공고 total 구하기
	 * @param condition_search_map
	 * selectJobList - 선택한 직무
	 * selectTagList - 선택한 태그
	 * single_content - 페이징 정보 및 직군
	 * - 페이징 정보 :  size, total, currentPage
	 * - 직군 : selectJobGroup
	 *
	 * @return total
	 */
	List<String> getConditionJobPosting(Map<String, List<String>> condition_search_map);


	/** 조건 o 채용공고 리스트
	  * @param condition_search_map
	 *  conditionJobposting 조건에 포함된 채용공고 List
	 * single_content - 페이징 정보 및 직군
	 * - 페이징 정보 :  size, total, currentPage
	 * - 직군 : selectJobGroup
	 *
	 * @return List<JobPostingVO>
	 */
	List<JobPostingVO> getConditionJobPostingList(Map<String, List<String>> condition_search_map);


	/** 조건(직군 또는 x) 총 채용공고 리스트 total
	 * @param condition_search_map
	 * selectJobList - 선택한 직무
	 * selectTagList - 선택한 태그
	 * single_content - 페이징 정보 및 직군
	 * - 페이징 정보 :  size, total, currentPage
	 * - 직군 : selectJobGroup
	 * @return total
	 */
	int getTotalNoConditionsJobPosting(Map<String, List<String>> condition_search_map);


	/** 조건(직군 또는 x) 페이징 채용공고 리스트
	 * @param condition_search_map
	 * selectJobList - 선택한 직무
	 * selectTagList - 선택한 태그
	 * single_content - 페이징 정보 및 직군
	 * - 페이징 정보 :  size, total, currentPage
	 * - 직군 : selectJobGroup
	 * @return total
	 */
	List<JobPostingVO> getNoConditionsJobPosting(Map<String, List<String>> condition_search_map);


	/** 전사적 아이디로 북마크 유무 확인
	 * @param bookMarkMap  유저아이디, 채용공고로 유저가 등록한 북마크 확인
	 *  #{jobPstgNo} 채용공고 번호
	 *  #{userID} 유저 아이디
	 * @return 유 Y, 무 N or null
	 */
	String getBookMark(Map<String, String> bookMarkMap);


	/** 상세 채용공고, 태그, 직무, 스킬 가져오기
	 * @param jobPstgNo 채용공고 번호로 가져온다.
	 * @return JobPostingVO
	 * attachmentList			대표사진 리스트
	 * requireJobVOList 		채용공고 선택 직무List
	 * jobPostingTagVOList		채용공고 선택 태그List
	 * jobPostingSkillVOList	채용공고 선택 스킬List
	 */
	List<JobPostingVO> getDetailJobPosting(String jobPstgNo);


	/** 기업 정보 가져오기
	 * @param entNo
	 * @return EnterpriseVO
	 */
	EnterpriseVO getEntInfo(String entNo);


	/** 유저 아이디로 회원 정보 불러오기
	 * @param userId
	 * @return MemVO
	 */
	MemVO getLoginMemVO(String userId);

	/** 파일 등록후 모든 채용공고에 등록 된 파일을 불러기
	 * @param memId 회원 아이디
	 * @return List<AttachmentVO>
	 */
	List<AttachmentVO> getAttachmentList(String memId);


	/** Employ 테이블 등록
	 * @param employStatusVO
	 * @return
	 */
	int signUpEmploy(EmployStatusVO employStatusVO);


	/** Employ 등록 후 EmployStatus에 등록
	 * @param employStatusVO
	 * @return
	 */
	int signUpEmployStatus(EmployStatusVO employStatusVO);

	/** 이력서 번호로 memId 찾기
	 * @param rsmNo
	 * @return
	 */
	MemVO getMemIdForResume(String rsmNo);


	/** 회원 아이디와 채용공고로 지원 이력 확인
	 * @param applyCheckMap 회원 아이디와 채용공고로 지원 이력 확인
	 * memId 회원 아이디
	 * jobPstgNo 채용공고
	 * @return
	 */
	int getAllJobPostingResume(Map<String, String> applyCheckMap);



	/** 채용공고 태그 가져오기
	 * @param jobPstgNo
	 * @return
	 */
	List<JobPostingTagVO> getTag(String jobPstgNo);


	/** 채용공고 스킬 가져오기
	 * @param jobPstgNo
	 * @return
	 */
	List<JobPostingSkillVO> getSkill(String jobPstgNo);


	List<Map<String, String>> mainJobPostingRecomm();



}
