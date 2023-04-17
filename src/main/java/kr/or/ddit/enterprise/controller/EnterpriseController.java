package kr.or.ddit.enterprise.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.preauth.PreAuthenticatedAuthenticationToken;
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

import com.google.gson.Gson;

import kr.or.ddit.board.service.BoardService;
import kr.or.ddit.common.service.AttachService;
import kr.or.ddit.enterprise.service.EnterpriseService;
import kr.or.ddit.mem.service.MemService;
import kr.or.ddit.premium.service.PremiumService;
import kr.or.ddit.security.CustomUserDetailsService;
import kr.or.ddit.vo.ArticlePage;
import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.CommonCodeVO;
import kr.or.ddit.vo.EnterpriseMemVO;
import kr.or.ddit.vo.EnterpriseSkillVO;
import kr.or.ddit.vo.EnterpriseVO;
import kr.or.ddit.vo.InternshipEntryantVO;
import kr.or.ddit.vo.InternshipVO;
import kr.or.ddit.vo.JobPostingSkillVO;
import kr.or.ddit.vo.JobPostingTagVO;
import kr.or.ddit.vo.JobPostingVO;
import kr.or.ddit.vo.PremiumVO;
import kr.or.ddit.vo.RequireJobVO;
import kr.or.ddit.vo.ResumeVO;
import lombok.extern.slf4j.Slf4j;

/**
 * 기업 채용 컨트롤러
 *
 * @author PC-06
 *
 */
@Slf4j
@RequestMapping("/enterprise")
@Controller
public class EnterpriseController {

	@Autowired
	EnterpriseService enterpriseservice;

	@Autowired
	AttachService<EnterpriseVO> attchService;

	@Autowired
	MemService memService;

	@Autowired
	PremiumService premiumService;

	@Autowired
	BoardService boardService;

	@Autowired
	AttachService<PremiumVO> attachPrmmService;

	/**
	 * 메인 접속
	 *
	 * @param model   body에 색변경 클래스를 주기 위해서 필요
	 * @param request 세션 사용
	 * @return main 페이지 이동
	 */
	@GetMapping("/main")
	public String enterpriseMain(Model model, HttpServletRequest request, Principal principal) {
		if (principal == null) {
			return "redirect:/login";
		}

		// 임시 회원 데이터
		Map<String, String> entMemVO = enterpriseservice.enterpriseCheck(principal.getName());
		log.info("entMemVO : " + entMemVO);

		// 기업 회원 enterprise/main / 일반화원 java/main
		if (entMemVO != null) {
			HttpSession session = request.getSession();
			session.setAttribute("entMemVO", entMemVO);
			return "redirect:/enterprise/getApplyList";
		} else {
			model.addAttribute("notEnterprise", "notEnterprise");
			return "enterprise/enterpriseInsert";
		}
	}

	@PostMapping("/entLogoUpdate")
	public String entLogoUpdate(@ModelAttribute EnterpriseVO entVO, Model model, Principal principal) {
		log.info("entLogoUpdate 시작");
		if (principal == null) {
			return "redirect:/login";
		}

		MultipartFile[] entlogoimgs = entVO.getEntlogoimgs();

		if (entlogoimgs[0].getOriginalFilename() != null && !entlogoimgs[0].getOriginalFilename().equals("")) {
			this.attchService.attachInsert(entlogoimgs, entVO);
		}

		return "redirect:/enterprise/main";
	}

	@GetMapping("/enterpriseInsert")
	public void enterpriseInsert(Model model, Principal principal) {
	}

	@GetMapping("/getApplyList")
	public void getApplyList(Model model, @RequestParam Map<String, String> map, HttpServletRequest request, Principal principal) {
		log.debug("getApplyList 시작~!");

		map.put("memId", principal.getName());
		log.info("#getApplyList map : {} ", map);

		List<Map<String, String>> getApplyList = this.enterpriseservice.getApplyList(map);
		log.info("#getApplyList  list : {} ", getApplyList);
		model.addAttribute("getApplyList", getApplyList);

	}

