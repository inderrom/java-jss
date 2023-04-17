package kr.or.ddit.matching.controller;

import java.security.Principal;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.enterprise.service.EnterpriseService;
import kr.or.ddit.matching.service.MatchingService;
import kr.or.ddit.vo.ArticlePage;
import kr.or.ddit.vo.CommonCodeVO;
import kr.or.ddit.vo.EnterpriseVO;
import kr.or.ddit.vo.ResumeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/matching")
public class MatchingController {
	private final MatchingService MatchingService;
	private final EnterpriseService enterpriseService;

	@Autowired
	public MatchingController(MatchingService MatchingService, EnterpriseService enterpriseService) {
		this.MatchingService = MatchingService;
		this.enterpriseService = enterpriseService;
	}

	// 매칭 메인 리스트
	@GetMapping("/list")
	public String matchingList(Model model, Principal principal, @RequestParam Map<String, String> map,
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
			@RequestParam(value = "keyword", required = false, defaultValue = "") String keyword,
			@RequestParam(value = "searchMemJob", required = false, defaultValue = "") String searchMemJob,
			@RequestParam(value = "show", required = false, defaultValue = "5") int size,
			@RequestParam(value = "navMenu", required = false, defaultValue = "all") String navMenu) {

		if (principal == null) {
			return "redirect:/login";
		}

		Map<String, String> enterpriseVO = this.enterpriseService.enterpriseCheck(principal.getName());

		map.put("memId", principal.getName());
		map.put("currentPage", currentPage + "");
		map.put("size", size + "");
		map.put("keyword", keyword);
		map.put("sklNm", "Python");
		map.put("searchMemJob", searchMemJob);
		map.put("entNo", enterpriseVO.get("ENT_NO"));
		map.put("navMenu", navMenu);
		log.debug("map : {}", map);

		int total = this.MatchingService.getTotal(map);
		log.debug("total : {}", total);

		// 전체 직군/직무 리스트
		List<CommonCodeVO> jobList = this.MatchingService.jobList(map);
		model.addAttribute("cvo", jobList);
		log.debug("cvo : {}", jobList);

		// 이력서 조회
		List<ResumeVO> matchingList = this.MatchingService.matchingList(map);
		log.debug("data : {}", matchingList);

		model.addAttribute("data", new ArticlePage<ResumeVO>(total, currentPage, size, matchingList));
		log.debug("data2 : {}", new ArticlePage<ResumeVO>(total, currentPage, size, matchingList).toString());
		model.addAttribute("size", size);
		
		model.addAttribute("navMenu", navMenu);
		model.addAttribute("entNo", enterpriseVO.get("ENT_NO"));
		return "matching/list";
	}

	// select 박스 전체직무 검색시
	@ResponseBody
	@PostMapping("/getList")
	public ArticlePage<ResumeVO> getMatchingList(Model model, Principal principal,
			@RequestParam Map<String, String> map,
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
			@RequestParam(value = "keyword", required = false, defaultValue = "") String keyword,
			@RequestParam(value = "entNo", required = false) String entNo,
			@RequestParam(value = "show", required = false, defaultValue = "5") int size,
			@RequestParam(value = "navMenu", required = false, defaultValue = "all") String navMenu,
			@RequestParam String searchMemJob) {
		
		log.debug("들어오나? ");
		log.debug("searchMemJob {}", searchMemJob);
		
		Map<String, String> enterpriseVO = this.enterpriseService.enterpriseCheck(principal.getName());
		map.put("memId", principal.getName());
		map.put("currentPage", currentPage + "");
		map.put("size", size + "");
		map.put("keyword", keyword);
		map.put("entNo", enterpriseVO.get("ENT_NO"));
		map.put("navMenu", navMenu);
		map.put("sklNm", "Python");
		log.debug("map : {}", map);

		List<ResumeVO> matchingList = this.MatchingService.matchingList(map);
		log.debug("data : {}", matchingList);

		int total = this.MatchingService.getTotal(map);
		log.debug("total : {}", total);
		log.debug("data2 : {}", new ArticlePage<ResumeVO>(total, currentPage, size, matchingList).toString());
		return new ArticlePage<ResumeVO>(total, currentPage, size, matchingList);

	}

	// 이력서 상세조회
	@PostMapping("/resumeDetail")
	public String resumeDetail(Model model, @RequestParam Map<String, String> map) {
		log.debug("#resumeDetail map!!! : {}", map);

		ResumeVO resumeVO = this.MatchingService.resumeDetail(map);
		log.debug("#resumeDetail matchingList : " + resumeVO);
		model.addAttribute("resumeVO", resumeVO);

		if(map.get("str") != null && map.get("str").equals("상세")) {
			return "matching/detail/resumeDetail";
		}else {
			return "matching/detail/resumeBlock";
		}
	}

	// 찜한 목록조회
	@ResponseBody
	@GetMapping("/wantList")
	public String wantList(Model model, Principal principal, @RequestParam Map<String, String> map,
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
			@RequestParam(value = "keyword", required = false, defaultValue = "") String keyword,
			@RequestParam(value = "searchMemJob", required = false, defaultValue = "") String searchMemJob,
			@RequestParam(value = "entNo", required = false) String entNo,
			@RequestParam(value = "show", required = false, defaultValue = "5") int size) {

		if (principal == null) {
			return "redirect:/login";
		}
		map.put("memId", principal.getName());
		map.put("currentPage", currentPage + "");
		map.put("size", size + "");
		map.put("keyword", keyword);
		map.put("sklNm", "Python");
		map.put("searchMemJob", searchMemJob);
		map.put("entNo", "ENT0001");
		log.debug("map : {}", map);

		int total = this.MatchingService.getTotal(map);
		log.debug("total : {}", total);

		// 전체 직군/직무 리스트
		List<CommonCodeVO> jobList = this.MatchingService.jobList(map);
		model.addAttribute("cvo", jobList);
		log.debug("cvo : {}", jobList);

		// 이력서 조회
		List<ResumeVO> wantList = this.MatchingService.wantList(map);
		log.debug("data4 : {}", wantList);

		model.addAttribute("data", new ArticlePage<ResumeVO>(total, currentPage, size, wantList));
		log.debug("data5 : {}", new ArticlePage<ResumeVO>(total, currentPage, size, wantList).toString());
		model.addAttribute("size", size);

		return "matching/list";
	}

	@ResponseBody
	@PostMapping("/jobOffer")
	public int jobOffer(@RequestParam Map<String, String> data) {
		// 면접 제안 목록에 추가 EMPSTS0006	기업번호, 회원 아이디
		log.debug("data {} ", data);
		return this.MatchingService.jobOffer(data);
	}
}
