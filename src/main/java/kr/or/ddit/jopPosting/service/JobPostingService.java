package kr.or.ddit.jopPosting.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.ArticlePage;
import kr.or.ddit.vo.AttachmentVO;
import kr.or.ddit.vo.CommonCodeVO;
import kr.or.ddit.vo.EmployStatusVO;
import kr.or.ddit.vo.JobPostingVO;
import kr.or.ddit.vo.MemVO;

public interface JobPostingService {

	/** 조건 x 채용공고
	 * 현재 페이지 currentPage, 원하는 게시글 개수 size
	 * @return 채용공고,기업 사진
	 */
	Map<String, Object> getJobPosting();


	/** 조건 검색 페이징
	 * @param jsonData 조건들이 담겨 있다.
	 * size - default :15
	 * total - 조건의 총 채용공고 개수
	 * currentPage - 현재 페이지
	 * selectJobGroup - 선택한 직군
	 * selectJobList - 선택한 직무 배열
	 * selectTagList - 선택한 태그 배열
	 * @return 페이징 또는 정보들
	 */
	Map<String,Object>  getSearchJobPost(Map<String, Object> jsonData);


	/** 로그인한 회원의 맞춤 채용공고 리스트 가져오기
	 * @param memId 회원 아이디로 회원 정보를 가져온다.
	 * @return MemVO 회원 정보를 담은 VO
	 */
	Map<String, Object> getMemberCustomSearch(String memId);


	/** 전사적 아이디(jobPstgNo)로 북마크 유무를 체크하는 메서드
	 * @param jobPstgNo  채용공고 번호로 유무 확인
	 * @return 유 true , 무 false
	 */
	boolean getbookMarkCheckState(String jobPstgNo);


	/** 상세 채용공고, 태그, 직무, 스킬 가져오기
	 * @param jobPstgNo 채용공고 번호로 가져온다.
	 * @return JobPostingVO
	 * attachmentList			대표사진 리스트
	 * requireJobVOList 		채용공고 선택 직무List
	 * jobPostingTagVOList		채용공고 선택 태그List
	 * jobPostingSkillVOList	채용공고 선택 스킬List
	 */
	JobPostingVO detailJobPosting(String jobPstgNo);


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


	/** 이력서 지원
	 * @param employStatusVO
	 * jobPstgNo 채용공고 번호
	 * rsmNo 이력서 번호
	 * attNo 첨부파일 번호
	 * @return 성공 양수 실패 0 또는 음수
	 */
	int applyToResume(EmployStatusVO employStatusVO);


	/** 이력서 지원유무 체크
	 * @param employStatusVO
	 * rsmNo 이력서 번호로 memId를 찾고 체크
	 * @return 지원 이력서 무 true 지원 이력서 유 false
	 */
	boolean JobPostingApplyCheck(EmployStatusVO employStatusVO);


	List<Map<String, String>> mainJobPostingRecomm();



}
