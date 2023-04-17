package kr.or.ddit.admin.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonCreator.Mode;
import com.google.gson.JsonObject;

import kr.or.ddit.admin.service.AdminService;
import kr.or.ddit.board.controller.BoardController;
import kr.or.ddit.common.service.AttachService;
import kr.or.ddit.vo.ArticlePage;
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
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin")
public class adminController {
	@Autowired
	AdminService adminService;
	@Autowired
	AttachService<PremiumVO> attchService;
	// 요청URI : /localhost/admin/nomalList
	// 일반회원 관리 페이지


	@GetMapping("/statistics")
	public String adminStatistics(Model modle) {

		return "admin/statistics";
	}

	/**
	 * @param keyword : 검색어
	 * @param searchType : 검색 타입
	 * @param currentPage : 페이지 번호
	 * @param memVO : 멤버
	 * @param model
	 * @param principal : 계정 정보
	 * @return : 일반 회원 정보 반환
	 */

	@GetMapping("/nomalList")
	public String nomalList(
			  @RequestParam(value = "keyword", required=false, defaultValue = "") String keyword
			, @RequestParam(value = "searchType", required=false, defaultValue = "name") String searchType
			, @RequestParam(value = "currentPage", required=false, defaultValue = "1") int currentPage
			, MemVO memVO
			, Model model
			, Principal principal
			) {
		log.info("일반회원 관리 페이지");
		if(principal==null) {
			return "redirect:/login";
		}
		Map<String, String> map = new HashMap<String, String>();
		// 검색한 값의 총 개수
		log.info(currentPage+"");
		int size = 10;
		// 맵에 넣기
		map.put("size", size+"");
		map.put("searchType", searchType);
		map.put("currentPage",currentPage+"");
		log.info(keyword);
		map.put("keyword", keyword);
		List<MemVO> nomalList2 = this.adminService.nomalList2(map);
		log.info("nomalList2 : "+nomalList2);
		// MemVO 형태의 목록을 리스트로 받는다.
		int total = this.adminService.getTotal(map);
		log.info("검색한 값의 총 개수 : " + total);

		// 받은 후 model로 전달 한다.
		model.addAttribute("data", new ArticlePage<MemVO>(total, currentPage, size, nomalList2));
		// forwarding
		return "admin/nomalList";
	}

	/**
	 *
	 * @param memVo : 멤버 아이디 값을 받음
	 * @return : 멤버 정보를 리턴함
	 */

	@ResponseBody
	@PostMapping("/getMemDetail")
	public MemVO getMemDetail(@RequestBody MemVO memVo) {
		log.info("getMemDetail로 옴");
		log.info(memVo+"");
		memVo = this.adminService.getMemDetail(memVo);
		log.info(memVo+"");
		// 해당 회원의 멤버십 여부를 가지고온다.
		MemVO memVO2 = this.adminService.isVip(memVo);
		String vip = "";
		String vipGrade = "";
		if( memVO2==null ) {
			vip = "멤버십 미결제";
			vipGrade = "";
		} else {
			vip = memVO2.getVip();
			vipGrade = memVO2.getVipGrade();
		}

		memVo.setVip(vip);
		memVo.setVipGrade(vipGrade);
		log.info("memVo : "+memVo);
		List<AttachmentVO> attNm = this.adminService.getMemProfile(memVo);
		memVo.setBoardAttVOList(attNm);

		return memVo;
	}

	/**
	 *
	 * @param memId : 차단할 회원 아이디
	 * @return : 회원 차단 후 일반 회원 관리 페이지로 이동
	 */

	@GetMapping("/blockMem")
	public String blockMem(	@RequestParam String memId) {
		MemVO memVo = new MemVO();
		log.info("회원 차단하러 왔어요 : " + memId);
		memVo.setMemId(memId);
		int update = this.adminService.blockMem(memVo);
		log.debug("차단됨? : " + update);
		return "redirect:/admin/nomalList";
	}

	/**
	 *
	 * @param memId : 아이디 값을 받는다.
	 * @param mCurrentPage : 띄우고 싶은 페이지 번호
	 * @return : ArticlePage<JobPostingVO>
	 */
	@ResponseBody
	@PostMapping("/getjobPostingList")
	public ArticlePage<JobPostingVO> getjobPostingList(@RequestParam String memId
			                                         , @RequestParam int mCurrentPage) {
		// ajax로 값을 받아온다. 첫페이지는 1이니까 1을 받는다.
		log.info("----------------- memId : "+memId);
		MemVO memVO = new MemVO();
		memVO.setMemId(memId);
		Map<String, String> map = new HashMap<String, String>();

		int mSize = 10;
		int mTotal = this.adminService.getMTotal(memVO);

		log.info("mTotal : "+mTotal);

		map.put("memId", memId);
		map.put("mSize", mSize+"");
		map.put("mCurrentPage", mCurrentPage+"");
		List<JobPostingVO> getjobPostintList2 = this.adminService.getjobPostingList2(map);
		ArticlePage<JobPostingVO> currentJobList =
				new	ArticlePage<JobPostingVO>(mTotal, mCurrentPage, mSize, getjobPostintList2);

		return currentJobList;
	}

	/**
	 *
	 * @param memId : id 값을 받는다.
	 * @param mCurrentPage : 현제 페이지
	 * @return : ArticlePage<JobPostingVO> 페이지 정보 반환
	 */
	@ResponseBody
	@PostMapping("/getjobPostedList")
	public ArticlePage<JobPostingVO> getjobPostedList(@RequestParam String memId
			, @RequestParam int mCurrentPage) {
		// ajax로 값을 받아온다. 첫페이지는 1이니까 1을 받는다.
//		List<JobPostingVO> jobPostingList = this.adminService.getjobPostingList(memVO);
		log.info("----------------- memId : "+memId);
		EnterpriseMemVO enterpriseMemVo = new EnterpriseMemVO();
		enterpriseMemVo.setMemId(memId);
		Map<String, String> map = new HashMap<String, String>();
		int mSize = 10;
		log.debug("enterpriseMemVo:::::::::::::::::::::{}",enterpriseMemVo);
		int mTotal = this.adminService.postedTotal(enterpriseMemVo);
		log.debug("mTotal : {}",mTotal);
		map.put("memId", memId);
		map.put("mSize", mSize+"");
		map.put("mCurrentPage", mCurrentPage+"");
		List<JobPostingVO> getjobPostedList = this.adminService.getjobPostedList(map);
		ArticlePage<JobPostingVO> currentJobList = new	ArticlePage<JobPostingVO>(mTotal, mCurrentPage, mSize, getjobPostedList);

		log.debug("currentJobList:::::::::::::::::::::::{}",currentJobList);

		return currentJobList;
	}

