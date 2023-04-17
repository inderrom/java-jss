package kr.or.ddit.admin.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.admin.mapper.AdminMapper;
import kr.or.ddit.admin.service.AdminService;
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

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	AdminMapper adminMapper;

	@Override
	public List<MemVO> nomalList() {
		return this.adminMapper.nomalList();
	}

	@Override
	public List<MemVO> nomalList2(Map<String, String> map) {
		return this.adminMapper.nomalList2(map);
	}

	@Override
	public int getTotal(Map<String, String> map) {
		return this.adminMapper.getTotal(map);
	}

	@Override
	public MemVO getMemDetail(MemVO memVo) {
		return this.adminMapper.getMemDetail(memVo);
	}

	@Override
	public MemVO isVip(MemVO memVo) {
		return this.adminMapper.isVip(memVo);
	}

	@Override
	public int blockMem(MemVO memVo) {
		return this.adminMapper.blockMem(memVo);
	}

	@Override
	public List<JobPostingVO> getjobPostingList(MemVO memVO) {
		return this.adminMapper.getjobPostingList(memVO);
	}

	@Override
	public List<JobPostingVO> getjobPostingList2(Map<String, String> map) {
		return this.adminMapper.getjobPostingList2(map);
	}

	@Override
	public int getMTotal(MemVO memVo) {
		return this.adminMapper.getMTotal(memVo);
	}

	@Override
	public List<MemVO> blockList(Map<String, String> map) {
		return this.adminMapper.blockList(map);
	}

	@Override
	public int getBlockTotal(Map<String, String> map) {
		return this.adminMapper.getBlockTotal(map);
	}

	@Override
	public int nonBlockMem(MemVO memVo) {
		return this.adminMapper.nonBlockMem(memVo);
	}

	@Override
	public List<MemVO> getBlockDetail(MemVO memVo) {
		return this.adminMapper.getBlockDetail(memVo);
	}

	@Override
	public int reportTotal(MemVO memVo) {

		return this.adminMapper.reportTotal(memVo);
	}

	@Override
	public List<MemVO> reportPage(Map<String, String> map) {
		return this.adminMapper.reportPage(map);
	}

	@Override
	public List<EnterpriseVO> firmList(Map<String, String> map) {
		return this.adminMapper.firmList(map);
	}

	@Override
	public int firmAllTotal(Map<String, String> map) {
		return this.adminMapper.firmAllTotal(map);
	}

	@Override
	public MemVO getFirmDetail(MemVO memVo) {
		return this.adminMapper.getFirmDetail(memVo);
	}

	@Override
	public List<EnterpriseVO> blockFirmList(Map<String, String> map) {
		return this.adminMapper.blockFirmList(map);
	}

	@Override
	public int blockFirmAllTotal(Map<String, String> map) {
		return this.adminMapper.blockFirmAllTotal(map);
	}

	@Override
	public MemVO getBlockFirmDetail(MemVO memVo) {
		return this.adminMapper.getBlockFirmDetail(memVo);
	}

	@Override
	public List<EnterpriseVO> permitRequestList(Map<String, String> map) {
		return this.adminMapper.permitRequestList(map);
	}

	@Override
	public int allRequest(Map<String, String> map) {
		return this.adminMapper.allRequest(map);
	}

	@Override
	public int resolveBlockFirm(MemVO memVo) {
		return this.adminMapper.resolveBlockFirm(memVo);
	}

	@Override
	public int permitFirm(MemVO memVo) {
		return this.adminMapper.permitFirm(memVo);
	}

	@Override
	public String getPermitRg(String entNo) {
		return this.adminMapper.getPermitRg(entNo);
	}

	@Override
	public List<BoardVO> getBoardList(Map<String, String> map) {
		return this.adminMapper.getBoardList(map);
	}

	@Override
	public int boardTotal(Map<String, String> map) {
		return this.adminMapper.boardTotal(map);
	}

	@Override
	public BoardVO boardDetail(BoardVO boardVo) {

		return this.adminMapper.boardDetail(boardVo);
	}

	@Override
	public int insertContent(Map<String, String> map) {

		return this.adminMapper.insertContent(map);
	}

	@Override
	public int modifyContent(Map<String, String> map) {

		return this.adminMapper.modifyContent(map);
	}

	@Override
	public int boardDelete(BoardVO boardVo) {

		return this.adminMapper.boardDelete(boardVo);
	}

	@Override
	public int commentDelete(BoardCommentVO commentVo) {

		return this.adminMapper.commentDelete(commentVo);
	}

	@Override
	public int createCmt(BoardCommentVO cntVo) {

		return this.adminMapper.createCmt(cntVo);
	}

	@Override
	public int cmtOneDelet(BoardCommentVO commentVo) {

		return this.adminMapper.cmtOneDelet(commentVo);
	}

	@Override
	public EnterpriseVO getEnterPriceDetail(EnterpriseVO entVo) {

		return this.adminMapper.getEnterPriceDetail(entVo);
	}

	@Override
	public JobPostingVO getPosting(JobPostingVO jobPostingVo) {

		return this.adminMapper.getPosting(jobPostingVo);
	}

	@Override
	public List<ReportVO> getreportList(Map<String, String> map) {
		return this.adminMapper.getreportList(map);
	}

	@Override
	public int getReportTotal(Map<String, String> map) {
		return this.adminMapper.getReportTotal(map);
	}

	@Override
	public int blockFinish(String rptNo) {

		return this.adminMapper.blockFinish(rptNo);
	}

	@Override
	public int getlectureTotal(Map<String, String> map) {

		return this.adminMapper.getlectureTotal(map);
	}

	@Override
	public List<LectureVO> getLectureList(Map<String, String> map) {

		return this.adminMapper.getLectureList(map);
	}

	@Override
	public LectureVO getLecturSerise(String lctNo) {

		return this.adminMapper.getLecturSerise(lctNo);
	}

	@Override
	public String goLecture(LectureSeriesVO lectureSeriesVo) {

		return this.adminMapper.goLecture(lectureSeriesVo);
	}

	@Override
	public int lectureModify(LectureSeriesVO lectuerseriseVO) {

		return this.adminMapper.lectureModify(lectuerseriseVO);
	}

	@Override
	public int updatePrmmTitle(Map<String, String> map1) {

		return this.adminMapper.updatePrmmTitle(map1);
	}

	@Override
	public int updateLctInstrNm(Map<String, String> map) {

		return this.adminMapper.updateLctInstrNm(map);
	}

	@Override
	public int insertLectureSerise(Map<String, String> map) {

		return this.adminMapper.insertLectureSerise(map);
	}

	@Override
	public int insertAtt(Map<String, String> map) {

		return this.adminMapper.insertAtt(map);
	}

	@Override
	public int updateLectureSerise(Map<String, String> map) {

		return this.adminMapper.updateLectureSerise(map);
	}

	@Override
	public int updateLectureAtt(Map<String, String> map) {

		return this.adminMapper.updateLectureAtt(map);
	}

	@Override
	public int deletePrmm(String prmmNo) {

		return this.adminMapper.deletePrmm(prmmNo);
	}

	@Override
	public int deleteLct(String prmmNo) {

		return this.adminMapper.deleteLct(prmmNo);
	}

	@Override
	public int deleteAtt(String prmmNo) {

		return this.adminMapper.deleteAtt(prmmNo);
	}

	@Override
	public int deleteSrsAll(String prmmNo) {

		return this.adminMapper.deleteSrsAll(prmmNo);
	}

	@Override
	public int insertPrmm(PremiumVO premiumVO) {

		return this.adminMapper.insertPrmm(premiumVO);
	}

	@Override
	public int insertLct(LectureVO lectureVO) {

		return this.adminMapper.insertLct(lectureVO);
	}

	@Override
	public int getSpecialTotal(Map<String, String> map) {

		return this.adminMapper.getSpecialTotal(map);
	}

	@Override
	public List<LectureVO> getSpecialList(Map<String, String> map) {

		return this.adminMapper.getSpecialList(map);
	}

	@Override
	public int insertPrmmSpc(PremiumVO premiumVO) {

		return this.adminMapper.insertPrmmSpc(premiumVO);
	}

	@Override
	public int insertLctSpc(LectureVO lectureVO) {

		return this.adminMapper.insertLctSpc(lectureVO);
	}

	@Override
	public int getIntershipTotal(Map<String, String> map) {

		return this.adminMapper.getIntershipTotal(map);
	}

	@Override
	public List<InternshipVO> getInsternshipList(Map<String, String> map) {

		return this.adminMapper.getInsternshipList(map);
	}

	@Override
	public InternshipVO internshipDetail(String prmmNo) {

		return this.adminMapper.internshipDetail(prmmNo);
	}

	@Override
	public int noPermit(String itnsNo) {

		return this.adminMapper.noPermit(itnsNo);
	}

	@Override
	public List<InternshipVO> internshipRequestList(Map<String, String> map) {

		return this.adminMapper.internshipRequestList(map);
	}

	@Override
	public int internshipRequestTotal(Map<String, String> map) {

		return this.adminMapper.internshipRequestTotal(map);
	}

	@Override
	public int permitInternship(String itnsNo) {

		return this.adminMapper.permitInternship(itnsNo);
	}

	@Override
	public List<AttachmentVO> getMemProfile(MemVO memVo) {

		return this.adminMapper.getMemProfile(memVo);
	}

	@Override
	public int deleteSrs(String lctSrsNo) {

		return this.adminMapper.deleteSrs(lctSrsNo);
	}

	@Override
	public List<AttachmentVO> getFirmAttNm(MemVO memVo) {

		return this.adminMapper.getFirmAttNm(memVo);

	}

	@Override
	public int postedTotal(EnterpriseMemVO enterpriseMemVo) {
		return this.adminMapper.postedTotal(enterpriseMemVo);
	}

	@Override
	public List<JobPostingVO> getjobPostedList(Map<String, String> map) {

		return this.adminMapper.getjobPostedList(map);
	}

	@Override
	public List<JobPostingVO> getjobPostList(Map<String, String> map) {

		return this.adminMapper.getjobPostList(map);
	}

	@Override
	public int jobPostedTotal(Map<String, String> map) {

		return this.adminMapper.jobPostedTotal(map);
	}

	@Override
	public int permitJobpost(JobPostingVO jobPostingVo) {

		return this.adminMapper.permitJobpost(jobPostingVo);
	}

	@Override
	public int noPermitJobpost(JobPostingVO jobPostingVo) {

		return this.adminMapper.noPermitJobpost(jobPostingVo);
	}

	@Override
	public int reportBoardTotal(Map<String, String> map) {
		return this.adminMapper.reportBoardTotal(map);
	}

	@Override
	public List<ReportVO> reportBoardList(Map<String, String> map) {

		return this.adminMapper.reportBoardList(map);
	}

	@Override
	public int deleteSrsAtt(String lctSrsNo) {

		return this.adminMapper.deleteSrsAtt(lctSrsNo);
	}

	@Override
	public int bReportPrcs(List<String> prcsList) {
		int result = 0;
		for(String prcs : prcsList) {
			result += this.adminMapper.bReportPrcs(prcs);
		}
		return result;
	}

	@Override
	public int bReportNonPrcs(List<String> prcsList) {
		int result = 0;
		for(String prcs : prcsList) {
			result += this.adminMapper.bReportNonPrcs(prcs);
		}
		return result;
	}

	@Override
	public List<CommonCodeVO> getTeacher() {

		return this.adminMapper.getTeacher();
	}

	@Override
	public int deleteBg(String prmmNo) {

		return this.adminMapper.deleteBg(prmmNo);
	}




}