	@PostMapping("/entrantDetail")
	public String entrantDetail(Model model, @RequestParam Map<String, String> map, Principal principal) {
		log.debug("entrantDetail 시작~! {}", map);

		List<Map<String, String>> stateList = this.enterpriseservice.getEmployState(map);
		log.debug("stateList : {}", stateList);

		model.addAttribute("memId", map.get("memId"));
		model.addAttribute("jobPstgNo", map.get("jobPstgNo"));
		model.addAttribute("rsmNo", map.get("rsmNo"));
		model.addAttribute("emplClfcNo", map.get("emplClfcNo"));
		model.addAttribute("pstgno", map.get("pstgno"));
		model.addAttribute("emplno", map.get("emplno"));
		
		model.addAttribute("stateList", stateList);

		return "enterprise/document/entrantDetail";
	}

	@GetMapping("/updateEmpState")
	public String updateEmpState(@RequestParam Map<String,String> map) {
		log.debug("#updateEmpState : {}", map);
		
		enterpriseservice.updateEmpState(map);
		
		return "redirect:/enterprise/main";
	}

	@PostMapping("/resumeDetail")
	public String resumeDetail(Model model, @RequestParam String rsmNo) {
		log.debug("resumeDetail 시작~! {}", rsmNo);

		ResumeVO resumeVO = new ResumeVO();
		resumeVO.setRsmNo(rsmNo);
		resumeVO = this.memService.resumeDetail(resumeVO);
		model.addAttribute("resumeVO", new Gson().toJson(resumeVO));

		Map<String, String> map = new HashMap<String, String>();
		map.put("clfc", "LANGUAGE");
		model.addAttribute("cmcdLanguage", this.memService.getCommonCode(map));

		map.put("clfc", "LANGUAGELEVEL");
		model.addAttribute("cmcdLanguageLevel", this.memService.getCommonCode(map));

		return "enterprise/document/resumeDetail";
	}

	/**
	 * 기업회원 정보조회 페이지 이동
	 *
	 * @param model
	 * @return 기업회원 정보조회 페이지
	 */
	@GetMapping("/enterpriseDetail")
	public void enterpriseDetail(Model model, Principal principal) {
		List<EnterpriseSkillVO> skillList = this.enterpriseservice.getEntSkillList(principal.getName());
		model.addAttribute("skillList", skillList);
	}

	/**
	 * 기업회원 정보등록
	 *
	 * @param entVO     등록할 정보가 담긴 entVO
	 * @param model
	 * @param principal 로그인 한 회원의 정보가 담긴 객체
	 * @return "redirect:/enterprise/main"
	 */
	@PostMapping("/enterpriseJoin")
	public String enterpriseJoinPost(@ModelAttribute EnterpriseVO entVO, Model model, Principal principal) {
		log.info("enterpriseJoinPost 시작");
		if (principal == null) {
			return "redirect:/login";
		} else {
			log.info("entVO : " + entVO);
			this.enterpriseservice.enterpriseJoin(entVO);

			Map<String, String> param = new HashMap<String, String>();
			param.put("type", "MEM_AUTH");
			param.put("value", "ROLE_ENTERPRISE");
			param.put("memId", principal.getName());
			this.memService.updateMem(param);

			EnterpriseMemVO entMemVO = new EnterpriseMemVO();
			entMemVO.setEntNo(entVO.getEntNo());
			entMemVO.setMemId(principal.getName());
			entMemVO.setEntPicNm(entVO.getEntPicNm());
			entMemVO.setEntPicTelno(entVO.getEntPicTelno());
			entMemVO.setEntPicJbgd(entVO.getEntPicJbgd());
			log.info("entMemVO : " + entMemVO);
			this.enterpriseservice.enterpriseMemInsert(entMemVO);

			MultipartFile[] entCertificate = entVO.getEntCertificate();
			if (entCertificate[0].getOriginalFilename() != null
					&& !entCertificate[0].getOriginalFilename().equals("")) {
				this.attchService.attachInsert(entCertificate, entVO);
			}

			return "redirect:/enterprise/main";
		}
	}