	/**
	 *
	 * @param entNo 기업 번호
	 * @param entVo 기업 VO
	 * @param model
	 * @return : 기업 리스트로 반환
	 */
	@GetMapping("/firmDetail")
	public String firmDetail( @RequestParam(value = "entNo") String entNo
			                  , EnterpriseVO entVo
			                  , Model model) {
		entVo.setEntNo(entNo);
		entVo = this.adminService.getEnterPriceDetail(entVo);
		log.info("entNo : " + entNo);
		log.info(entVo+"");
		model.addAttribute("data",entVo);
		return "admin/firmDetail";
	}

	/**
	 *
	 * @param jobPstgNo : 채용공고 번호
	 * @param jobPostingVo : 채용공고 VO
	 * @param model
	 * @return : 채용공고 상세 정보로 이동
	 */
	@GetMapping("/jobPostingDetail")
	public String jobPostingDetail( @RequestParam(value = "jobPstgNo") String jobPstgNo
			                      , JobPostingVO jobPostingVo
			                       , Model model) {
		jobPostingVo.setJobPstgNo(jobPstgNo);
		jobPostingVo = this.adminService.getPosting(jobPostingVo);
		log.info("jobPostingVo : " + jobPostingVo);
		model.addAttribute("data",jobPostingVo);
		return "admin/jobPostingDetail";
	}

	/**
	 *
	 * @param keyword : 검색어
	 * @param searchType : 검색할 타입
	 * @param currentPage : 페이지 번호
	 * @param memVO : 회원 VO
	 * @param model
	 * @return : 차단 회원 리스트
	 */
	@GetMapping("/blockList")
	public String blockList( @RequestParam(value = "keyword", required=false, defaultValue = "") String keyword
			, @RequestParam(value = "searchType", required=false, defaultValue = "name") String searchType
			, @RequestParam(value = "currentPage", required=false, defaultValue = "1") int currentPage
			, MemVO memVO
			, Model model) {

		log.info("차단회원 관리 페이지");
		Map<String, String> map = new HashMap<String, String>();
		// 검색한 값의 총 개수

		log.info(currentPage+"");
		int size = 10;

		// 맵에 넣기
		map.put("size", size+"");
		map.put("searchType", searchType);
		map.put("currentPage",currentPage+"");
		log.info(keyword);
		map.put("keyword", keyword);

		List<MemVO> blockList = this.adminService.blockList(map);

		int total = this.adminService.getBlockTotal(map);
		log.info("검색한 값의 총 개수 : " + total);

		// 받은 후 model로 전달 한다.
		model.addAttribute("data", new ArticlePage<MemVO>(total, currentPage, size, blockList));

		return "admin/blockList";
	}

	/**
	 *
	 * @param memId : 회원 아이디
	 * @return : 회원 차단해제 후 일반회원 관리로 이동
	 */
	@GetMapping("/nonBlockMem")
	public String nonBlockMem(
			@RequestParam String memId) {

		MemVO memVo = new MemVO();
		log.info("회원 차단해제하러 왔어요 : " + memId);
		memVo.setMemId(memId);
		int update = this.adminService.nonBlockMem(memVo);
		return "redirect:/admin/blockList";
	}

	/**
	 *
	 * @param memId : 회원 아이디
	 * @return : 회원 차단 후 일반회원 페이지로 이동
	 */
	@GetMapping("/noBlockMem")
	public String noBlockMem(
			@RequestParam String memId) {

		MemVO memVo = new MemVO();
		log.info("회원 차단해제하러 왔어요 : " + memId);
		memVo.setMemId(memId);
		int update = this.adminService.nonBlockMem(memVo);
		return "redirect:/admin/nomalList";
	}

	/**
	 *
	 * @param memId : 회원 아이디
	 * @param currentPage : 페이지 번호
	 * @return
	 */
	@ResponseBody
	@PostMapping("/getblockDetail")
	public ArticlePage<MemVO> getblockDetail(@RequestParam String memId
			, @RequestParam int currentPage) {
		MemVO memVO = new MemVO();
		memVO.setMemId(memId);

		Map<String, String> map = new HashMap<String, String>();
		int size = 10;
		int total = this.adminService.reportTotal(memVO);

		log.info("total : " + total);

		map.put("memId",memVO.getMemId());
		map.put("size",size+"");
		map.put("currentPage",currentPage+"");

		List<MemVO> reportPage = this.adminService.reportPage(map);

		log.info("reportPage : "+reportPage);

		ArticlePage<MemVO> reportList = new ArticlePage<MemVO>(total, currentPage, size, reportPage);
		return reportList;
	}

	/**
	 *
	 * @param keyword : 검색어
	 * @param searchType : 검색 타입
	 * @param currentPage : 페이지 번호
	 * @param memVO : 멤버
	 * @param model
	 * @return : 기업 회원 리스트로 이동
	 */
	@GetMapping("/firmList")
	public String firmList(
			  @RequestParam(value = "keyword", required=false, defaultValue = "") String keyword
			, @RequestParam(value = "searchType", required=false, defaultValue = "name") String searchType
			, @RequestParam(value = "currentPage", required=false, defaultValue = "1") int currentPage
			, MemVO memVO , Model model) {

		log.info("기업회원 관리 페이지");
		Map<String, String> map = new HashMap<String, String>();
		// 검색한 값의 총 개수
		log.info(currentPage+"");
		int size = 10;

		// 맵에 넣기
		map.put("size", size+"");
		map.put("searchType", searchType);
		map.put("currentPage", currentPage+"");
		log.info(keyword);
		map.put("keyword", keyword);
		int total = this.adminService.firmAllTotal(map);

		map.put("total", total+"");

		List<EnterpriseVO> firmList = this.adminService.firmList(map);
		log.info("firmList : " + firmList);


		log.info("total: "+total);

		model.addAttribute("data", new ArticlePage<EnterpriseVO>(total, currentPage, size, firmList));

		return "admin/firmList";
	}

	/**
	 *
	 * @param memVo : 회원 아이디
	 * @return : 회원 정보 반환
	 */
	@ResponseBody
	@PostMapping("/getFirmDetail")
	public MemVO getFirmDetail(@RequestBody MemVO memVo) {
		log.info("getFirmDetail로 옴");
		log.debug("왜 널이 들어오는 거냐고!!!!!!!!!!{}",memVo);
		memVo = this.adminService.getFirmDetail(memVo);
		// 해당 회원의 멤버십 여부를 가지고온다.
		log.debug("대체 뭐가 나오는 건데 !!!!! : {}", memVo);
		MemVO memVo2 = this.adminService.isVip(memVo);
		String vip = "";
		String vipGrade = "";

		if(memVo2 == null) {
			vip = "멤버십 미결제";
			vipGrade = "";
		} else {
			vip= memVo2.getVip();
			vipGrade = memVo2.getVipGrade();
		}

		memVo.setVip(vip);
		memVo.setVipGrade(vipGrade);

		log.info(memVo+"");

		List<AttachmentVO> attNm = this.adminService.getFirmAttNm(memVo);
		memVo.setBoardAttVOList(attNm);

		return memVo;
	}

