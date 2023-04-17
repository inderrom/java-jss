package kr.or.ddit.premium.controller;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;

import kr.or.ddit.board.service.BoardService;
import kr.or.ddit.common.service.AttachService;
import kr.or.ddit.mem.service.MemService;
import kr.or.ddit.premium.service.PremiumService;
import kr.or.ddit.record.service.RecordService;
import kr.or.ddit.vo.ArticlePage;
import kr.or.ddit.vo.InternshipChatVO;
import kr.or.ddit.vo.InternshipCommunityCommentVO;
import kr.or.ddit.vo.InternshipCommunityVO;
import kr.or.ddit.vo.InternshipScheduleVO;
import kr.or.ddit.vo.InternshipVO;
import kr.or.ddit.vo.LectureSeriesVO;
import kr.or.ddit.vo.LectureVO;
import kr.or.ddit.vo.MemVO;
import kr.or.ddit.vo.PremiumVO;
import kr.or.ddit.vo.RecordVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/myPremium")
@Controller
public class MyPremiumController {

	@Autowired
	PremiumService premiumService;

	@Autowired
	BoardService boardService;

	@Autowired
	AttachService<InternshipCommunityVO> attchService;

	@Autowired
	MemService memService;

	@Autowired
	RecordService recordService;

	@GetMapping("/main")
	public String main(Principal principal
						, RecordVO recordVO
						, Model model) {
		if (principal == null) {
			return "redirect:/login";
		}else {

			String id = principal.getName();
			log.debug("idid : {} " , id);

			//parameter로 쓸 recordVO에 memId, clfcNo 담기
			recordVO.setMemId(id);
			recordVO.setRecClfcNo("RECCL0004");

			//내가 그동안 열람한 프리미엄 기록...........
			List<PremiumVO> recPrmmVOList = this.premiumService.getMyPrmmRec(recordVO);
			model.addAttribute("record", recPrmmVOList );

			//record테이블에서 내가 신청한 강의, 특강 가져오기 (북마크 Y)
			List<PremiumVO> prmmVOList = this.premiumService.getmyLectureList(recordVO);
			model.addAttribute("lec", prmmVOList);

			//record테이블에서 내가 신청한 인턴십(진행/종료나눠서 가져오기) 시작전....어떻게...?
			List<InternshipVO> ingPrmmVOList = this.premiumService.getMyInternshipList(recordVO);
			List<InternshipVO> endedPrmmVOList = this.premiumService.getMyEndedInternshipList(recordVO);
			log.debug("ing : {}", ingPrmmVOList);
			model.addAttribute("ing", ingPrmmVOList);
			model.addAttribute("ended", endedPrmmVOList);

			//지원현황가져오기
			List<Map<String, String>> myEmployStatus = new ArrayList<Map<String, String>>();
			myEmployStatus = this.memService.getMyEmployStatus();
			log.info("myEmployStatus : {} ", myEmployStatus);
			model.addAttribute("myEmployStatus", myEmployStatus);

			return "myPremium/myPremiumMain";
		}
	}

	@GetMapping("/myLectureList")
	public String myLectureList(Principal principal
								, RecordVO recordVO
								, Model model) {
		if (principal == null) {
			return "redirect:/login";
		}else {
			String id = principal.getName();
			log.debug("idid : {} " , id);

			recordVO.setMemId(id);
			recordVO.setRecClfcNo("RECCL0004");

			//내가 신청한 강의 띄우기
			//@param : recordVO, @result : premiumVO
			List<PremiumVO> prmmVOList = this.premiumService.getmyLectureList(recordVO);

			model.addAttribute("data", prmmVOList);

			return "myPremium/myLectureList";
		}
	}

