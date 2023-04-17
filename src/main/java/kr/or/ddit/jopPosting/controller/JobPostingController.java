package kr.or.ddit.jopPosting.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.map.HashedMap;
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

import kr.or.ddit.common.service.AttachService;
import kr.or.ddit.enterprise.service.EnterpriseService;
import kr.or.ddit.jopPosting.service.JobPostingService;
import kr.or.ddit.mem.service.MemService;
import kr.or.ddit.record.service.RecordService;
import kr.or.ddit.vo.ArticlePage;
import kr.or.ddit.vo.AttachmentVO;
import kr.or.ddit.vo.CommonCodeVO;
import kr.or.ddit.vo.EmployStatusVO;
import kr.or.ddit.vo.JobPostingVO;
import kr.or.ddit.vo.MemVO;
import kr.or.ddit.vo.RecordVO;
import kr.or.ddit.vo.ResumeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/jobPosting")
@Controller
public class JobPostingController {

	@Autowired
	JobPostingService jobPostingService;

	@Autowired
	EnterpriseService enterpriseservice;

	@Autowired
	MemService memService;

	@Autowired
	RecordService recordService;

	@Autowired
	AttachService<MemVO> attchService;
	/** 채용공고 메인
	 * 요청 URL (/jobPosting/main)
	 * @param model
	 * @param principal 회원 VO
	 * @return
	 */
	@GetMapping("/main")
	public String main(Model model,Principal principal ) {


		List<String> codeList= new ArrayList<String>();

		codeList.add("JOB");
		codeList.add("TAG");


		// 채용공고 리스트 가져오기

		// 회원 일 경우
		if(principal != null) {
			String memId = principal.getName();
			log.debug("값 확인 {}",memId);
			Map<String, Object> jobPostingMap= jobPostingService.getMemberCustomSearch(memId);

			//가져온 회원정보
			MemVO memVO = (MemVO)jobPostingMap.get("memVO");
			ArticlePage<JobPostingVO> articlePage = (ArticlePage)jobPostingMap.get("ArticlePage");
			log.debug("memVO 값 확인 {}",memVO);



			if(memVO != null) {
				String selectJobGroup =  memVO.getMemJobGroup();

				if(!selectJobGroup.equals("") || selectJobGroup !=null) {
					codeList.add(selectJobGroup);
				}

				//선택 직무
				model.addAttribute("selectJobGroup", memVO.getMemJobGroup());



			}

			//페이지
			model.addAttribute("jobPostingList", articlePage);

		}





		//비회원 경우
		if(principal ==null){


			Map<String, Object> getpageInfoMap =  this.jobPostingService.getJobPosting();

			ArticlePage<JobPostingVO> articlePage = (ArticlePage)getpageInfoMap.get("articlePage");
			//페이지
			model.addAttribute("jobPostingList", articlePage);
		}


		//DB에서 검색 공통코드 가져오기
		Map<String, List<CommonCodeVO>> allcodeMap = this.enterpriseservice.getAllCommonCodeList(codeList);

		//직군, 태그 공통 코드 전송
		model.addAttribute("codeMap", allcodeMap);

		return "jobPosting/main";




	}