	/**
	 * 기업회원 정보수정
	 *
	 * @param entVO     수정할 정보가 담긴 entVO
	 * @param model
	 * @param principal 로그인 한 회원의 정보가 담긴 객체
	 * @return "redirect:/enterprise/main"
	 */
	@PostMapping("/enterpriseUpdate")
	public String enterpriseUpdate(@ModelAttribute EnterpriseVO entVO, Model model, Principal principal) {
		log.info("enterpriseJoinPost 시작");
		if (principal == null) {
			return "redirect:/login";
		} else {
			log.info("변경 전 entVO : " + entVO);
			this.enterpriseservice.enterpriseUpdate(entVO);
			log.info("변경 후 entVO : " + entVO);

			EnterpriseMemVO entMemVO = new EnterpriseMemVO();
			entMemVO.setEntNo(entVO.getEntNo());
			entMemVO.setEntPicNm(entVO.getEntPicNm());
			entMemVO.setEntPicTelno(entVO.getEntPicTelno());
			entMemVO.setEntPicJbgd(entVO.getEntPicJbgd());
			log.info("변경 전 entMemVO : " + entMemVO);
			this.enterpriseservice.enterpriseMemUpdate(entMemVO);
			log.info("변경 후 entMemVO : " + entMemVO);

			return "redirect:/enterprise/main";
		}
	}

	/**
	 * 기업회원 스킬 정보수정
	 *
	 * @param entVO     수정할 정보가 담긴 entVO
	 * @param model
	 * @param principal 로그인 한 회원의 정보가 담긴 객체
	 * @return "redirect:/enterprise/main"
	 */
	@PostMapping("/entSkillUpdate")
	public String entSkillUpdate(@ModelAttribute EnterpriseVO entVO, Model model, Principal principal) {
		log.info("entSkillUpdate 시작");
		if (principal == null) {
			return "redirect:/login";
		} else {
			log.info("변경 전 entVO : " + entVO);
			Map<String, String> map = new HashMap<String, String>();
			for (EnterpriseSkillVO vo : entVO.getEntSkillList()) {
				map.put("entSklNo", vo.getEntSklNo());
				map.put("entSklNm", vo.getEntSklNm());
				map.put("entNo", entVO.getEntNo());
			}
			log.info("mapmapmapmapmap : " + map);
//			this.enterpriseservice.entSkillUpdate(entVO);

			return "redirect:/enterprise/main";
		}
	}

	@PostMapping("/fileUpload")
	public String enterpriseUpload(@ModelAttribute EnterpriseVO entVO) {
		log.info("enterpriseUpload 시작");
		log.info("entVO : " + entVO);

		MultipartFile[] entrprsimgs = entVO.getEntrprsimgs();
		if (entrprsimgs[0].getOriginalFilename() != null && !entrprsimgs[0].getOriginalFilename().equals("")) {
			this.attchService.attachInsert(entrprsimgs, entVO);
		}

		MultipartFile[] entlogoimgs = entVO.getEntlogoimgs();
		if (entlogoimgs[0].getOriginalFilename() != null && !entlogoimgs[0].getOriginalFilename().equals("")) {
			this.attchService.attachInsert(entlogoimgs, entVO);
		}

		return "redirect:/enterprise/main";
	}

