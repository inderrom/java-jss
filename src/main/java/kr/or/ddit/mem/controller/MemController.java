package kr.or.ddit.mem.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import com.google.gson.Gson;

import kr.or.ddit.common.service.AttachService;
import kr.or.ddit.enterprise.service.EnterpriseService;
import kr.or.ddit.mem.service.MemService;
import kr.or.ddit.record.service.RecordService;
import kr.or.ddit.vo.BoardCommentVO;
import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.CommonCodeVO;
import kr.or.ddit.vo.EnterpriseVO;
import kr.or.ddit.vo.JobPostingVO;
import kr.or.ddit.vo.MemVO;
import kr.or.ddit.vo.RecordVO;
import kr.or.ddit.vo.ResumeVO;
import kr.or.ddit.vo.VipVO;
import lombok.extern.slf4j.Slf4j;

/**
 * @author seolah
 *
 */
@Slf4j
@RequestMapping("/mem")
@Controller
public class MemController {

	private final MemService memService;
	private final RecordService recordService;
	private final AttachService<MemVO> memAttachService;
	private final AttachService<EnterpriseVO> entAttchService;
	private final EnterpriseService enterpriseService;

	@Autowired
	public MemController(MemService memService, RecordService recordService, AttachService<MemVO> memAttachService, AttachService<EnterpriseVO> entAttchService, EnterpriseService enterpriseService) {
		this.memService = memService;
		this.recordService = recordService;
		this.memAttachService = memAttachService;
		this.entAttchService = entAttchService;
		this.enterpriseService = enterpriseService;
	}

	@PostMapping("/memJoinform")
	public void memJoinform(@RequestParam String username, Model model) {
		model.addAttribute("memId", username);
	}

	@PostMapping("/memJoin")
	public String memJoin(@ModelAttribute MemVO memVO) {
		log.info("회원가입 memVO : {} ", memVO);
		memService.memJoin(memVO);
		return "redirect:/java/";
	}

	@GetMapping("/enterpriseJoin")
	public void entJoin(@ModelAttribute EnterpriseVO corpVO, Model model) {
		model.addAttribute("corpVO", corpVO);
	}

	@PostMapping("/enterpriseJoin")
	public String entJoinPost(@ModelAttribute EnterpriseVO corpVO) {
		log.debug("기업등록 corpVO : {} ", corpVO);
		memService.entJoinPost(corpVO);
		return "redirect:/java/";
	}

	@ResponseBody
	@PostMapping("/existMem")
	public int existMem(@RequestParam String memId) {
		return memService.existMem(memId);
	}

	@ResponseBody
	@PostMapping("/memSearch")
	public MemVO memSearch(@RequestParam String memId) {
		return memService.memSearch(memId);
	}

	@ResponseBody
	@PostMapping("/kakaoLogin")
	public String kakaoLogin(@RequestBody MemVO memVO) {
		log.info("before : {} ", memVO);
		this.memService.kakaoLogin(memVO);
		log.info("after : {} ", memVO);
		return memVO.getMemPass();
	}

	@GetMapping("/forgotPass")
	public void forgotPass() {
	}

	@GetMapping("/changePass")
	public void changePass(@RequestParam String memId, Model model) {
		model.addAttribute("memId", memId);
	}

	@ResponseBody
	@PostMapping("/updatePass")
	public int updatePass(@RequestParam Map<String, String> map) {
		log.info("String : {} ", map.toString());
		return this.memService.updatePass(map);
	}

	@ResponseBody
	@PostMapping("/myMembership")
	public List<VipVO> myMembership(@RequestParam String memId) {
		log.info("memId : {} ", memId );
		return this.memService.myMembership(memId);
	}

	/**
	 *
	 *
	 */
	@GetMapping("/myBoardList")
	public String myBoardList(Model model, Principal principal) {
		if (principal == null) {
			return "redirect:/login";
		}

		log.info("myBoardList 시작");

		List<BoardVO> myBoardList = this.memService.myBoardList(principal.getName());
		log.info("myBoardList : {} ", myBoardList);

		List<BoardCommentVO> myCmntList = this.memService.myCmntList(principal.getName());
		log.info("myCmntList : {} ", myCmntList);

		model.addAttribute("myBoardList", myBoardList);
		model.addAttribute("myCmntList", myCmntList);

		return "mem/myBoardList";
	}

	@GetMapping("/addInformation")
	public void addInformation(Model model) {

	}

	@PostMapping("/insertInformation")
	public String insertInformation(@ModelAttribute MemVO memVO) {
		this.memService.insertInformation(memVO);
		return "redirect:/java/";
	}

