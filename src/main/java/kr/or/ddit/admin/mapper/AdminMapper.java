package kr.or.ddit.admin.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.AttachmentVO;
import kr.or.ddit.vo.BoardCommentVO;
import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.CommonCodeVO;
import kr.or.ddit.vo.EnterpriseMemVO;
import kr.or.ddit.vo.EnterpriseVO;
import kr.or.ddit.vo.InternshipVO;
import kr.or.ddit.vo.JobPostingVO;
import kr.or.ddit.vo.LectureSeriesVO;
import kr.or.ddit.vo.LectureVO;
import kr.or.ddit.vo.MemVO;
import kr.or.ddit.vo.PremiumVO;
import kr.or.ddit.vo.ReportVO;

public interface AdminMapper {
	// 리스트를 불러온다.
	public List<MemVO> nomalList();
	// 일반회원 목록 총 목록 수
	public int getTotal(Map<String, String> map);
	// 검색한 목록
	public List<MemVO> nomalList2(Map<String, String> map);
	// 일반회원 상세 정보
	public MemVO getMemDetail(MemVO memVo);
	// 일반회원 멤버십 가입 여부
	public MemVO isVip(MemVO memVo);
	// 일반 회원 차단
	public int blockMem(MemVO memVo);
	// 채용 공고 리스트 불러오기
	public List<JobPostingVO> getjobPostingList(MemVO memVO);
	// 채용 공고 패이징
	public List<JobPostingVO> getjobPostingList2(Map<String, String> map);
	// 채용 공고 전체 리스트 개수
	public int getMTotal(MemVO memVo);
	// 차단 회원 리스트
	public List<MemVO> blockList(Map<String, String> map);
	// 차단 회원 전체 리스트
	public int getBlockTotal(Map<String, String> map);
	// 차단 회원 차단해제
	public int nonBlockMem(MemVO memVo);
	// 차단 회원 상세정보
	public List<MemVO> getBlockDetail(MemVO memVo);
	// 신고 목록 개수
	public int reportTotal(MemVO memVo);
	// 신고 목록 페이징
	public List<MemVO> reportPage(Map<String, String> map);
	// 기업 회원 관리 페이지
	public List<EnterpriseVO> firmList(Map<String, String> map);
	// 기업 회원 전체 개수
	public int firmAllTotal(Map<String, String> map);
	// 기업 회원 상세 정보
	public MemVO getFirmDetail(MemVO memVo);
	// 차단 기업 회원 목록
	public List<EnterpriseVO> blockFirmList(Map<String, String> map);
	// 차단 기업 회원 총 수
	public int blockFirmAllTotal(Map<String, String> map);
	// 차단 기업 상세 정보
	public MemVO getBlockFirmDetail(MemVO memVo);
	// 승인 요청 기업 정보
	public List<EnterpriseVO> permitRequestList(Map<String, String> map);
	// 승인 요청 기업 정보의 총 개수
	public int allRequest(Map<String, String> map);
	// 차단 기업 회원 차단 해제
	public int resolveBlockFirm(MemVO memVo);
	// 비승인 기업 승인 하기
	public int permitFirm(MemVO memVo);
	// 사업자 등록 증명원 파일 이름 가져오기
	public String getPermitRg(String entNo);
	// 게시판 전체 목록 가져오기
	public List<BoardVO> getBoardList(Map<String, String> map);
	// 게시판 목록 전체 개수
	public int boardTotal(Map<String, String> map);
	// 게시판 상세 정보
	public BoardVO boardDetail(BoardVO boardVo);
	// 게시글 작성
	public int insertContent(Map<String, String> map);
	// 게시글 수정
	public int modifyContent(Map<String, String> map);
	// 게시글 삭제
	public int boardDelete(BoardVO boardVo);
	// 댓글 삭제
	public int commentDelete(BoardCommentVO commentVo);
	// 댓글 생성
	public int createCmt(BoardCommentVO cntVo);
	// 댓글 1개 삭제
	public int cmtOneDelet(BoardCommentVO commentVo);
	// 기업 정보
	public EnterpriseVO getEnterPriceDetail(EnterpriseVO entVo);
	// 채용정보 가져오기
	public JobPostingVO getPosting(JobPostingVO jobPostingVo);
	// 회원 신고 목록 가져오기
	public List<ReportVO> getreportList(Map<String, String> map);
	// 회원 신고 목록 수 가져오기
	public int getReportTotal(Map<String, String> map);
	// 승인여부 처리
	public int blockFinish(String rptNo);
	// 강의 총 개수
	public int getlectureTotal(Map<String, String> map);
	// 강의 페이징 리스트
	public List<LectureVO> getLectureList(Map<String, String> map);
	// 강의 회차 리스트
	public LectureVO getLecturSerise(String lctNo);
	// 강의 동영상 경로 가지고 오기
	public String goLecture(LectureSeriesVO lectureSeriesVo);
	// 강의 동영상 수정
	public int lectureModify(LectureSeriesVO lectuerseriseVO);
	// 프리미엄 이름 수정
	public int updatePrmmTitle(Map<String, String> map1);
	// 강사이름 수정
	public int updateLctInstrNm(Map<String, String> map);
	// 강의 넣기
	public int insertLectureSerise(Map<String, String> map);
	// 강의 내용 넣기
	public int insertAtt(Map<String, String> map);
	// 강의 회차별 수정
	public int updateLectureSerise(Map<String, String> map);
	// 강의 회차 첨부파일 수정
	public int updateLectureAtt(Map<String, String> map);
	// 프리미엄 삭제
	public int deletePrmm(String prmmNo);
	// 강의 삭제
	public int deleteLct(String prmmNo);
	// 첨부 파일 삭제
	public int deleteAtt(String prmmNo);
	// 강의 회차 전부 삭제
	public int deleteSrsAll(String prmmNo);
	// 프리미엄 삽입
	public int insertPrmm(PremiumVO premiumVO);
	// 강의 삽입
	public int insertLct(LectureVO lectureVO);
	// 특강 전체 수
	public int getSpecialTotal(Map<String, String> map);
	// 특강 목록
	public List<LectureVO> getSpecialList(Map<String, String> map);
	// 특강 프리미엄 등록
	public int insertPrmmSpc(PremiumVO premiumVO);
	// 특강 등록
	public int insertLctSpc(LectureVO lectureVO);
	// 인턴십 총 개수
	public int getIntershipTotal(Map<String, String> map);
	// 인턴십 리스트
	public List<InternshipVO> getInsternshipList(Map<String, String> map);
	// 인턴십 상세
	public InternshipVO internshipDetail(String prmmNo);
	// 인턴십 승인 해제
	public int noPermit(String itnsNo);
	// 인턴십 승인 요청 목록
	public List<InternshipVO> internshipRequestList(Map<String, String> map);
	// 인턴십 승인 요청 총 개수
	public int internshipRequestTotal(Map<String, String> map);
	// 인턴십 승인하기
	public int permitInternship(String itnsNo);
	// 일반회원 프로필
	public List<AttachmentVO> getMemProfile(MemVO memVo);
	// 강의 회차 삭제
	public int deleteSrs(String lctSrsNo);
	// 기업 이미지 가져오기
	public List<AttachmentVO> getFirmAttNm(MemVO memVo);
	// 기업이 쓴 채용공고 내용 총 개수
	public int postedTotal(EnterpriseMemVO enterpriseMemVo);
	// 기업이 쓴 채용 공고
	public List<JobPostingVO> getjobPostedList(Map<String, String> map);
	// 채용 공고 전체 목록
	public List<JobPostingVO> getjobPostList(Map<String, String> map);
	// 채용 공고 전체 목록 개수
	public int jobPostedTotal(Map<String, String> map);
	// 채용 공고 승인처리하기
	public int permitJobpost(JobPostingVO jobPostingVo);
	// 채용 공고 미 승인처리하기
	public int noPermitJobpost(JobPostingVO jobPostingVo);
	// 게시글 신고 목록 개수
	public int reportBoardTotal(Map<String, String> map);
	// 게시글 신고 목록
	public List<ReportVO> reportBoardList(Map<String, String> map);
	// 강좌 첨부파일 삭제
	public int deleteSrsAtt(String lctSrsNo);
	// 신고 처리 여부
	public int bReportPrcs(String prcs);

	public int bReportNonPrcs(String prcs);
	// 강사 목록 가져오기
	public List<CommonCodeVO> getTeacher();
	// 배경 삭제
	public int deleteBg(String prmmNo);

}