	/**
	 * 채용 공고 리스트
	 *
	 * @param model
	 * @return 채용공고 리스트 페이지 이동
	 */
	@GetMapping("/job_posting")
	public String job_posting(Model model, HttpServletRequest request) {

		HttpSession session = request.getSession();
		Map<String, String> entMemVO = (Map<String, String>) session.getAttribute("entMemVO");


		Map<String, String> pagination = new HashMap<String, String>();

		int currentPage = 1;
		int size = 5;

		pagination.put("mCurrentPage", currentPage + "");
		pagination.put("mSize", size + "");
		pagination.put("entNo", entMemVO.get("ENT_NO"));

		// 채용 공고리스트 가져오기
		List<JobPostingVO> jobPostingList = this.enterpriseservice.jobPostingList(pagination);

		int total = this.enterpriseservice.getTotalJobPosting(entMemVO.get("ENT_NO"));

		model.addAttribute("jobPostingList", new ArticlePage<JobPostingVO>(total, currentPage, size, jobPostingList));
		// 채용공고 값 전송
//	   model.addAttribute("jobPostingList", jobPostingList);
		model.addAttribute("entNo", entMemVO.get("ENT_NO"));

		return "enterprise/job_posting";
	}

	/** 기업 채용공고 페이지네이션
	 * URI : /enterprise/job_posting_pagination
	 * @param total 총 페이지 수
	 * @param currentPage 현재 페이지
	 * @param model
	 * @param request session
	 * @return
	 */
	@GetMapping("/job_posting_pagination")
	public String job_posting_pagination(@RequestParam("total") int total, @RequestParam("currentPage") int currentPage,
			Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		Map<String, String> entMemVO = (Map<String, String>) session.getAttribute("entMemVO");

		int size = 5;

		Map<String, String> pagination = new HashMap<String, String>();

		pagination.put("mCurrentPage", currentPage + "");
		pagination.put("mSize", size + "");
		pagination.put("entNo", entMemVO.get("ENT_NO"));

		List<JobPostingVO> jobPostingList = this.enterpriseservice.jobPostingList(pagination);

		model.addAttribute("jobPostingList", new ArticlePage<JobPostingVO>(total, currentPage, size, jobPostingList));

		return "enterprise/job_posting";
	}

	/**
	 * 채용 공고 등록
	 *
	 * @param model
	 * @return 채용 공고 등록 페이지 이동
	 */
	@GetMapping("/job_posting_insert")
	public String job_posting_insert(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		Map<String, String> entMemVO = (Map<String, String>) session.getAttribute("entMemVO");
		model.addAttribute("entMemVO", entMemVO);

		List<String> codeList = new ArrayList<String>();

		codeList.add("JOB");
		// 직업 - 직무 모두 가져감
		codeList.add("DEVELOPER");
		codeList.add("MANAGEMENT");
		codeList.add("MARKETING");
		codeList.add("DESIGN");

		codeList.add("SKILL");
		codeList.add("TAG");

		Map<String, List<CommonCodeVO>> allcodeMap = this.enterpriseservice.getAllCommonCodeList(codeList);
		log.info("코드 값 확인 : " + allcodeMap);
		// 모집 분야 코드 리스트 전송
		model.addAttribute("jobCodeVOList", allcodeMap.get("JOB"));

		// 직무 코드 리스트 전송
		model.addAttribute("developerList", allcodeMap.get("DEVELOPER"));
		// 직무 분야 코드 리스트 전송
		model.addAttribute("managementVOList", allcodeMap.get("MANAGEMENT"));
		// 직무 분야 코드 리스트 전송
		model.addAttribute("marketingVOList", allcodeMap.get("MARKETING"));
		// 직무 분야 코드 리스트 전송
		model.addAttribute("designVOList", allcodeMap.get("DESIGN"));

		// 스킬 분야 코드 리스트 전송
		model.addAttribute("skillCodeVOList", allcodeMap.get("SKILL"));
		// 모집 태그 코드 리스트 전송
		model.addAttribute("jobTagCodeVOList", allcodeMap.get("TAG"));
		return "enterprise/job_posting_insert";
	}