	/**
	 *
	 *
	 * @param model
	 */
	@GetMapping("/myPage")
	public void myPage(Model model) {
		List<Map<String, String>> myEmployStatus = new ArrayList<Map<String, String>>();
		myEmployStatus = this.memService.getMyEmployStatus();
		log.info("myEmployStatus : {} ", myEmployStatus);
		model.addAttribute("myEmployStatus", myEmployStatus);
	}

	@GetMapping("/myProfile")
	public String myProfile(Principal principal, Model model) {
		if (principal == null) {
			return "redirect:/login";
		}

		model.addAttribute("cmcdJob", this.memService.getMemJob("JOB"));
		return "mem/myProfile";
	}

	@ResponseBody
	@PostMapping("/myEmployStatusInfo")
	public String myEmployStatusInfo(@RequestParam String emplClfcNo) {
		log.info("emplClfcNo : {} ", emplClfcNo);

		List<Map<String, String>> myEmployStatusInfo = new ArrayList<Map<String, String>>();
		myEmployStatusInfo = this.memService.getMyEmployStatusInfo(emplClfcNo);
		log.info("myEmployStatusInfo : {} ", myEmployStatusInfo);

		return new Gson().toJson(myEmployStatusInfo);
	}

	@GetMapping("/outMember")
	public String outMember(Principal principal, Model model) {
		if (principal == null) {
			return "redirect:/login";
		}
		return "mem/outMember";
	}

	@GetMapping("/myResume")
	public String myResume(Principal principal, Model model) {
		if (principal == null) {
			return "redirect:/login";
		}
		List<ResumeVO> myResumeVOList = this.memService.getMyResume();
		model.addAttribute("myResumeVOList", myResumeVOList);
		log.info("myResumeVOList : {} ", myResumeVOList);
		return "mem/myResume";
	}

	@ResponseBody
	@GetMapping("/resumeInsert")
	public String resumeInsert(Principal principal, Model model) {
		if (principal == null) {
			return "redirect:/login";
		}
		List<ResumeVO> myResumeVOList = this.memService.getMyResume();
		ResumeVO resumeVO = new ResumeVO();
		resumeVO.setRsmTitle("이력서" + (myResumeVOList.size() + 1));
		if(myResumeVOList.size() == 0) {
			resumeVO.setRsmRprs("Y");
		}
		this.memService.createResume(resumeVO);

		return resumeVO.getRsmNo();
	}

	@ResponseBody
	@PostMapping("/insertResumeFile")
	public ResumeVO insertResumeFile(@RequestParam MultipartFile[] resumeFile, Principal principal) {
		log.debug("resumeFile {} : ", resumeFile);

		ResumeVO resumeVO = new ResumeVO();
		resumeVO.setRsmTitle(resumeFile[0].getOriginalFilename());
		this.memService.createResume(resumeVO);

		MemVO memVO = new MemVO();
		memVO.setMemId(principal.getName());
		this.memAttachService.attachInsert(resumeFile, memVO);

		resumeVO = this.memService.resumeDetail(resumeVO);
		return resumeVO;
	}

	@GetMapping("/resumeDetail")
	public String resumeDetail(Principal principal, Model model, @RequestParam String rsmNo) {
		if (principal == null) {
			return "redirect:/login";
		}
		ResumeVO resumeVO = new ResumeVO();
		resumeVO.setRsmNo(rsmNo);
		resumeVO = this.memService.resumeDetail(resumeVO);
		model.addAttribute("resumeVO", new Gson().toJson(resumeVO));

		Map<String, String> map = new HashMap<String, String>();
		map.put("clfc", "LANGUAGE");
		model.addAttribute("cmcdLanguage", this.memService.getCommonCode(map));

		map.put("clfc", "LANGUAGELEVEL");
		model.addAttribute("cmcdLanguageLevel", this.memService.getCommonCode(map));

		return "mem/resumeDetail";
	}

	@ResponseBody
	@PostMapping("/setRprsRsm")
	public int setRprsRsm(@RequestParam String rsmNo) {
		return this.memService.setRprsRsm(rsmNo);
	}

	@ResponseBody
	@PostMapping("/deleteResume")
	public int deleteResume(@RequestParam String rsmNo) {
		ResumeVO resumeVO = new ResumeVO();
		resumeVO.setRsmNo(rsmNo);
		return this.memService.deleteResume(resumeVO);
	}

	@ResponseBody
	@PostMapping("/updateMem")
	public int updateMem(@RequestParam Map<String, String> param) {
		log.info("param : {} ", param);
		return this.memService.updateMem(param);
	}