	@GetMapping("/mylectureDetail")
	public String mylectureDetail(@ModelAttribute PremiumVO premiumVO, Model model, Principal principal) {

		if (principal == null) {
			return "redirect:/login";
		}
		log.debug("getPrmmNo : {} ", premiumVO.getPrmmNo());

		/**★★★★★★★★★★
		 * 특강을 파일형식으로 할거면 지금처럼  lectureSeries 로 받으면 되고
		 * 아니면 주소를 넣을 컬럼을,,,추가,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
		 * 아니면 lectureSrs 주소에 줌주소를 넣어서,,<-이건 줌을 성공하면 가능~! 안되면 유튜브라이브 주소
		 * */

		//prmmNo받아서 강의 시리즈를 포함하는 lecDetail 조회하기
		LectureVO lecVO = this.premiumService.getLectureDetail(premiumVO);
		model.addAttribute("data", lecVO);

		return "myPremium/mylectureDetail";
	}

//	@PostMapping(value = "/lecturePlay", produces = "application/text;charset=UTF-8")
	@ResponseBody
	@GetMapping("/lecturePlay")
	public Map<String, String> lecturePlay(
			LectureSeriesVO lctSrsVO
			, @RequestParam(value="lctSrsNo", required=false) String lctSrsNo) {
		log.debug("lctSrsNo : {} ", lctSrsNo);
		lctSrsVO.setLctSrsNo(lctSrsNo);

		log.debug("lctSrsVO : {} ", lctSrsVO);
		Map<String, String> resultMap = new HashMap<String, String>();

		try {
			lctSrsVO = this.premiumService.getlecSrsDetail(lctSrsVO);
			log.debug("lecSrsVO : {} " , lctSrsVO);
			log.debug("attNm : {} " , lctSrsVO.getAttNm());

			resultMap.put("attNm", lctSrsVO.getAttNm());
		} catch (NullPointerException e) {
		}

		return resultMap;
	}

	@ResponseBody
	@PostMapping("/deletemyLecture")
	public String detelemyLecture(@RequestParam String etpId
								, RecordVO recordVO
								, Principal principal) {
		log.debug("etpId : {}",  etpId);
		if (principal == null) {
			return "redirect:/login";
		}else {
			recordVO.setMemId(principal.getName());
			log.debug("recordVO" , recordVO);
			this.premiumService.deletemyLecture(recordVO);
//			this.recordService.setRecord(recordVO);

			return "success";
		}
	}


	@GetMapping("/myInternshipList")
	public String myInternshipList(Principal principal
									, RecordVO recordVO
									, Model model) {
		if (principal == null) {
			return "redirect:/login";
		}else {
			String id = principal.getName();
			log.debug("idid : {} " , id);

			recordVO.setMemId(id);
			recordVO.setRecClfcNo("RECCL0004");
			List<InternshipVO> ingPrmmVOList = this.premiumService.getMyInternshipList(recordVO);
			List<InternshipVO> endedPrmmVOList = this.premiumService.getMyEndedInternshipList(recordVO);

			model.addAttribute("ing", ingPrmmVOList);
			model.addAttribute("ended", endedPrmmVOList);
			log.debug("ingPrmmVOList : {}" , ingPrmmVOList);
			log.debug("endedPrmmVOList : {}" , endedPrmmVOList);

//			Date now = new Date();
//			model.addAttribute("now", now);
//			log.debug("now : {} ", now);

			return "myPremium/myInternshipList";
		}
	}

	@GetMapping("/myInternshipDetail")
	public String myInternshipDetail(@ModelAttribute InternshipVO internshipVO, Model model) {
		log.debug("myInternshipDetail 시작~!");

		internshipVO = this.premiumService.getMyInternshipDetail(internshipVO);
		log.debug("internshipVO : {} " , internshipVO);

		List<InternshipChatVO> itChatVO = this.premiumService.getChatList(internshipVO);
		log.debug("itChatVO : {} " , itChatVO);

		List<InternshipScheduleVO> itnsScheduleList = this.premiumService.getInternshipSchedule(internshipVO);
		log.debug("itnsScheduleList : {}", itnsScheduleList);

		List<MemVO> itnsEntryantList = this.premiumService.getIntetnshipEntryant(internshipVO);

		model.addAttribute("data", internshipVO);
		model.addAttribute("itChatVO", itChatVO);
		model.addAttribute("itnsScheduleList", new Gson().toJson(itnsScheduleList));
		model.addAttribute("itnsEntryantList", itnsEntryantList);

		return "myPremium/myInternshipDetail";
	}


	@PostMapping("/boardList")
	public String boardList(Model model, Principal principal, @RequestParam String itnsNo,
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
			@RequestParam(value = "show", required = false, defaultValue = "10") int size) {
		if (principal == null) {
			return "redirect:/login";
		}
		log.debug("itnsNo : {}", itnsNo);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("itnsNo", itnsNo);
		int total = this.premiumService.getTotal(map);

		map.put("size", size+"");
		map.put("currentPage", currentPage+"");

		List<InternshipCommunityVO> list = this.premiumService.boardList(map);
		log.debug("list : {}" , list);

		model.addAttribute("list", new ArticlePage<InternshipCommunityVO>(total, currentPage, size, list));
		model.addAttribute("total", total);
		model.addAttribute("size", size);

		return "myPremium/detail/boardList";
	}