	/**
	 * 채용공고 상세 페이지
	 *
	 * @param jobPostingVO 채용공고 번호를 VO에 담아온다.
	 * @return 채용공고 번호로 채용공고를 DB에서 찾아서 가져온다.
	 */
	@GetMapping("/Detail")
	public String jobPostingDetail(@ModelAttribute JobPostingVO jobPostingVO, Model model) {

		List<String> codeList = new ArrayList<String>();

		codeList.add("JOB");

		// 직업 - 직무 모두 가져감
		codeList.add("DEVELOPER");
		codeList.add("MANAGEMENT");
		codeList.add("MARKETING");
		codeList.add("DESIGN");

		codeList.add("SKILL");
		codeList.add("TAG");

		Map<String, List<CommonCodeVO>> allcodeMap = this.enterpriseservice.getAllCommonCodeList(codeList);

		// 상세 채용 공고 가져오기
		jobPostingVO = this.enterpriseservice.getDetailJobPosting(jobPostingVO.getJobPstgNo());

		List<JobPostingSkillVO> skillList = this.enterpriseservice.getSkillList(jobPostingVO.getJobPstgNo());
		List<JobPostingTagVO> tagList = this.enterpriseservice.getTagList(jobPostingVO.getJobPstgNo());
		List<RequireJobVO> jobList = this.enterpriseservice.getJobList(jobPostingVO.getJobPstgNo());

		// 만약에 직군선택이 안되어 있으면 오류 발생
		CommonCodeVO getJobGroup = this.enterpriseservice.getselectJobGroup(jobList.get(0).getRqrJobNo());

		// 내가 선택한 직군
		model.addAttribute("selectJobGroup", getJobGroup.getCmcdClfc());
		// select Job List
		model.addAttribute("jobList", jobList);
		// select Tag List
		model.addAttribute("tagList", tagList);
		// select Skill List
		model.addAttribute("skillList", skillList);
		// 상세 채용 공고 전송
		model.addAttribute("jobPostingVO", jobPostingVO);

		// 모집 분야 코드 리스트 전송
		model.addAttribute("jobCodeVOList", allcodeMap.get("JOB"));

		// 직무 코드 리스트 전송
		model.addAttribute("developerList", allcodeMap.get("DEVELOPER"));
		// 직무 분야 코드 리스트 전송
		model.addAttribute("managementVOList", allcodeMap.get("MANAGEMENT"));
		// 직무 분야 코드 리스트 전송
		model.addAttribute("marketingVOList", allcodeMap.get("MARKETING"));
		// 직무 분야 코드 리스트 전송
		model.addAttribute("designVOList", allcodeMap.get("DESIGN"));

		// 스킬 분야 코드 리스트 전송
		model.addAttribute("skillCodeVOList", allcodeMap.get("SKILL"));
		// 모집 태그 코드 리스트 전송
		model.addAttribute("jobTagCodeVOList", allcodeMap.get("TAG"));

		return "enterprise/Detail";
	}

	/**
	 * 채용공고 미리보기
	 *
	 * @param jobPostingVO
	 * @param model
	 * @return 채용공고 미리보기 페이지 이동
	 */
	@PostMapping("/preview")
	public String preview(@Valid @ModelAttribute JobPostingVO jobPostingVO, Model model) {

		model.addAttribute("postingVO", jobPostingVO);
		return "enterprise/preview";
	}

	/**
	 * 채용공고 추가
	 *
	 * @param jobPostingVO  채용공고 정보를 담은 VO 전송
	 * @param selectTagList 선택한 태그상세코드 리스트 전송
	 * @param selectJobList 선택한 직업상세코드 리스트 전송
	 * @param model
	 * @return 채용공고 추가 완료 후 채용 공고 리스트 이용
	 */
	@PostMapping("/insert")
	public String insert(@Valid @ModelAttribute JobPostingVO jobPostingVO, @RequestParam List<String> selectTagList,
			@RequestParam List<String> selectJobList, @RequestParam List<String> selectSkillList, Model model,
			HttpServletRequest request) {
		// 기업승인 받기 전이므로 N 세팅
		jobPostingVO.setJobPstgAprvYn("N");

		// 성공 양수, 실패 음수
		int result = this.enterpriseservice.jobPostingInsert(jobPostingVO, selectTagList, selectJobList,
				selectSkillList);

		return "redirect:/enterprise/job_posting";
	}

