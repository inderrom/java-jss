package kr.or.ddit.premium.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.map.HashedMap;
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

import kr.or.ddit.mem.service.MemService;
import kr.or.ddit.mem.service.impl.MemServiceImpl;
import kr.or.ddit.premium.service.PremiumService;
import kr.or.ddit.record.service.RecordService;
import kr.or.ddit.security.CustomUserDetailsService;
import kr.or.ddit.vo.ArticlePage;
import kr.or.ddit.vo.InternshipEntryantVO;
import kr.or.ddit.vo.MemVO;
import kr.or.ddit.vo.PremiumVO;
import kr.or.ddit.vo.RecordVO;
import kr.or.ddit.vo.VipVO;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@RequestMapping("/premium")
@Controller
public class PremiumController {

	@Autowired
	PremiumService premiumService;
	@Autowired
	RecordService RecordService;
	@Autowired
	MemService memService;
	@Autowired
	CustomUserDetailsService customUserDetailsService;

	private String getUserName() {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails) principal;
		return userDetails.getUsername();
	}


	private void setUserDetails() {
		Authentication oldAuth = SecurityContextHolder.getContext().getAuthentication();
		Authentication newAuth = new PreAuthenticatedAuthenticationToken(
				customUserDetailsService.loadUserByUsername(this.getUserName()), oldAuth.getCredentials(), oldAuth.getAuthorities());
		SecurityContextHolder.getContext().setAuthentication(newAuth);
	}

	/** 프리미엄 목록을 전체 조회한다.	(근데  페이징이 되야하는)
	 * @param model
	 * @return "premium/premiumMain"
	 */
	@GetMapping("/main")
	public String getprmmList(Model model, @ModelAttribute String prmmClfc) {
		log.debug("Premium main 입장");

		//memId 로그인 여부 체크용
		Object object =
				SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String memId = String.valueOf(object);
		model.addAttribute("memId", memId);
		log.debug("memId : {} ", memId);

		List<PremiumVO> prmmList = this.premiumService.getPrmmList(prmmClfc);
		model.addAttribute("data", prmmList);

		return "premium/premiumMain";
	}


	/** 프리미엄 메인 카테고리 분류
	 * @param model
	 * @param prmmClfc
	 * @return List<PremiumVO>
	 */
	@ResponseBody
	@GetMapping("/mainCate")
	public List<PremiumVO> getprmmCateList(Model model
								, @RequestParam(value="prmmClfc", required=false) String prmmClfc) {
			log.debug("Premium mainCate 입장");
			log.debug("prmmClfc : {} ", prmmClfc);

			//memId 로그인 여부 체크용
			Object object =
					SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			String memId = String.valueOf(object);
			model.addAttribute("memId", memId);
			log.debug("memId : {} ", memId);

			List<PremiumVO> prmmList = this.premiumService.getPrmmList(prmmClfc);
			log.debug("prmmList :" + prmmList );
			model.addAttribute("data", prmmList);

			return prmmList;
	}

	@GetMapping("/premiumDetail")
	public String getPremiumDetail(Model model
						, @ModelAttribute PremiumVO premiumVO
						, RecordVO recordVO
						) {
		log.debug("Premium main 입장");

		//memId 로그인 여부 체크용 ==> 신청할 때 체크용
		Object object =
				SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String memId = String.valueOf(object);
		model.addAttribute("memId", memId);

		log.debug("memId : {} ", memId);
		log.debug("premiumVO : {} ", premiumVO);
		log.debug("recordVO : {} ", recordVO);

		recordVO.setEtpId(premiumVO.getPrmmNo());
		this.RecordService.setRecord(recordVO);

		//premiumVO의 prmmNo로 Detail정보 가져오기
		premiumVO = this.premiumService.getPrmmDetail(premiumVO);
		log.debug("premiumVO : {} ", premiumVO);
		model.addAttribute("data", premiumVO);

		return "premium/premiumDetail";
	}

	/** 인턴십 신청화면으로 넘어간다
	 * @param model
	 * @param premiumVO
	 * @return "redirect:/premium/internshipApply"
	 */
	@GetMapping("/internshipApply")
	public String internshipApply(Model model
						, @ModelAttribute PremiumVO premiumVO) {

		//premiumVO의 prmmNo로 Detail정보 가져오기
		premiumVO = this.premiumService.getPrmmDetail(premiumVO);
		model.addAttribute("data", premiumVO);

		return "premium/internshipApply";
	}

	/** 인턴십을 신청한다. + 인턴십 참가자 테이블에 추가한다.
	 * @param inernshipVO
	 * @return void
	 */
	@ResponseBody
	@PostMapping("/internshipApplyPost")
	public int internshipApplyPost(@RequestBody Map<String, String> form, Model model) {
		log.debug("인턴십 신청 입장~~~~~~~~~~");
		log.debug("form : {} ", form);

		//itnsNo, memId 꺼내기
		String itnsNo = form.get("itnsNo");
		String memId = form.get("memId");
		log.debug("itnsNo : {}, memId : {} ", itnsNo, memId);

		//InternshipEntryantVO에 itnsNo, memId 세팅
		InternshipEntryantVO internshipEntryantVO = new InternshipEntryantVO();
		internshipEntryantVO.setItnsNo(itnsNo);
		internshipEntryantVO.setMemId(memId);
		log.debug("internshipEntryantVO : {} ", internshipEntryantVO);

		//인턴십 참가자에 추가
		//internshipVO에서 prmmNo가져옴
		int result =this.premiumService.applyInternship(internshipEntryantVO);

		model.addAttribute("result", result);

		return result;
	}

	/** 최근 기록(record테이블)을 체크(이미 신청한 내역인지 확인)
	 * @param premiumVO
	 * @return int
	 */
	@ResponseBody
	@PostMapping("/checkApply")
	public int checkApply(@RequestBody RecordVO recordVO, Principal principal) {

		log.debug("checkApply들어옴");
		log.debug("recordVO : {} ", recordVO);

		recordVO.setMemId(principal.getName());
		//최근기록 테이블 조회
		int result = this.premiumService.checkApply(recordVO);
		log.debug("checkApply result : {}",result);

		return result;
	}

	@ResponseBody
	@PostMapping("/checkInternshipEntryant")
	public int checkInternshipEntryant(@RequestBody InternshipEntryantVO itnsEntrtVO
										) {

		log.debug("checkInternshipEntryant 들어옴");
		log.debug("itnsEntrtVO : {}", itnsEntrtVO);

		//인턴십 참가자 테이블에 기록 있는지 조회
		int result = this.premiumService.checkInternshipEntryant(itnsEntrtVO);
		log.debug("checkItnsEntrt result : {}",result);

		return result;
	}


	@GetMapping("/subscription")
	public String subscription(Model model, VipVO vipVO, MemVO memVO) {
		log.debug("subscription 입장!");

		//memId 로그인 여부 체크용 ==> 로그인 안 했을 시 로그인창으로/ 했을 시 결제 창으로
		Object object = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String memId = String.valueOf(object);
		model.addAttribute("memId", memId);
		log.debug("memId : {} ", memId);

//		MemVO memVO = this.memService.

//		vipVO.setVipGradeNo("VIPGRD0001");
		String vipNo = this.premiumService.getNextVipNo();
		log.debug("vipNo : {} ", vipNo);
		model.addAttribute("vipNo", vipNo);

		return "premium/subscription";
	}

	@ResponseBody
	@PostMapping("/subscriptionPost")
	public String subscriptionPost(@RequestBody VipVO vipVO, Principal principal) {
		log.debug("구독 결제 성공 입장! + vipVO : {} ", vipVO);

		vipVO.setMemId(principal.getName());
		vipVO.setVipGrd("VIPGRD0001");
		log.debug("setting 후 vipVO : {} ", vipVO);
		this.premiumService.insertVip(vipVO);

		this.setUserDetails();

		return "success";
	}

}
