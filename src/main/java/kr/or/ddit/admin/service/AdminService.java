package kr.or.ddit.admin.service;

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

public interface AdminService {

	public List<MemVO> nomalList();

	public List<MemVO> nomalList2(Map<String, String> map);

	public int getTotal(Map<String, String> map);

	public MemVO getMemDetail(MemVO memVo);

	public MemVO isVip(MemVO memVo);

	public int blockMem(MemVO memVo);

	public List<JobPostingVO> getjobPostingList(MemVO memVO);

	public List<JobPostingVO> getjobPostingList2(Map<String, String> map);

	public int getMTotal(MemVO memVo);

	public List<MemVO> blockList(Map<String, String> map);

	public int getBlockTotal(Map<String, String> map);

	public int nonBlockMem(MemVO memVo);

	public List<MemVO> getBlockDetail(MemVO memVo);

	public int reportTotal(MemVO memVo);

	public List<MemVO> reportPage(Map<String, String> map);

	public List<EnterpriseVO> firmList(Map<String, String> map);

	public int firmAllTotal(Map<String, String> map);

	public MemVO getFirmDetail(MemVO memVo);

	public List<EnterpriseVO> blockFirmList(Map<String, String> map);

	public int blockFirmAllTotal(Map<String, String> map);

	public MemVO getBlockFirmDetail(MemVO memVo);

	public List<EnterpriseVO> permitRequestList(Map<String, String> map);

	public int allRequest(Map<String, String> map);

	public int resolveBlockFirm(MemVO memVo);

	public int permitFirm(MemVO memVo);

	public String getPermitRg(String entNo);

	public List<BoardVO> getBoardList(Map<String, String> map);

	public int boardTotal(Map<String, String> map);

	public BoardVO boardDetail(BoardVO boardVo);

	public int insertContent(Map<String, String> map);

	public int modifyContent(Map<String, String> map);

	public int boardDelete(BoardVO boardVo);

	public int commentDelete(BoardCommentVO commentVo);

	public int createCmt(BoardCommentVO cntVo);

	public int cmtOneDelet(BoardCommentVO commentVo);

	public EnterpriseVO getEnterPriceDetail(EnterpriseVO entVo);

	public JobPostingVO getPosting(JobPostingVO jobPostingVo);

	public List<ReportVO> getreportList(Map<String, String> map);

	public int getReportTotal(Map<String, String> map);

	public int blockFinish(String rptNo);

	public int getlectureTotal(Map<String, String> map);

	public List<LectureVO> getLectureList(Map<String, String> map);

	public LectureVO getLecturSerise(String lctNo);

	public String goLecture(LectureSeriesVO lectureSeriesVo);

	public int lectureModify(LectureSeriesVO lectuerseriseVO);

	public int updatePrmmTitle(Map<String, String> map1);

	public int updateLctInstrNm(Map<String, String> map);

	public int insertLectureSerise(Map<String, String> map);

	public int insertAtt(Map<String, String> map);

	public int updateLectureSerise(Map<String, String> map);

	public int updateLectureAtt(Map<String, String> map);

	public int deletePrmm(String prmmNo);

	public int deleteLct(String prmmNo);

	public int deleteAtt(String prmmNo);

	public int deleteSrsAll(String prmmNo);

	public int insertPrmm(PremiumVO premiumVO);

	public int insertLct(LectureVO lectureVO);

	public int getSpecialTotal(Map<String, String> map);

	public List<LectureVO> getSpecialList(Map<String, String> map);

	public int insertPrmmSpc(PremiumVO premiumVO);

	public int insertLctSpc(LectureVO lectureVO);

	public int getIntershipTotal(Map<String, String> map);

	public List<InternshipVO> getInsternshipList(Map<String, String> map);

	public InternshipVO internshipDetail(String prmmNo);

	public int noPermit(String itnsNo);

	public List<InternshipVO> internshipRequestList(Map<String, String> map);

	public int internshipRequestTotal(Map<String, String> map);

	public int permitInternship(String itnsNo);

	public List<AttachmentVO> getMemProfile(MemVO memVo);

	public int deleteSrs(String lctSrsNo);

	public List<AttachmentVO> getFirmAttNm(MemVO memVo);

	public int postedTotal(EnterpriseMemVO enterpriseMemVo);

	public List<JobPostingVO> getjobPostedList(Map<String, String> map);

	public List<JobPostingVO> getjobPostList(Map<String, String> map);

	public int jobPostedTotal(Map<String, String> map);

	public int permitJobpost(JobPostingVO jobPostingVo);

	public int noPermitJobpost(JobPostingVO jobPostingVo);

	public int reportBoardTotal(Map<String, String> map);

	public List<ReportVO> reportBoardList(Map<String, String> map);

	public int deleteSrsAtt(String lctSrsNo);

	public int bReportPrcs(List<String> prcsList);

	public int bReportNonPrcs(List<String> prcsList);

	public List<CommonCodeVO> getTeacher();

	public int deleteBg(String prmmNo);






}
