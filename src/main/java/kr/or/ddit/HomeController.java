package kr.or.ddit;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.enterprise.service.EnterpriseService;
import kr.or.ddit.jopPosting.service.JobPostingService;
import kr.or.ddit.mem.service.MemService;
import kr.or.ddit.vo.ArticlePage;
import kr.or.ddit.vo.CommonCodeVO;
import kr.or.ddit.vo.JobPostingVO;
import kr.or.ddit.vo.MemVO;
import kr.or.ddit.vo.VipVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/java")
@Controller
public class HomeController {
	private final MemService memService;
	private final JobPostingService jobPostingService;

	@Autowired
	public HomeController(MemService memService, JobPostingService jobPostingService) {
		this.memService = memService;
		this.jobPostingService = jobPostingService;
	}

	// 메인
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model, Principal principal) {

		List<Map<String,String>> recommList = this.jobPostingService.mainJobPostingRecomm();
		log.debug("recommList : {}", recommList);

		model.addAttribute("recommList", recommList);
		model.addAttribute("body_main", "body_main");
		return "main";
	}

	// 로그인 아이디
	@RequestMapping("/login_id")
	public String login_id(Model model) {

		// 홈 화면 배경화면을 적용하기 위해서 보내주셔야합니다(main,id,pass,join)
		model.addAttribute("body_main", "body_main");
		return "java/login_id";
	}

	// 로그인 비밀번호
	@RequestMapping("/login_pass")
	public String login_pass(Model model) {
		// 홈 화면 배경화면을 적용하기 위해서 보내주셔야합니다(main,id,pass,join)
		model.addAttribute("body_main", "body_main");
		return "java/login_pass";
	}

	// 회원가입
	@RequestMapping("/login_join")
	public String login_join(Model model) {
		// 홈 화면 배경화면을 적용하기 위해서 보내주셔야합니다(main,id,pass,join)
		model.addAttribute("body_main", "body_main");
		return "java/login_join";
	}

	// 채용
	@RequestMapping("/job_posting")
	public String job_posting() {

		return "java/job_posting";
	}

	// 잡화점
	@RequestMapping("/jobpartment")
	public String jobpartment() {
		return "jobpartment/jobPartMain";
	}

	// 멤버십 결제 (가입)
	@GetMapping("/membershipJoin")
	public String membershipJoin(Model model, VipVO vipVO, Principal principal) {
		String vipNo = this.memService.getNextVipNo();
		model.addAttribute("vipNo", vipNo);
		model.addAttribute("memId", principal.getName());

		return "mem/membershipJoin";
	}

	@GetMapping("/index")
	public String index() {
		return "index";
	}

	@GetMapping("/searching")
	public String searching(@RequestParam Map<String, String> map, Model model) {
		log.debug("#searching map : {}", map);

		List<Map<String, String>> searchList = this.memService.getSearchList(map);
		log.debug("#searching searchList : {}", searchList);

		model.addAttribute("searchList", searchList);

		return "view";
	}
}