	/**
	 * 채용공고 수정
	 *
	 * @param jobPostingVO    채용공고 수정 내용
	 * @param selectTagList   수정할 채용공고 태그
	 * @param selectJobList   수정할 채용공고 직무
	 * @param selectSkillList 수정할 채용공고 스킬
	 * @param model
	 * @return
	 */
	@PostMapping("/modify")
	public String modify(@Valid @ModelAttribute JobPostingVO jobPostingVO, @RequestParam List<String> selectTagList,
			@RequestParam List<String> selectJobList, @RequestParam List<String> selectSkillList, Model model,
			HttpServletRequest request) {

		int result = this.enterpriseservice.modifyJobPosting(jobPostingVO, selectJobList, selectSkillList,
				selectTagList);

		return job_posting(model, request);
	}

	/**
	 * 채용공고 삭제
	 *
	 * @param jobPostingVO 채용공고 수정 내용
	 * @param model
	 * @return 채용공고 리스트로 이동
	 */
	@PostMapping("/delete")
	public String delete(@Valid @ModelAttribute JobPostingVO jobPostingVO, Model model, HttpServletRequest request) {

		int result = this.enterpriseservice.deleteJobPosting(jobPostingVO.getJobPstgNo());

		return job_posting(model, request);
	}

	/**
	 * 선택한 직군의 직업 가져오는 아작스 연결
	 *
	 * @param code 선택한 직군 상세코드
	 * @return 선택한 직군의 직업 가져와서 리턴
	 */
	@ResponseBody
	@PostMapping("/getJobList")
	public List<CommonCodeVO> getJobList(@RequestBody String code) {

		List<CommonCodeVO> jobTagCodeVOList = enterpriseservice.getCodeList(code);

		return jobTagCodeVOList;
	}

	///////////////////////////////// 프리미엄
	///////////////////////////////// 관리/////////////////////////////////////////////////////////////////
	//
	/**
	 * 프리미엄 메인 화면
	 *
	 * @return enterprise/premiumMain
	 */
	@GetMapping("/prmmMain")
	public String premiumMain(Model model, Map<String, String> paramMap, Principal principal) {

		if (principal == null) {
			return "redirect:/login";
		}
		Map<String, String> entVO = this.enterpriseservice.enterpriseCheck(principal.getName());
		model.addAttribute("entVO", entVO);
		log.debug("entVO : {}" , entVO);

		// 기업아이디 넣어서 조회
		paramMap.put("entNo", entVO.get("ENT_NO"));
		List<InternshipVO> itnsList = this.premiumService.getEntItnsList(paramMap);
		model.addAttribute("data", itnsList);

		return "enterprise/prmmMain";
	}

	/**
	 * 프리미엄 인턴십 등록 화면
	 *
	 * @return enterprise/prmmRgstItns
	 */
	@GetMapping("/prmmRgstItns")
	public String prmmRgstItns(Model model) {

		String prmmNo = this.premiumService.getNxtPrmmNo();
		model.addAttribute("prmmNo", prmmNo);

		return "enterprise/prmmRgstItns";
	}

	/**
	 * 프리미엄 인턴십 등록 처리(post)
	 *
	 * @return "redirect:/enterprise/prmmMain"
	 */
	@PostMapping("/prmmRgstItnsPost")
	public String prmmRgstItnsPost(@ModelAttribute PremiumVO prmmVO, @ModelAttribute InternshipVO itnsVO) {

		log.debug("prmmVO : {}, itnsVO : {} ", prmmVO, itnsVO);
		this.premiumService.insertPrmm(prmmVO);
		this.premiumService.insertItns(itnsVO);

		// 이미지 파일 처리
		MultipartFile[] uploadFileImage = prmmVO.getUploadFileImage();
		if (uploadFileImage[0].getOriginalFilename() != null && !uploadFileImage[0].getOriginalFilename().equals("")) {
			this.attachPrmmService.attachInsert(prmmVO.getUploadFileImage(), prmmVO);
		}
		log.debug(null);

		return "redirect:/enterprise/prmmMain";
	}