	/** 조건 채용공고
	 * 요청 URL (/jobPosting/selectedMain)
	 * @param selectJobGroup 선택한 직군 (개발,디자인,마케팅...)
	 * @param selectJobList	 선택한 직무 (벡엔드,프론트엔드...)
	 * @param selectTagList	 선택한 태그(50인 이상, 식대/간식제공)
	 * @param model 데이터 전송
	 * @return
	 */
	@GetMapping("/selectedMain")
	public String selectedMain(@RequestParam String selectJobGroup ,@RequestParam(required = false) String selectJobList ,@RequestParam(required = false) String selectTagList ,
							   @RequestParam(defaultValue = "0",required = false) int total,@RequestParam(defaultValue = "0",required = false) int currentPage,  @RequestParam(required = false) String selectJobNmList ,Model model,Principal principal) {

		{// 채용공고 조건 검색 조건들 가져오기
			List<String> codeList= new ArrayList<String>();

			codeList.add("JOB");
			codeList.add(selectJobGroup);
			codeList.add("TAG");

			//DB에서 검색 공통코드 가져오기
			Map<String, List<CommonCodeVO>> allcodeMap = this.enterpriseservice.getAllCommonCodeList(codeList);

			//직군, 태그 공통 코드 전송
			model.addAttribute("codeMap", allcodeMap);
			}



		log.debug("total {} ",total);
		log.debug("currentPage {} ",currentPage);
		log.debug("selectJobGroup {} ",selectJobGroup);
		log.debug("selectJobList {} ",selectJobList);
		log.debug("selectTagList {} ",selectTagList);
		log.debug("selectJobNmList {} ",selectJobNmList);

		Map<String,Object> statusInfo = new HashedMap();

		statusInfo.put("total", total);
		statusInfo.put("currentPage", 0);

		int count = 0;
		//null 체크
		if(selectJobGroup.equals("")) { statusInfo.put("selectJobGroup", null);  }else { statusInfo.put("selectJobGroup", selectJobGroup); ++count;log.debug("count 잡그룹 올라간다 {}",count);}
		if(selectJobList.equals(""))  { statusInfo.put("selectJobList", null); }else { statusInfo.put("selectJobList", selectJobList); ++count; log.debug("count 잡 올라간다 {}",count);}
		if(selectTagList.equals(""))  { statusInfo.put("selectTagList", null); }else { statusInfo.put("selectTagList", selectTagList); ++count; log.debug("count 태그 올라간다 {}",count);}

		log.debug("count 올라간다 {}",count);
		log.debug("조건 확인 {}",count > 0);


		log.debug("jsonData 값 확인 {}",statusInfo);
		Map<String,Object> getJobPostingMap = null;
		// 조건이 없을때
		if(count == 0) {
			log.debug("count 0개 들어옴",count);
			getJobPostingMap =this.jobPostingService.getJobPosting();
		}
		// 조건이 있을때
		if(count > 0) {
			log.debug("count 들어옴",count);
			getJobPostingMap = this.jobPostingService.getSearchJobPost(statusInfo);
		}
		log.debug("getJobPostingMap 값 확인 {}",getJobPostingMap);


		ArticlePage<JobPostingVO> articlePage = (ArticlePage)getJobPostingMap.get("articlePage");
		log.debug("articlePage total size 값 확인 {}",articlePage.getContent().size());

		if(selectJobGroup.equals("")) {
			model.addAttribute("selectJobGroup",null);
		}else {
			model.addAttribute("selectJobGroup",selectJobGroup);
		}
		model.addAttribute("jobPostingList" , articlePage);
//		model.addAttribute("selectJobGroup" , selectJobGroup);
		model.addAttribute("selectJobList"  , selectJobList);
		model.addAttribute("selectJobNmList", selectJobNmList);
		model.addAttribute("selectTagList"  , selectTagList);

		return "jobPosting/main";
	}


	/** 상세 채용공고로 이동
	 * @param jobPstgNo
	 * @return
	 */
	@GetMapping("/detailJobPosting")
	public String detailJobPosting(@RequestParam String jobPstgNo,Principal principal, Model model ) {
//		log.debug("detailJobPosting 왔다.");
		if(principal !=null) {
			String userId = principal.getName();
//		log.debug("유저 아이디 확인 {}",principal.getName());
			MemVO memVO = this.jobPostingService.getLoginMemVO(userId);

			List<ResumeVO> resumeVOList = memService.getMyResume();
			List<AttachmentVO> attVOList = this.jobPostingService.getAttachmentList(memVO.getMemId());
			log.debug("attVOList 나야 {}",attVOList);
			model.addAttribute("memVO", memVO);
			model.addAttribute("resumeVOList", resumeVOList);
			model.addAttribute("attVOList", attVOList);


		}



		 JobPostingVO detailJobPosting = this.jobPostingService.detailJobPosting(jobPstgNo);

		 model.addAttribute("jobPstgNo", jobPstgNo);
		 model.addAttribute("detailJobPosting", detailJobPosting);

		 RecordVO recordVO = new RecordVO();
		 recordVO.setEtpId(jobPstgNo);
		 recordService.setRecord(recordVO);

		return "jobPosting/detail";

	}