	@PostMapping("/createResume")
	public String createResume(@ModelAttribute ResumeVO resumeVO) {
		log.debug("resumeVO : {} ",resumeVO.toString());
		this.memService.updateResume(resumeVO);
		return "redirect:/mem/myResume";
	}

	@ResponseBody
	@PostMapping("/getCommonCode")
	public List<CommonCodeVO> getCommonCode(@RequestParam Map<String, String> map) {
		return this.memService.getCommonCode(map);
	}

	/**
	 * 회원 프로필 변경
	 *
	 */
	@ResponseBody
	@PostMapping("/profileUpdate")
	public void profileUpdate(@ModelAttribute MemVO memVO, Model model, Principal principal) {
		log.info("profileUpdate 시작");
		log.debug("memVO : {}", memVO);

		this.memService.profileUpdate(memVO);
	}


	@RequestMapping("/subscription")
	public String subscription(@ModelAttribute EnterpriseVO enterpriseVO,
							   Principal principal) throws Exception {
		log.debug("enterpriseVO : {} ",enterpriseVO);
		if (principal == null) {
			return "redirect:/login";
		}
		VipVO vipVO = enterpriseVO.getVipVO();
		vipVO.setMemId(principal.getName());

		log.debug("subscription 입장");
		log.debug("vipVO : {}", vipVO);
		this.memService.insertVip(vipVO);


		enterpriseVO.setEntNo(this.enterpriseService.enterpriseCheck(principal.getName()).get("ENT_NO"));
		MultipartFile[] unlimitMsContract = enterpriseVO.getUnlimitMsContract();
		if(unlimitMsContract != null) {
			this.entAttchService.attachInsert(unlimitMsContract, enterpriseVO);
		}
		

		return "redirect:/matching/list";
	}

	@GetMapping("/myEmployOffer")
	public String myEmployOffer(Model model) {
		// 받은 제안, 관심 있음(찜), 이력서 열람 리스트를 다 보내줘야 한다.
		List<Map<String, String>> offerList = new ArrayList<Map<String, String>>();
		List<Map<String, String>> likeList = new ArrayList<Map<String, String>>();
		List<Map<String, String>> viewList = new ArrayList<Map<String, String>>();
		offerList = this.memService.getOfferList();
		likeList = this.memService.getLikeList();
		viewList = this.memService.getViewList();
		Gson gson = new Gson();
		model.addAttribute("offerList", gson.toJson(offerList));
		model.addAttribute("likeList", gson.toJson(likeList));
		model.addAttribute("viewList", gson.toJson(viewList));

		return "mem/myEmployOffer";
	}

	@GetMapping("/getContract")
	public String getContract(Principal principal, Model model) {
		model.addAttribute("enterpriseVO", this.enterpriseService.enterpriseCheck(principal.getName()));
		return "enterprise/document/contract";
	}

	@GetMapping("/myRecord")
	public String myRecord(Model model) {
		Map<String, List<Object>> myRecordMap = new HashMap<String, List<Object>>();
		myRecordMap = this.recordService.getRecord();
		log.info("myRecordMap : {} ", myRecordMap);
		model.addAttribute("myRecordMap", new Gson().toJson(myRecordMap));
		return "mem/myRecord";
	}

	@PostMapping("/acceptMatchingOffer")
	public String acceptMatchingOffer(@RequestParam String mtchOfferNo) {
		this.memService.acceptMatchingOffer(mtchOfferNo);
		return "redirect:/mem/myEmployOffer";
	}

	@ResponseBody
	@PostMapping("/getMemJob")
	public List<CommonCodeVO> getMemJob(@RequestParam String cmcdClfc){
		return this.memService.getMemJob(cmcdClfc);
	}


	@GetMapping("/enterpriseInfo")
	public void enterpriseInfo(@RequestParam String entNo, Model model) {
		RecordVO recordVO = new RecordVO();
		recordVO.setEtpId(entNo);
		this.recordService.setRecord(recordVO);

		Map<String, String> entMap = this.enterpriseService.getEnterpriseDetail(entNo);
		model.addAttribute("entMap", entMap);
		Map<String, String> param = new HashMap<>();
		param.put("entNo", entNo);
		param.put("mCurrentPage", "1");
		param.put("mSize", "100");

		List<JobPostingVO> jobPstgVOList = this.enterpriseService.jobPostingList(param);
		model.addAttribute("jobPstgVOList", jobPstgVOList);

		List<String> tagList = this.enterpriseService.getEntAllTag(entNo);
		model.addAttribute("tagList", tagList);

		CommonCodeVO cmcdVO = this.enterpriseService.getCommonCode(entNo);
		model.addAttribute("cmcdVO", cmcdVO);

	}

}