	/**
	 *
	 * @param memId
	 * @return 사용 안함
	 */
	@GetMapping("/blockFirm")
	public String blockFirm(
			@RequestParam String memId) {

		MemVO memVo = new MemVO();
		log.info("기업 회원 차단하러 왔어요 : " + memId);
		memVo.setMemId(memId);
		int update = this.adminService.blockMem(memVo);
		return "redirect:/admin/firmList";
	}

	/**
	 *
	 * @param keyword
	 * @param searchType
	 * @param currentPage
	 * @param memVO
	 * @param model
	 * @return
	 */
	@GetMapping("/blockFirmList")
	public String blockFirmList(  @RequestParam(value = "keyword", required=false, defaultValue = "") String keyword
			, @RequestParam(value = "searchType", required=false, defaultValue = "name") String searchType
			, @RequestParam(value = "currentPage", required=false, defaultValue = "1") int currentPage
			, MemVO memVO , Model model) {

		log.info("기업회원 관리 페이지");
		Map<String, String> map = new HashMap<String, String>();
		// 검색한 값의 총 개수
		log.info(currentPage+"");
		int size = 10;
		// 맵에 넣기
		map.put("size", size+"");
		map.put("auth", "ROLE_BLOCK");
		map.put("searchType", searchType);
		map.put("currentPage",currentPage+"");
		log.info(keyword);
		map.put("keyword", keyword);
		List<EnterpriseVO> blockFirmList = this.adminService.blockFirmList(map);
		log.info("firmList : " + blockFirmList);
		int total = this.adminService.blockFirmAllTotal(map);
		log.info("total: "+total);
		model.addAttribute("data", new ArticlePage<EnterpriseVO>(total, currentPage, size, blockFirmList));
		return "admin/blockFirmList";
	}

	@ResponseBody
	@PostMapping("/getBlockFirmDetail")
	public MemVO getBlockFirmDetail(@RequestBody MemVO memVo) {
		log.info("getBlockFirmDetail로 옴");
		log.info(memVo+"");
		memVo = this.adminService.getBlockFirmDetail(memVo);
		log.info(memVo+"");
		// 해당 회원의 멤버십 여부를 가지고온다.
		return memVo;
	}

	@GetMapping("/permitRequest")
	public String permitRequest(@RequestParam(value = "keyword", required=false, defaultValue = "") String keyword
			, @RequestParam(value = "searchType", required=false, defaultValue = "name") String searchType
			, @RequestParam(value = "currentPage", required=false, defaultValue = "1") int currentPage
			, MemVO memVO, Model model) {
		log.info("요청 승인 페이지로 옴");
		Map<String, String> map = new HashMap<String, String>();
		// 검색한 값의 총 개수
		log.info(currentPage+"");
		int size = 5;
		// 맵에 넣기
		map.put("size", size+"");
		map.put("auth", "기업회원");
		map.put("searchType", searchType);
		map.put("currentPage",currentPage+"");
		log.info(keyword);
		map.put("keyword", keyword);
		List<EnterpriseVO> permitRequestList = this.adminService.permitRequestList(map);
		log.info("permitRequestList : " + permitRequestList);
		int total = this.adminService.allRequest(map);
		log.info("total: "+total);
		model.addAttribute("data", new ArticlePage<EnterpriseVO>(total, currentPage, size, permitRequestList));
		return "admin/permitRequest";
	}

	@GetMapping("/resolveBlockFirm")
	public String resolveBlockFirm(
			@RequestParam String memId) {
		MemVO memVo = new MemVO();
		log.info("기업 회원 차단하러 왔어요 : " + memId);
		memVo.setMemId(memId);
		int update = this.adminService.resolveBlockFirm(memVo);
		return "redirect:/admin/blockFirmList";
	}

	@GetMapping("/permitFirm")
	public String permitFirm(
			@RequestParam String memId) {
		MemVO memVo = new MemVO();
		log.info("기업 회원 승인하러 왔어요 : " + memId);
		memVo.setMemId(memId);
		int update = this.adminService.permitFirm(memVo);
		return "redirect:/admin/permitRequest";
	}

	@ResponseBody
	@PostMapping("/getPermitRg")
	public String getPermitRg(@RequestParam String entNo) throws UnsupportedEncodingException {
		log.info("contentType: 'application/json; charset=utf-8',");
		log.debug("인증서 파일경로:{}",entNo);
		String path = "";
		path = this.adminService.getPermitRg(entNo);
		log.debug("인증서 파일경로:{}",path);
		// 해당 회원의 멤버십 여부를 가지고온다.
		path = URLEncoder.encode(path, "utf-8");
		return path;
	}

	@GetMapping("/manageCumunity")
	public String manageCumunity(
			  @RequestParam(value = "keyword", required=false, defaultValue = "") String keyword
			, @RequestParam(value = "searchType", required=false, defaultValue = "title") String searchType
			, @RequestParam(value = "currentPage", required=false, defaultValue = "1") int currentPage
			, MemVO memVO, Model model) {

		String boardClfcNo = "BRDCL0003";
		log.info("searchType:"+searchType);
		Map<String,	String> map = new HashMap<String, String>();
		int size = 10;
		map.put("boardClfcNo",boardClfcNo);
		map.put("keyword",keyword);
		map.put("searchType",searchType);
		map.put("currentPage",currentPage+"");
		int total = this.adminService.boardTotal(map);
		log.info("total:"+total);
		map.put("total",total+"");
		map.put("size",size+"");
		List<BoardVO> list = this.adminService.getBoardList(map);
		log.info("list:" + list);
		model.addAttribute("list" , list);
		model.addAttribute("data", new ArticlePage<BoardVO>(total, currentPage, size, list));

		return "admin/manageCumunity";
	}