	/**
	 * 인턴십 정보 상세 확인
	 *
	 * @param itnsVO
	 * @return "enterprise/prmmDetail"
	 */
	@GetMapping("/prmmDetail")
	public String prmmDetail(Model model, @ModelAttribute InternshipVO itnsVO) {

		log.debug("인턴십 정보 상세 확인 입장!!");
		log.debug("itnsVO : {}", itnsVO);

		itnsVO = this.premiumService.getMyInternshipDetail(itnsVO);
		log.debug("itnsVO : {}", itnsVO);
		model.addAttribute("data", itnsVO);

		//인턴십 참가가 승인된 신청자들 인원 수
		int itnsEntrtCount = this.premiumService.getEntrtCount(itnsVO.getItnsNo());
		model.addAttribute("itnsEntrtCount", itnsEntrtCount);

		return "enterprise/prmmDetail";
	}

	/**
	 * 인턴십 신청자 승인 처리 (INTERNSHIP_ENTRYANT 테이블 update)
	 *
	 * @param itnsEntrtVO
	 * @return
	 */
	@ResponseBody
	@PostMapping("/aprvItnsEntrt")
	public List<InternshipEntryantVO> aprvItnsEntrt(@RequestBody List<String> itnsEntrtList,
			InternshipEntryantVO itnsEntrtVO) {

		log.debug("인턴십 신청자 승인 입장~~!");
		log.debug("itnsEntrtList : {}", itnsEntrtList);

		String itnsNo = itnsEntrtList.get(0);
		itnsEntrtVO.setItnsNo(itnsNo);
		itnsEntrtVO.setItnsEntrtAprvYn(itnsEntrtList.get(1));
		for (int i = 2; i < itnsEntrtList.size(); i++) {
			String memId = String.valueOf(itnsEntrtList.get(i));
			itnsEntrtVO.setMemId(memId);
			log.debug("itnsEntrtVO : {} ", itnsEntrtVO);

			// INTERNSHIP_ENTRYANT 테이블의 ITNS_ENTRT_APRV_YN 컬럼 업데이트
			this.premiumService.updateEntrtAprv(itnsEntrtVO);
		}

		//인턴십 참가가 승인된 신청자들 인원 수 가져와서 jsp 화면 update ==>밑에서 setCnt 이용
//		int itnsEntrtCount = this.premiumService.getEntrtCount(itnsNo);

		//인턴십 참가자 신청상태 값(Y/N) 가져와서 jsp로 보내기(거기서 띄우기,,,)
		List<InternshipEntryantVO> resultList = this.premiumService.getItnsEntrtList(itnsNo);
		resultList.get(0).setCnt(this.premiumService.getEntrtCount(itnsNo));

		// Map을 넘기면 오류가 난다,,,
		// 넘겨야 할 값 => 승인된 인원..그냥 count를 여기서 하면 되나? length.....????,,,,,,
		return resultList;
	}

	@PostMapping("/deleteItns")
	public String deleteItns(@Valid @ModelAttribute InternshipVO itnsVO) {

		log.info("인턴십 삭제 입장  - internshipVO: {}", itnsVO);

		// 인턴십 삭제
		this.premiumService.deleteItns(itnsVO);

		return "redirect:/enterprise/prmmMain";
	}

	@PostMapping("/editItnsPost")
	public String editItnsPost(@ModelAttribute PremiumVO prmmVO, @ModelAttribute InternshipVO itnsVO) {

		log.info("인턴십 수정 입장  - internshipVO: {} , {}", prmmVO, itnsVO);

		this.premiumService.editItnsPrmm(prmmVO);
		this.premiumService.editItnsItns(itnsVO);

		// prmmNo=PRMM0020&itnsNo=ITNS0008&entNo=ENT0001
		return "redirect:/enterprise/prmmMain?prmmNo=" + prmmVO.getPrmmNo() + "&itnsNo=" + itnsVO.getItnsNo()
				+ "&entNo=" + itnsVO.getEntNo();
	}

}