	/** 이력서 지원 유무 체크
	 * @param employStatusVO
	 * @return
	 */
	@ResponseBody
	@PostMapping("/JobPostingApplyCheck")
	public boolean JobPostingApplyCheck(@ModelAttribute EmployStatusVO employStatusVO) {
		log.debug("employStatusVO 들어왔다.{}",employStatusVO);
		log.debug("나 지원하기 체크에 들어왔다.");

		boolean successCheck = this.jobPostingService.JobPostingApplyCheck(employStatusVO);

		return successCheck;
	}

	/** 이력서 지원
	 * URI : /jobPosting/JobPostingApply
	 * @param rsmNo 이력서 번호
	 * @param memId 회원 아이디
	 * @param jobPstgNo 채용공고 번호
	 * @return
	 */
	@ResponseBody
	@PostMapping("/JobPostingApply")
	public int JobPostingApply(@ModelAttribute EmployStatusVO employStatusVO) {
		log.debug("employStatusVO 들어왔다.{}",employStatusVO);
		log.debug("나 지원하기에 들어왔다.");

		int successCheck = this.jobPostingService.applyToResume(employStatusVO);

		return successCheck;
	}


	/**
	 * URI : /jobPosting/uploadFile
	 * @param formData
	 * memId 회원 아이디
	 * resumeFile 첨부파일
	 * @return
	 */
	@ResponseBody
	@PostMapping("/uploadFile")
	public List<AttachmentVO> uploadFile(@ModelAttribute MemVO memVO){
		log.debug("memVO 들어왔다.{}",memVO);
		MultipartFile[] uploadFile = memVO.getUploadFile();
		String memId = memVO.getMemId();

		if(uploadFile[0].getOriginalFilename() != null && !uploadFile[0].getOriginalFilename().equals("")) {
			this.attchService.attachInsert(memVO.getUploadFile(), memVO);
		}

		List<AttachmentVO> attVOList = this.jobPostingService.getAttachmentList(memId);
		log.debug("attVOList 들어왔다.{}",attVOList);

		return attVOList;
	}

	/** 채용 공고를 가져오는 메서드(ajax)
	 * @param articlePage
	 * @return
	 */
	@ResponseBody
	@PostMapping("/getPage")
	public ArticlePage<JobPostingVO> getPage(@RequestBody Map<String,Object> statusInfo,Model model) {
		// 값 세팅
		String selectJobGroup =(String)statusInfo.get("selectJobGroup");
		String selectJobList =(String)statusInfo.get("selectJobList");
		String selectTagList =(String)statusInfo.get("selectTagList");
		int total = (int)statusInfo.get("total");

		statusInfo.put("total",total);
		//값이 없을 경우
		if(selectJobGroup.equals("")) { statusInfo.put("selectJobGroup", null);}
		if(selectJobList.equals(""))  { statusInfo.put("selectJobList", null);}
		if(selectTagList.equals(""))  { statusInfo.put("selectTagList", null);}


		log.debug("statusInfo 값 확인 {}",statusInfo);

		Map<String,Object> getJobPostingMap = this.jobPostingService.getSearchJobPost(statusInfo);


		ArticlePage<JobPostingVO> articlePage = (ArticlePage)getJobPostingMap.get("articlePage");


		model.addAttribute("selectJobGroup",(String)getJobPostingMap.get("selectJobGroup"));
		model.addAttribute("selectJobList",  selectJobList);
		model.addAttribute("selectTagList",selectTagList);

		 return articlePage;
	}


	/** 북마크 유무를 체크하는 메서드
	 * URL : /jobPosting/bookMarkCheck
	 * @param jobPstgNo 채용공고번호
	 * @return 유 true , 무 false
	 */
	@ResponseBody
	@PostMapping("/bookMarkCheck")
	public boolean bookMarkCheck(@RequestBody Map<String, String> jobPstgNoData) {

		log.debug("bookMarkCheck 들어왔나?");
		log.debug("jobPstgNo 값 확인 {}",jobPstgNoData.get("jobPCstgNo"));

//		return  this.jobPostingService.getbookMarkCheckState(jobPstgNo);
		return  this.jobPostingService.getbookMarkCheckState(jobPstgNoData.get("jobPCstgNo"));
	}
}