	@GetMapping("/noticeBoard")
	public String noticeBoard(
			  @RequestParam(value = "keyword", required=false, defaultValue = "") String keyword
			, @RequestParam(value = "searchType", required=false, defaultValue = "title") String searchType
			, @RequestParam(value = "currentPage", required=false, defaultValue = "1") int currentPage
			, MemVO memVO, Model model) {
		String boardClfcNo = "BRDCL0001";

		log.info("searchType:"+searchType);
		Map<String,	String> map = new HashMap<String, String>();
		int size = 10;
		map.put("boardClfcNo",boardClfcNo);
		map.put("keyword",keyword);
		map.put("searchType",searchType);
		map.put("currentPage",currentPage+"");
		int total = this.adminService.boardTotal(map);
		log.info("total:"+total);
		map.put("total",total+"");
		map.put("size",size+"");
		List<BoardVO> list = this.adminService.getBoardList(map);
		log.info("list:" + list);
		model.addAttribute("list" , list);
		ArticlePage<BoardVO> pageList = new ArticlePage<BoardVO>(total, currentPage, size, list);
		log.info(pageList.getContent()+"");
		model.addAttribute("data",pageList);
		return "admin/noticeBoard";
	}


	@GetMapping("/questBoard")
	public String questBoard(
			  @RequestParam(value = "keyword", required=false, defaultValue = "") String keyword
			, @RequestParam(value = "searchType", required=false, defaultValue = "title") String searchType
			, @RequestParam(value = "currentPage", required=false, defaultValue = "1") int currentPage
			, MemVO memVO, Model model) {
		String boardClfcNo = "BRDCL0004";
		Map<String,	String> map = new HashMap<String, String>();
		int size = 10;
		map.put("boardClfcNo",boardClfcNo);
		map.put("keyword",keyword);
		map.put("searchType",searchType);
		map.put("currentPage",currentPage+"");
		int total = this.adminService.boardTotal(map);
		log.info("total:"+total);
		map.put("total",total+"");
		map.put("size",size+"");
		List<BoardVO> list = this.adminService.getBoardList(map);
		log.info("list:" + list);
		model.addAttribute("list" , list);
		model.addAttribute("data", new ArticlePage<BoardVO>(total, currentPage, size, list));
		return "admin/questBoard";
	}

	@GetMapping("/faqBoard")
	public String faqBoard(
			  @RequestParam(value = "keyword", required=false, defaultValue = "") String keyword
			, @RequestParam(value = "searchType", required=false, defaultValue = "title") String searchType
			, @RequestParam(value = "currentPage", required=false, defaultValue = "1") int currentPage
			, MemVO memVO, Model model) {

		String boardClfcNo = "BRDCL0002";
		Map<String,	String> map = new HashMap<String, String>();
		int size = 10;
		map.put("boardClfcNo",boardClfcNo);
		map.put("keyword",keyword);
		map.put("searchType",searchType);
		map.put("currentPage",currentPage+"");
		int total = this.adminService.boardTotal(map);
		log.info("total:"+total);
		map.put("total",total+"");
		map.put("size",size+"");
		List<BoardVO> list = this.adminService.getBoardList(map);
		log.info("list:" + list);
		model.addAttribute("list" , list);
		model.addAttribute("data", new ArticlePage<BoardVO>(total, currentPage, size, list));
		return "admin/faqBoard";
	}

	@GetMapping("/reportBoard")
	public String reportBoard(    @RequestParam(value = "keyword", required=false, defaultValue = "") String keyword
								, @RequestParam(value = "searchType", required=false, defaultValue = "title") String searchType
								, @RequestParam(value = "currentPage", required=false, defaultValue = "1") int currentPage
								, Model model) {
		int size = 10;
		Map<String,	String> map = new HashMap<String, String>();
		map.put("keyword",keyword);
		map.put("searchType",searchType);
		map.put("currentPage",currentPage+"");
		int total = this.adminService.reportBoardTotal(map);
		map.put("total", total+"");
		map.put("size", size+"");
		List<ReportVO> list = this.adminService.reportBoardList(map);
		ArticlePage<ReportVO> page = new ArticlePage<ReportVO>(total,currentPage, size, list);
		model.addAttribute("data",page);

		return "admin/reportBoard";
	}

	@GetMapping("/boardDetail")
	public String boardDetail(@RequestParam(value = "boardNo") String boardNo
							  , BoardVO boardVo
							  , Model model) {

		String goPath = "admin/boardDetail";

		log.info(boardNo);
		boardVo.setBoardNo(boardNo);
		boardVo = this.adminService.boardDetail(boardVo);
		log.debug("boardVo: {}", boardVo);
		model.addAttribute("boardVo",boardVo);

		if( (boardNo == null) || (boardNo.equals("")) ) {
			goPath = "admin/noBoardDetail";
		}


		return goPath;
	}