	@PostMapping("/boardDetail")
	public String boardDetail(@ModelAttribute InternshipCommunityVO internVO, Model model, Principal principal) {
		if (principal == null) {
			return "redirect:/login";
		}
		log.debug("internVO : {}" , internVO);

		InternshipCommunityVO brdDetail = this.premiumService.boardDetail(internVO);
		log.debug("brdDetail : {}" , brdDetail);

		model.addAttribute("brdDetail", brdDetail);
		model.addAttribute("itnsNo", internVO.getItnsNo());

		return "myPremium/detail/boardDetail";
	}

	@GetMapping("/boardInsert")
	public String boardInsert(@RequestParam String itnsNo, Model model) {
		log.debug("boardInsert Get 시작 itnsNo : {}", itnsNo);
		model.addAttribute("itnsNo", itnsNo);

		return "myPremium/detail/boardInsert";
	}

	@PostMapping("/boardInsert")
	public String boardInsert(@ModelAttribute InternshipCommunityVO internVO, Model model) {
		log.debug("boardInsert Post 시작");
		log.debug("boardInsert internVO : {}", internVO);

		internVO.setItnsCmmuTitle(internVO.getItnsCmmuTitle().substring(internVO.getItnsCmmuTitle().indexOf(",")+1));
		internVO.setItnsCmmuContent(internVO.getItnsCmmuContent().substring(internVO.getItnsCmmuContent().indexOf(",")+1));

		this.premiumService.boardInsert(internVO);
		MultipartFile[] uploadFile = internVO.getUploadFile();

		if(uploadFile[0].getOriginalFilename() != null && !uploadFile[0].getOriginalFilename().equals("")) {
			this.attchService.attachInsert(internVO.getUploadFile(), internVO);
		}

		InternshipCommunityVO brdDetail = this.premiumService.boardDetail(internVO);
		log.debug("#brdDetail : {}" , brdDetail);
		model.addAttribute("brdDetail", brdDetail);
		model.addAttribute("itnsNo", internVO.getItnsNo());

		return "myPremium/detail/boardDetail";
	}

	@PostMapping("/cmntInsert")
	public String cmntInsert(@RequestParam Map<String,String> map, Model model) {
		log.debug("cmntInsert 시작");
		log.debug("#cmntInsert map : {}", map);

		this.premiumService.cmntInsert(map);
		InternshipCommunityCommentVO cmntVO = this.premiumService.cmntDetail(map);
		log.debug("#cmntInsert cmntVO : {}", cmntVO);

		model.addAttribute("cmntVO", cmntVO);

		return "myPremium/detail/cmntInsert";
	}

	@ResponseBody
	@GetMapping("/cmntDelete")
	public int cmntDelete(@RequestParam String cmntNo) {
		log.debug("cmntDelete 시작");
		log.debug("#cmntNo : {}" , cmntNo);

		int result = this.premiumService.cmntDelete(cmntNo);
		return result;
	}

	@ResponseBody
	@PostMapping("/chatMsgInsert")
	public int chatMsgInsert(@RequestParam Map<String, String> param) {
		log.debug("#chatMsgInsert param : {}", param);
		return this.premiumService.chatMsgInsert(param);
	}

//	@PostMapping("/getEntrtsInfo")
//	public String getEntrtsInfo(@RequestParam String itnsNo, Model model) {
//		log.debug("getEntrtsInfo 시작");
//		log.debug("#getEntrtsInfo itnsNo : {}", itnsNo);
//
//		this.premiumService.getEntrtsInfo();
//
//		return "myPremium/detail/cmntInsert";
//	}

	@PostMapping("/itnsChat")
	public String itnsChat(){
		log.debug("itnsChat 시작");

		return "myPremium/detail/itnsChat";
	}

	@ResponseBody
	@PostMapping("/setInternshipSchedule")
	public Map<String, Object> setInternshipSchedule(@ModelAttribute InternshipScheduleVO itnsScheduleVO) {
		log.debug("itnsScheduleVO {} ", itnsScheduleVO);
		Map<String, Object> resultMap = new HashMap<>();
		int result = this.premiumService.setInternshipSchedule(itnsScheduleVO);
		resultMap.put("itnsScheduleVO" , itnsScheduleVO);
		if(result > 0) {
			resultMap.put("msg", "success");
		}else {
			resultMap.put("msg", "fail");
		}
		return resultMap;
	}

	@ResponseBody
	@PostMapping("/deleteInternshipSchedule")
	public int deleteInternshipSchedule(@RequestParam String itnsSchdNo) {
		InternshipScheduleVO itnsScheduleVO = new InternshipScheduleVO();
		itnsScheduleVO.setItnsSchdNo(itnsSchdNo);
		return this.premiumService.deleteInternshipSchedule(itnsScheduleVO);
	}
}