	@RequestMapping(value="/uploadSummernoteImageFile", produces = "application/json; charset=utf8")
	@ResponseBody
	public String uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile, HttpServletRequest request )  {
		JsonObject jsonObject = new JsonObject();
		// 내부경로로 저장
		String contextRoot = new HttpServletRequestWrapper(request).getRealPath("/");
//		String fileRoot = "C:/eGovFrameDev-3.10.0-64bit/workspace/Catch/src/main/webapp/resources/images/"+getFolder()+"/";
		String fileRoot = "C:\\eGovFrameDev-3.10.0-64bit\\workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\Catch\\resources\\images\\"+getFolder()+"/";
		// 오늘 날짜로 폴더 만들기 시작-----------------------
		File uploadPath = new File(fileRoot);
		if(uploadPath.exists()==false) {
			uploadPath.mkdirs();
		}
		// 오늘 날짜로 폴더 만들기 끝-----------------------
		// fileRoot를 저 경로에서 뒤에 오늘 날짜를 기준으로 만든 디렉토리 폴더를 만드는 함수와  그 폴더 경로 값만 변수에 저장해서 뒤에 이어 주자...ㅜㅜ
		String originalFileName = multipartFile.getOriginalFilename();	//오리지날 파일명
		String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//파일 확장자
		String savedFileName = UUID.randomUUID() + extension;	//저장될 파일 명
		File targetFile = new File(fileRoot + savedFileName);
		try {
			InputStream fileStream = multipartFile.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile);	//파일 저장
//			jsonObject.addProperty("url", "C:/eGovFrameDev-3.10.0-64bit/workspace/Catch/src/main/webapp/resources/images/"+savedFileName); // contextroot + resources + 저장할 내부 폴더명
			String temp = getFolder() + "/" + savedFileName;
			log.info("temp : " + temp);
			jsonObject.addProperty("url", "/resources/images/"+temp); // contextroot + resources + 저장할 내부 폴더명
			// 저장할 내부 폴더 명이 바로 위에서 말한 오늘 날짜를 기준으로 만든 폴더 명이 이름 뒤에 들어 오면 된다.
			jsonObject.addProperty("responseCode", "success");

		} catch (IOException e) {
			FileUtils.deleteQuietly(targetFile);	//저장된 파일 삭제
			jsonObject.addProperty("responseCode", "error");
			e.printStackTrace();
		}
		String a = jsonObject.toString();
		return a;
	}

	@PostMapping("/insertContent")
	public String insertContent(@RequestParam(value = "editordata", required = false) String content
								, @RequestParam(value = "title", required = false) String title
								, @RequestParam(value = "boardType") String boardType
								, Principal principal) {
		Map<String, String> map = new HashMap<String, String>();
		String id = principal.getName();

		map.put("content", content);
		log.info("content"+content);
		map.put("title", title);
		log.info("title"+content);
		map.put("boardType", boardType);
		log.info("boardType:"+boardType);
		log.info("map: " + map);
		map.put("adminId", id);
		log.info(id);
		int insert = this.adminService.insertContent(map);
		log.info(insert+"");
		String ret = "";
		if(boardType.equals("BRDCL0001")) {
			ret ="redirect:/admin/noticeBoard";
		} else if(boardType.equals("BRDCL0002")) {
			ret ="redirect:/admin/faqBoard";
		} else if(boardType.equals("BRDCL0003")) {
			ret ="redirect:/admin/manageCumunity";
		} else if(boardType.equals("BRDCL0004")) {
			ret ="redirect:/admin/questBoard";
		}
		log.info(ret);
		return ret;
	}

	@PostMapping("/modifyContent")
	public String modifyContent(@RequestParam(value = "editordata", required = false) String content
								, @RequestParam(value = "title", required = false) String title
								, @RequestParam(value = "boardType") String boardType
								, @RequestParam(value = "boardNo") String boardNo) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("content", content);
		log.info("content"+content);
		map.put("title", title);
		log.info("title"+content);
		map.put("boardType", boardType);
		log.info("boardType:"+boardType);
		map.put("boardNo", boardNo);
		log.info("boardNo:"+boardNo);
		log.info("map: " + map);
		int update = this.adminService.modifyContent(map);
		log.info("update : "+update);
		String ret = "";
		ret ="redirect:/admin/boardDetail?boardNo=" + boardNo;
		log.info(ret);
		return ret;
	}

	@GetMapping("/createBoard")
	public String createBoard(@RequestParam(value = "boardType") String boardType
			                  , Model model) {
		model.addAttribute("boardType", boardType);
		return "admin/createBoard";
	}

	@GetMapping("/boardModify")
	public String boardModify(@RequestParam(value = "boardType", required = false) String boardType
							  , @RequestParam(value = "boardNo") String boardNo
							  , BoardVO boardVo
			                  , Model model) {
		boardVo.setBoardNo(boardNo);
		boardVo = this.adminService.boardDetail(boardVo);
		log.info("boardVo:" + boardVo);
		model.addAttribute("boardVo",boardVo);
		return "admin/boardModify";
	}

	@GetMapping("/boardDelete")
	public String boardDelete(  @RequestParam(value = "boardType", required = false) String boardType
							  , @RequestParam(value = "boardNo") String boardNo
							  , BoardVO boardVo
							  , BoardCommentVO commentVo
			                  , Model model ) {
		boardVo.setBoardNo(boardNo);
		int delete = this.adminService.boardDelete(boardVo);
		commentVo.setBoardNo(boardNo);
		int commentDelete = this.adminService.commentDelete(commentVo);
		log.info("boardVo:" + boardVo);
		String ret = "";
		log.info("Delete boardType:" + boardType);

		if(boardType.equals("BRDCL0001")) {
			ret = "redirect:/admin/noticeBoard";
		} else if(boardType.equals("BRDCL0002")) {
			ret = "redirect:/admin/faqBoard";
		} else if(boardType.equals("BRDCL0003")) {
			ret = "redirect:/admin/manageCumunity";
		} else if(boardType.equals("BRDCL0004")) {
			ret = "redirect:/admin/questBoard";
		}
		return ret;
	}

	@PostMapping("/createCmt")
	public String createCmt(@RequestParam(value = "boardNo" ) String boardNo
			                , @RequestParam(value = "content") String content
			                , Principal principal
			                , BoardCommentVO cntVo) {
		String id = principal.getName();
		cntVo.setBoardNo(boardNo);
		cntVo.setCmntContent(content);
		cntVo.setMemId(id);
		int create = this.adminService.createCmt(cntVo);
		return "redirect:/admin/boardDetail?boardNo="+boardNo;
	}

	@GetMapping("/cmtDelete")
	public String cmtDelete(  @RequestParam(value = "boardNo", required = false) String boardNo
							  , @RequestParam(value = "commentNo") String commentNo
							  , BoardCommentVO commentVo
			                  , Model model ) {
		commentVo.setCmntNo(commentNo);
		// 댓글 번호를 받아온다. ->
		// 해당 게시글의 기본키를 받아와야 한다.
		int commentDelete = this.adminService.cmtOneDelet(commentVo);
		log.info("commentDelete :" + commentDelete);
		//model.addAttribute("boardVo",boardVo);
		String ret ="";
		ret ="redirect:/admin/boardDetail?boardNo=" + boardNo;
		return ret;
	}



	@GetMapping("/reportList")
	public String reportList(
			                  @RequestParam(value = "keyword", required=false, defaultValue = "") String keyword
			                , @RequestParam(value = "searchType", required=false, defaultValue = "name") String searchType
			                , @RequestParam(value = "currentPage", required=false, defaultValue = "1") int currentPage
			                , @RequestParam(value = "tabName", required=false, defaultValue = "normal") String tabName
			                , ReportVO reportVO
		                    , Model model ) {
		log.info("reportList로 들어옴");
		log.info("reportVO : " + reportVO);

		Map<String, String> map = new HashMap<String, String>();
		map.put("auth","ROLE_NORMAL");
		map.put("keyword", keyword);
		map.put("searchType", searchType);
		map.put("currentPage", currentPage+"");

		int total = this.adminService.getReportTotal(map);
		int size = 10;
		map.put("size", size+"");

		List<ReportVO> nomalReportList = this.adminService.getreportList(map);
		// 일반회원 신고 리스트
		nomalReportList = this.adminService.getreportList(map);
		log.info("받아와라 일반회원 리스트   reportVO : " + nomalReportList);
		ArticlePage<ReportVO> nomalPage = new ArticlePage<ReportVO>(total,currentPage, size, nomalReportList);
		model.addAttribute("nomal", nomalPage);
		model.addAttribute("tabName",tabName);
		map.put("auth","ROLE_ENTERPRISE");
		// 기업 회원 신고 리스트
		List<ReportVO> enterpriseReportList = this.adminService.getreportList(map);
		log.info("받아와라 기업 회원 신고 리스트   enterpriseReportVO : " + enterpriseReportList);
		total = this.adminService.getReportTotal(map);
		ArticlePage<ReportVO> enterPage = new ArticlePage<ReportVO>(total,currentPage, size,enterpriseReportList);
		model.addAttribute("enterprise", enterPage);

		return "admin/reportList";
	}

	@GetMapping("/reportBlockMem")
	public String reportBlockMem(@RequestParam(value = "memId") String memId
			                   , @RequestParam(value = "rptNo") String rptNo
			                   ){
		MemVO memVo = new MemVO();
		memVo.setMemId(memId);
		int update = this.adminService.blockMem(memVo);
		log.debug("rptNOOOOOOOOOOOOOOOOOOOOOOOOO::{}",rptNo);
		int report = this.adminService.blockFinish(rptNo);

		return "redirect:localhost/admin/reportList";
	}

	@GetMapping("/premiumList")
	public String primeumList(
			  @RequestParam(value = "keyword", required=false, defaultValue = "") String keyword
			, @RequestParam(value = "isSpecial", required=false, defaultValue = "no") String isSpecial
			, @RequestParam(value = "searchType", required=false, defaultValue = "name") String searchType
			, @RequestParam(value = "currentPage", required=false, defaultValue = "1") int currentPage
			, LectureVO lecturVo, CommonCodeVO commonCodeVo
			, Model model) {

		log.info("searchType-------------------------"+searchType);
		log.info("keyword-------------------------"+keyword);
		log.info("currentPage-------------------------"+currentPage);


		List<CommonCodeVO> teacher = this.adminService.getTeacher();

		model.addAttribute("isSpecial", isSpecial);
		model.addAttribute("teacher", teacher);

		return "admin/premiumList";
	}

	@ResponseBody
	@PostMapping("/makeLecturePage")
	public ArticlePage<LectureVO> makeLecturePage(  @RequestParam String keyword
			                                      , @RequestParam int currentPage
			                                      , @RequestParam String searchType
			                                      , @RequestParam String kind
			                                      , @RequestParam String isPermit
			                                      , LectureVO lecturVo
			                                      , InternshipVO internshipVo) {
		int total = 0;
		int size = 9;
		List<LectureVO> list = null;
		List<InternshipVO> inturnList = null;
		ArticlePage<LectureVO> listPage = null;
		ArticlePage<InternshipVO> internshipPage = null;

		if(kind.equals("lecture")) {
			Map<String, String> map = new HashMap<String, String>();
			map.put("keyword",keyword);
			map.put("searchType",searchType);
			map.put("currentPage",currentPage+"");
			map.put("isPermit",isPermit);
			log.info("searchType이 잘들어왔니?"+searchType);
			log.info("keyword이 잘들어왔니?"+keyword);
			log.info("currentPage이 잘들어왔니?"+currentPage);
			total = this.adminService.getlectureTotal(map);
			log.info("total :::::::::: "+total);
			map.put("total",total+"");
			map.put("size",size+"");
			list = this.adminService.getLectureList(map);
			log.info("list 불러오세요"+list);
			log.debug("tttoooootttaaaaallll:{}",total);
			log.debug("lecturVoList:::::::::::::::::::::{}",list);
			listPage = new ArticlePage<LectureVO>(total, currentPage, size, list);

		} else if(kind.equals("special")) {

			Map<String, String> map = new HashMap<String, String>();
			map.put("keyword",keyword);
			map.put("searchType",searchType);
			map.put("currentPage",currentPage+"");
			map.put("isPermit",isPermit);
			log.info("searchType이 잘들어왔니?"+searchType);
			log.info("keyword이 잘들어왔니?"+keyword);
			log.info("currentPage이 잘들어왔니?"+currentPage);
			total = this.adminService.getSpecialTotal(map);
			log.info("total :::::::::: "+total);
			map.put("total",total+"");
			map.put("size",size+"");
			list = this.adminService.getSpecialList(map);
			log.info("list 불러오세요"+list);
			log.debug("tttoooootttaaaaallll:{}",total);
			log.debug("lecturVoList:::::::::::::::::::::{}",list);
			listPage = new ArticlePage<LectureVO>(total, currentPage, size, list);

		} else if(kind.equals("internship")) {

			Map<String, String> map = new HashMap<String, String>();
			map.put("keyword",keyword);
			map.put("searchType",searchType);
			map.put("currentPage",currentPage+"");
			map.put("isPermit",isPermit);
			log.info("searchType이 잘들어왔니?"+searchType);
			log.info("keyword이 잘들어왔니?"+keyword);
			log.info("currentPage이 잘들어왔니?"+currentPage);
			total = this.adminService.getIntershipTotal(map);
			log.info("total :::::::::: "+total);
			map.put("total",total+"");
			map.put("size",size+"");
			inturnList = this.adminService.getInsternshipList(map);
			log.info("list 불러오세요"+list);
			log.debug("tttoooootttaaaaallll:{}",total);
			log.debug("inturnList:::::::::::::::::::::{}",inturnList);
			internshipPage = new ArticlePage<InternshipVO>(total, currentPage, size, inturnList);

		}

		return listPage;
	}

	@ResponseBody
	@PostMapping("/makeInternAjax")
	public ArticlePage<InternshipVO> makeInternAjax(  @RequestParam String keyword
			                                        , @RequestParam int currentPage
			                                        , @RequestParam String searchType
			                                        , @RequestParam String kind
			                                        , @RequestParam String isPermit
			                                        , LectureVO lecturVo
			                                        , InternshipVO internshipVo) {
		int total = 0;
		int size = 9;

		Map<String, String> map = new HashMap<String, String>();
		map.put("keyword",keyword);
		map.put("searchType",searchType);
		map.put("currentPage",currentPage+"");
		map.put("isPermit",isPermit);
		log.info("searchType이 잘들어왔니?"+searchType);
		log.info("keyword이 잘들어왔니?"+keyword);
		log.info("currentPage이 잘들어왔니?"+currentPage);

		total = this.adminService.getIntershipTotal(map);

		log.info("total :::::makeInternAjax::::: "+total);
		map.put("total",total+"");
		map.put("size",size+"");
		List<InternshipVO> inturnList = this.adminService.getInsternshipList(map);
		log.info("list 불러오세요"+inturnList);
		log.debug("total :::::makeInternAjax::::: {}",total);
		log.debug("inturnList:::::::::::::::::::::{}",inturnList);
		ArticlePage<InternshipVO> internshipPage = new ArticlePage<InternshipVO>(total, currentPage, size, inturnList);
		return internshipPage;
	}

	@GetMapping("/lectureDetail")
	public String lectureDetail(@RequestParam(value = "lctNO") String lctNo
								, @RequestParam(value = "prmmNo") String prmmNo
			                    , LectureVO lectureVo, CommonCodeVO commCodeVo
			                    , Model model) {
		log.info("lctNo-----------------!!!!!!!!!!!!!!!!!!!!-------------" + lctNo);
		lectureVo = this.adminService.getLecturSerise(lctNo);
		log.info("lecturVo---------------!!!!!!!!!!!!!!!========="+lectureVo);

		if(lectureVo==null) {
			lectureVo = new LectureVO();
			lectureVo.setLctNo(lctNo);
			lectureVo.setPrmmNo(prmmNo);
		}
		List<CommonCodeVO> teacher = this.adminService.getTeacher();

		model.addAttribute("teacher", teacher);

		model.addAttribute("lectureVo",lectureVo);
		return "admin/lectureDetail";
	}

	@ResponseBody
	@PostMapping("/goLecture")
	public String goLecture(@RequestBody LectureSeriesVO lectureSeriesVo) {
		log.info("잘 넘어오니?"+lectureSeriesVo.getLctSrsNo());
		String path = this.adminService.goLecture(lectureSeriesVo);

		return path;
	}

	@GetMapping("/lectureModify")
	public String lectureModify( @RequestParam(value = "lctNo") String lctNo
							    , LectureVO lectureVo
							    , CommonCodeVO codeVo
							    , Model model) {
		lectureVo = this.adminService.getLecturSerise(lctNo);

		List<CommonCodeVO> teacher = this.adminService.getTeacher();

		model.addAttribute("data", lectureVo);
		model.addAttribute("teacher", teacher);

		return "admin/lectureModify";
	}

	@PostMapping("/modifyLecture")
	public String modifyLecture( @RequestParam(value = "lctNo" ) String lctNo
								 , @RequestParam(value = "prmmNo" ) String prmmNo
			                     , @RequestParam(value = "title" ) String title
			                     , @RequestParam(value = "lctInstrNm" ) String lctInstrNm
			                     ) {

		Map<String, String> map = new HashMap<String, String>();
		map.put("prmmNo",prmmNo);
		map.put("title",title);

		int updateTitle = this.adminService.updatePrmmTitle(map);

		map.put("lctNo", lctNo);
		map.put("lctInstrNm",lctInstrNm);

		int updateLctInstrNm = this.adminService.updateLctInstrNm(map);

		return "redirect:/admin/lectureDetail?lctNO="+lctNo+"&prmmNo="+prmmNo;
	}

	@PostMapping("/insertSeries")
	public String insertSeries( @RequestParam(value = "lctNo" ) String lctNo
			, @RequestParam(value = "prmmNo" ) String prmmNo
			, @RequestParam(value = "no" ) String no
			, @RequestParam(value = "editordata" ) String editordata
			, @RequestParam(value = "title" ) String title
			, LectureSeriesVO lectureSeriseVo) {

		Map<String, String> map = new HashMap<String, String>();

		map.put("title", title);
		map.put("editordata", editordata);
		map.put("prmmNo", prmmNo);
		map.put("lctNo", lctNo);
		map.put("no", no);

		int update = this.adminService.insertLectureSerise(map);

		int insertAtt = this.adminService.insertAtt(map);

		log.debug("update number : {} ", update);

		return "redirect:/admin/lectureDetail?lctNO="+lctNo+"&prmmNo="+prmmNo;
	}

	@PostMapping("/deletePrmm")
	public String deletePrmm( @RequestParam(value = "prmmNo") String prmmNo) {
		log.info("prmmNo 잘 들어왔니? :" + prmmNo);

		int deletePrmm = this.adminService.deletePrmm(prmmNo);
		log.debug("삭제해줘  {}",deletePrmm);
		int deleteLct = this.adminService.deleteLct(prmmNo);
		log.debug("삭제해줘  {}",deleteLct);
		int deleteAtt = this.adminService.deleteAtt(prmmNo);
		log.debug("삭제해줘  {}",deleteAtt);
		int deleteSrsAll = this.adminService.deleteSrsAll(prmmNo);
		log.debug("삭제해줘  {}",deleteSrsAll);
		int deleteBg = this.adminService.deleteBg(prmmNo);

		return "redirect:/admin/premiumList";
	}

	@PostMapping("/deleteSrs")
	public String deleteSrs( @RequestParam(value = "lctSrsNo") String lctSrsNo
			               , @RequestParam(value = "lctNo") String lctNo
			               , @RequestParam(value = "prmmNo") String prmmNo ) {
		log.info("lctSrsNo 잘 들어왔니? :" + lctSrsNo);


		int deleteSrs = this.adminService.deleteSrs(lctSrsNo);
		log.debug("삭제해줘  {}",deleteSrs);
		int deleteSrsAtt = this.adminService.deleteSrsAtt(lctSrsNo);

		return "redirect:/admin/lectureDetail?lctNO="+lctNo+"&prmmNo="+prmmNo;
	}

	@PostMapping("/changeSeriese")
	public String changeSeriese(@RequestParam(value = "frmLctSrsNo") String frmLctSrsNo
								, @RequestParam(value = "frmLctNo") String frmLctNo
								, @RequestParam(value = "prmmNo") String prmmNo
								, @RequestParam(value = "no") String no
								, @RequestParam(value = "title") String title
								, @RequestParam(value = "editData") String editData
								) {


		Map<String, String> map = new HashMap<String, String>();
		map.put("frmLctSrsNo",frmLctSrsNo);
		map.put("frmLctNo",frmLctNo);
		map.put("no",no);
		map.put("title",title);
		map.put("editData",editData);

		int updateSrs = this.adminService.updateLectureSerise(map);

		int updateAtt = this.adminService.updateLectureAtt(map);


		return "redirect:/admin/lectureDetail?lctNO="+frmLctNo+"&prmmNo="+prmmNo;

	}

	@PostMapping("/registLecture")
	public String registLecture(@RequestParam String prmmContent1
								, @ModelAttribute LectureVO lectureVO
								,PremiumVO premiumVo) {
		premiumVo.setPrmmContent(prmmContent1);
		Map<String, String> map = new HashMap<String, String>();
		int insertPrmm = this.adminService.insertPrmm(premiumVo);
		log.debug("premiumVO : {} ", premiumVo);

		int insertLct = this.adminService.insertLct(lectureVO);

		MultipartFile[] img = premiumVo.getPrmmImg();

		if(img[0].getOriginalFilename() != null && !img[0].getOriginalFilename().equals("")) {
			this.attchService.attachInsert(img, premiumVo);
		}

		return "redirect:/admin/premiumList";
	}

	@PostMapping("/registSpecial")
	public String registSpecial(@RequestParam String prmmContent2
								, PremiumVO premiumVO
								, @ModelAttribute LectureVO lectureVO ) {
		premiumVO.setPrmmContent(prmmContent2);
		Map<String, String> map = new HashMap<String, String>();
		int insertPrmm = this.adminService.insertPrmmSpc(premiumVO);
		log.debug("premiumVO : {} ", premiumVO);

		int insertLct = this.adminService.insertLctSpc(lectureVO);

		MultipartFile[] img = premiumVO.getPrmmImg();

		if(img[0].getOriginalFilename() != null && !img[0].getOriginalFilename().equals("")) {
			this.attchService.attachInsert(img, premiumVO);
		}



		return "redirect:/admin/premiumList";
	}

	@GetMapping("/internshipDetail")
	public String internshipDetail(@RequestParam(value = "prmmNo") String prmmNo
			                     , InternshipVO internshipVo
			                     , Model model) {
		log.debug("log debug log debug log debug log debug log debug prmmNo : {}" ,prmmNo);

		internshipVo = this.adminService.internshipDetail(prmmNo);

		log.debug("log debug log debug log debug log debug log debug internshipVo : {}" ,internshipVo);

		model.addAttribute("data",internshipVo);

		return "admin/internshipDetail";
	}

	@PostMapping("/noPermit")
	public String noPermit(@RequestParam(value = "itnsNo") String itnsNo) {

		log.debug("갑갑하다 진짜 : {}",itnsNo);

		int update = this.adminService.noPermit(itnsNo);

		return "redirect:/admin/internshipRequestList";
	}

	@GetMapping("/internshipRequestList")
	public String internshipRequestList(InternshipVO internshipVo
			                            , @RequestParam(value = "keyword", required=false, defaultValue = "") String keyword
			                            , @RequestParam(value = "searchType", required=false, defaultValue = "name") String searchType
			                            , @RequestParam(value = "isPermit", required=false, defaultValue = "allPermit") String isPermit
			                            , @RequestParam(value = "currentPage", required=false, defaultValue = "1") int currentPage
			                            , MemVO memVO
			                            , Model model) {

		Map<String, String> map = new HashMap<String, String>();

		log.info(currentPage+"");
		int size = 9;

		// 맵에 넣기
		map.put("size", size+"");
		map.put("searchType", searchType);
		map.put("currentPage",currentPage+"");
		map.put("isPermit",isPermit);

		log.info(keyword);
		map.put("keyword", keyword);

		int total = this.adminService.internshipRequestTotal(map);

		map.put("total", total+"");

		List<InternshipVO> list = this.adminService.internshipRequestList(map);

		ArticlePage<InternshipVO> paging = new ArticlePage<InternshipVO>(total, currentPage, size, list);

		model.addAttribute("data", paging);


		return "admin/internshipRequestList";
	}

	@PostMapping("/permitInternship")
	public String permitInternship( @RequestParam (value = "itnsNo") String itnsNo) {
		int update = this.adminService.permitInternship(itnsNo);

		return "redirect:/admin/internshipRequestList";

	}

	@GetMapping("/jobPostingList")
	public String jobPostingList(
			  @RequestParam(value = "keyword", required=false, defaultValue = "") String keyword
			, @RequestParam(value = "searchType", required=false, defaultValue = "entNm") String searchType
			, @RequestParam(value = "isPermit", required=false, defaultValue = "allThing") String isPermit
			, @RequestParam(value = "currentPage", required=false, defaultValue = "1") int currentPage
			, JobPostingVO jobPostingVo, Model model) {

		log.info("searchType:"+searchType);
		Map<String,	String> map = new HashMap<String, String>();
		int size = 10;
		map.put("size",size+"");
		map.put("searchType",searchType);
		map.put("keyword",keyword);
		map.put("currentPage",currentPage+"");
		map.put("ispermit",isPermit);
		int total = this.adminService.jobPostedTotal(map);

		map.put("total",total+"");

		log.info("total:;';';';';';';';';'''"+total);

		List<JobPostingVO> list = this.adminService.getjobPostList(map);

		log.info("list:" + list);
		model.addAttribute("list" , list);
		ArticlePage<JobPostingVO> pageList = new ArticlePage<JobPostingVO>(total, currentPage, size, list);
		log.info(pageList.getContent()+"");
		model.addAttribute("data",pageList);
		return "admin/jobPostingList";
	}
	@PostMapping("/permitJobpost")
	public String permitJobpost(@ModelAttribute JobPostingVO jobPostingVo) {

		log.debug("jobPostingVo :: "+jobPostingVo);
		int update = this.adminService.permitJobpost(jobPostingVo);

		return "redirect:/admin/jobPostingList";
	}

	@PostMapping("/noPermitJobpost")
	public String noPermitJobpost(@ModelAttribute JobPostingVO jobPostingVo) {

		int update = this.adminService.noPermitJobpost(jobPostingVo);

		return "redirect:/admin/jobPostingList";
	}

	@PostMapping("/bReportPrcs")
	public String bReportPrcs(String[] prcs) {

		List<String> prcsList = new ArrayList<String>();
		//1) mybatis에서 다중 update
		//2) Impl에서 반복문을 돌리며 한 개 씩 update할지
		for(String prc : prcs) {
			log.info("prc : " + prc);
			prcsList.add(prc);
		}

		for(String idx : prcsList) {
			log.info("idx:"+idx);
		}
		int update = this.adminService.bReportPrcs(prcsList);


		return "redirect:/admin/reportBoard";
	}
	@PostMapping("/bReportNonPrcs")
	public String bReportNonPrcs(String[] prcs) {

		List<String> prcsList = new ArrayList<String>();
		//1) mybatis에서 다중 update
		//2) Impl에서 반복문을 돌리며 한 개 씩 update할지
		for(String prc : prcs) {
			log.info("prc : " + prc);
			prcsList.add(prc);
		}

		for(String idx : prcsList) {
			log.info("idx:"+idx);
		}
		int update = this.adminService.bReportNonPrcs(prcsList);

		return "redirect:/admin/reportBoard";
	}

	public static String getFolder() {
		// 2023-01-27 형식(format) 지정
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		// 날짜 객체 생성(java.uil 패키지)
		Date date = new Date();
		//2023-01-27=> 2023\\01\\27
		String str = sdf.format(date);
		// 단순 날짜 문자를 File객체의 폴더 타입으로 바꾸기
		// 2023/01/27
		return str.replace("-", "/");
	}

}
