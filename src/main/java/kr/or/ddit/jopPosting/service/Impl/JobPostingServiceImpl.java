package kr.or.ddit.jopPosting.service.Impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import kr.or.ddit.enterprise.service.EnterpriseService;
import kr.or.ddit.jopPosting.mapper.JobPostingMapper;
import kr.or.ddit.jopPosting.service.JobPostingService;
import kr.or.ddit.vo.ArticlePage;
import kr.or.ddit.vo.AttachmentVO;
import kr.or.ddit.vo.CommonCodeVO;
import kr.or.ddit.vo.EmployStatusVO;
import kr.or.ddit.vo.EnterpriseVO;
import kr.or.ddit.vo.JobPostingSkillVO;
import kr.or.ddit.vo.JobPostingTagVO;
import kr.or.ddit.vo.JobPostingVO;
import kr.or.ddit.vo.MemVO;
import kr.or.ddit.vo.RecordVO;
import lombok.extern.slf4j.Slf4j;

/**
 * @author PC-06
 *
 */
@Slf4j
@Service
public class JobPostingServiceImpl implements JobPostingService{

	@Autowired
	EnterpriseService enterpriseService;

	@Autowired
	JobPostingMapper jobPostingMapper;


	/** 회원 맞춤 채용공고 리스트
	 *
	 */
	@Override
	public Map<String, Object> getMemberCustomSearch(String memId) {
		MemVO loginMem = this.jobPostingMapper.getloginMemVO(memId);
		String memJob = loginMem.getMemJob();
		log.debug("로그인 값 확인 : {}", loginMem);
		log.debug("로그인 값 확인 : {}", memJob);
		log.debug("memJob 상태 확인 : {}", (memJob == null));

		if(memJob == null) {
			return getJobPosting();
		}
		//전체 공통코드(직군을 착기위해)
		List<CommonCodeVO> allCodeList=this.enterpriseService.getAllCommonCodeList();

		
		//회원의 직군을 찾아서 VO에 값 넣기
		for (CommonCodeVO codeVO :allCodeList) {
			String detailedCodeName = codeVO.getCmcdDtlNm();
			log.debug("상세 코드 이름 확인 : {}", detailedCodeName);

			log.debug("참 거짓 확인 : {}", (detailedCodeName.equals(memJob)));

			if(detailedCodeName.equals(memJob)) {
				log.debug("들어가는 값 확인 : {}", codeVO.getCmcdClfc());

				loginMem.setMemJobGroup(codeVO.getCmcdClfc());

				break;
			}
		}// end for

		//회원 선택한 직군 채용공고 가져오기
		int total = this.jobPostingMapper.getTotalMemSelectedJobPosting(loginMem.getMemJobGroup());
		int size = 9;
		int currentPage = 1;

		Map<String, String> pagination = new HashMap<String, String>();

		 pagination.put("mCurrentPage", currentPage+"");
		 pagination.put("mSize", size+"" ) ;
		 pagination.put("memJobGroup", loginMem.getMemJobGroup()) ;

		List<JobPostingVO> memJobPosting = this.jobPostingMapper.getMemSelectedJobPosting(pagination);

		//기업 이미지 가져오기
		settingEntImages(memJobPosting);

		// 북마크 확인
		String userID= getUserName();
		if(!userID.equals("anonymousUser")) {
			settingBookMark(memJobPosting,userID);
		}
		// 페이징 처리한 데이터와 필요 테이터 전송
		Map<String, Object> jobPosting = new HashedMap();

		jobPosting.put("ArticlePage", new ArticlePage<JobPostingVO>(total, currentPage, size, memJobPosting)) ;
		jobPosting.put("memVO",loginMem) ;


		return jobPosting;
	}


	/** 조건 x 채용공고 가져오기
	 *
	 */
	@Override
	public Map<String, Object> getJobPosting() {

		//회원 선택한 직군 채용공고 가져오기
		int total = this.jobPostingMapper.getTotalJobPosting();
		int size = 9;
		int currentPage = 1;

		Map<String, String> pagination = new HashMap<String, String>();

		 pagination.put("mCurrentPage", currentPage+"");
		 pagination.put("mSize", size+"" ) ;

		List<JobPostingVO> JobPostingList = this.jobPostingMapper.getAllJobPost(pagination);

		//기업 이미지 가져오기
		settingEntImages(JobPostingList);
		// 북마크 확인
		String userID= getUserName();
		if(!userID.equals("anonymousUser")) {
			settingBookMark(JobPostingList,userID);
		}
		// 페이징 처리한 데이터와 필요 테이터 전송
		Map<String, Object> jobPosting = new HashedMap();

		jobPosting.put("articlePage", new ArticlePage<JobPostingVO>(total, currentPage, size, JobPostingList)) ;


		return jobPosting;
	}



	/** 조건 검색 페이징
	 * @param jsonData 조건들이 담겨 있다.
	 * size - default :9
	 * total - 조건의 총 채용공고 개수
	 * currentPage - 현재 페이지
	 * selectJobGroup - 선택한 직군
	 * selectJobList - 선택한 직무 배열
	 * selectTagList - 선택한 태그 배열
	 * @return 페이징 또는 정보들
	 */
	@Override
	public Map<String, Object> getSearchJobPost(Map<String, Object> statusInfo) {
		//페이징
		String size ="9";
//		int total =(int) statusInfo.get("total");
		int currentPage = (int) statusInfo.get("currentPage");
		log.debug("currentPage  값 확인 !!!!!!!!!!!!!!!!!!!!!!! {}",currentPage);

		if( currentPage >= 1) {
		++currentPage;
		}

		if (currentPage == 0) {
			currentPage = 1;
		}

		//조건
		String selectJobGroup = (String) statusInfo.get("selectJobGroup");

		String selectJobList = (String) statusInfo.get("selectJobList");
		String selectTagList = (String) statusInfo.get("selectTagList");

		log.debug("selectJobList  값 확인 {}",selectJobList);
		log.debug("selectTagList  값 확인 {}",selectTagList);
		log.debug("selectJobGroup  값 확인 {}",selectJobGroup);

		log.debug("selectJobGroup  값 확인 {}",selectJobGroup == null);
		log.debug("selectJobList  값 확인 {}",selectJobList == null);
		log.debug("selectTagList  값 확인 {}",selectTagList == null);



		List<String> singleContent = new ArrayList<String>();

		singleContent.add(size);
//		single_content.add(total+"");
		singleContent.add(currentPage+"");

		//selectJobGroup null 처리
		if(selectJobGroup != null ) {singleContent.add(selectJobGroup);	}else {	singleContent.add("");	}

		Map<String, List<String>> conditionSearchMap = new HashedMap();

		//selectJobList null 처리
		if(selectJobList != null) {
			String[] jobArr = selectJobList.split(",");
			List<String> jobList = Arrays.asList(jobArr);
			log.debug("selectJobList null 체크후  값 확인 {}",jobList);
			conditionSearchMap.put("selectJobList", jobList);
		}else {
			List<String> jobList = new ArrayList<String>();
			conditionSearchMap.put("selectJobList", jobList);

		}

		//selectTagList null 처리
		if(selectTagList != null) {
			String[] tagArr = selectTagList.split(",");
			List<String> tagList = Arrays.asList(tagArr);
			log.debug("selectTagList null 없다 체크후  값 확인 {}",tagList);
			conditionSearchMap.put("selectTagList", tagList);
		}else {
			List<String> tagList = new ArrayList<String>();
			log.debug("selectTagList null 있다 체크후  값 확인 {}",tagList);
			conditionSearchMap.put("selectTagList", tagList);

		}

		conditionSearchMap.put("single_content", singleContent);


		log.debug("selectJobGroup 값 확인 {}",selectJobGroup);
//		log.debug("total 값 확인 {}",total);
		log.debug("currentPage 값 확인 {}",currentPage);
		log.debug("selectJobGroup 값 확인 {}",selectJobGroup);

// SQL 건들여야함
		int total = 0 ;

		// 조건인 채용공고 번호
		List<String> conditionJobposting = null;
		// 만약 아무조건이 없는경우
		boolean flag = false;
		//보내는 채용공고 리스트
		List<JobPostingVO> jobPostingList = null;
		// 태그 또는 직무가 있을 경우만 실행
//		log.debug("태그 사이즈 {} ",condition_search_map.get("selectTagList").size());
//		log.debug("잡 사이즈 {} ",condition_search_map.get("selectJobList").size());
		if(conditionSearchMap.get("selectTagList").size() > 0 || conditionSearchMap.get("selectJobList").size() > 0 ) {

			log.debug("태그 잡 중 1개만 있을때 ");
			log.debug("들어온 태그 {}",conditionSearchMap.get("selectTagList") );
			log.debug("들어온 잡 {}", conditionSearchMap.get("selectJobList"));

			conditionJobposting = this.jobPostingMapper.getConditionJobPosting(conditionSearchMap);
			total = conditionJobposting.size();
			log.debug("정말 conditionJobposting 값 확인 {}",conditionJobposting);
			log.debug("정말 total 값 확인 {}",total);

			conditionSearchMap.put("conditionJobposting", conditionJobposting);

			if(total != 0) {
			jobPostingList = this.jobPostingMapper.getConditionJobPostingList(conditionSearchMap);
			log.debug("조건의 값이 jobPostingList 값 확인 {}",jobPostingList);
			}
			if(total ==0) {flag = true;}
		}


		// 전체 또는 직군 선택시
		if(conditionSearchMap.get("selectTagList").size() == 0 && conditionSearchMap.get("selectJobList").size() == 0 || flag) {
			log.debug("태그 잡 둘다 없다!!!! ");
			log.debug("들어온 태그 {}",conditionSearchMap.get("selectTagList") );
			log.debug("들어온 잡 {}", conditionSearchMap.get("selectJobList"));
			total = this.jobPostingMapper.getTotalNoConditionsJobPosting(conditionSearchMap);
			log.debug("없는 받아온 값 total 값 확인 {}",total);
			log.debug("condition_search_mapl 값 확인 {}",conditionSearchMap);

			jobPostingList = this.jobPostingMapper.getNoConditionsJobPosting(conditionSearchMap);
		}



//		log.debug("정말 total 값 확인 {}",total);
//		log.debug("정말 JobPostingList 값 확인 {}",jobPostingList);


		// 조건에서 뽑은 채용공고 리스트에 대표이미지 담기
		settingEntImages(jobPostingList);
		// 북마크 확인
		String userID= getUserName();
		if(!userID.equals("anonymousUser")) {
			settingBookMark(jobPostingList,userID);
		}

		ArticlePage<JobPostingVO> articlePage = new ArticlePage<JobPostingVO>(total, currentPage, Integer.parseInt(size), jobPostingList);


		Map<String, Object> jobPostingInfo = new HashedMap();

		{
		jobPostingInfo.put("articlePage", articlePage);
		jobPostingInfo.put("selectJobList",selectJobList);
		jobPostingInfo.put("selectTagList",selectTagList);
		jobPostingInfo.put("selectJobGroup", selectJobGroup);
		}

		return jobPostingInfo;
	}


	/** 북마크 상태 체크
	 *
	 */
	@Override
	public boolean getbookMarkCheckState(String jobPstgNo) {

		log.debug("getbookMarkCheckState 들어 왔나");
		log.debug("jobPstgNo 쳌쳌 {}",jobPstgNo);
		boolean checkYN = false;


		Map<String, String> bookMarkMap = new HashMap<String, String>();
		bookMarkMap.put("userID", getUserName());
		bookMarkMap.put("jobPstgNo", jobPstgNo);

		String bookMarkYN = this.jobPostingMapper.getBookMark(bookMarkMap);

		if(bookMarkYN== null) {
			bookMarkYN="N";
		}

		log.debug("정말 bookMark_YN 값 확인 {}",bookMarkYN);
		log.debug("정말 bookMark_YN.equals 값 확인 {}",bookMarkYN.equals("Y"));
		if (bookMarkYN.equals("Y")) {
			log.debug("Y 다1! {}");
			checkYN = true;
		}

		return checkYN;
	}


	/** 상세 채용공고, 태그, 직무, 스킬 가져오기
	 * @param jobPstgNo 채용공고 번호로 가져온다.
	 * @return JobPostingVO
	 * attachmentList			대표사진 리스트
	 * requireJobVOList 		채용공고 선택 직무List
	 * jobPostingTagVOList		채용공고 선택 태그List
	 * jobPostingSkillVOList	채용공고 선택 스킬List
	 */
	@Override
	public JobPostingVO detailJobPosting(String jobPstgNo) {


		List<JobPostingVO> detailJobPosting = this.jobPostingMapper.getDetailJobPosting(jobPstgNo);


		List<JobPostingTagVO> tagVOList= this.jobPostingMapper.getTag(jobPstgNo);
		List<JobPostingSkillVO> skillVOList= this.jobPostingMapper.getSkill(jobPstgNo);

		detailJobPosting.get(0).setJobPostingSkillVOList(skillVOList);
		detailJobPosting.get(0).setJobPostingTagVOList(tagVOList);

		// 북마크 가져오기
		String userID= getUserName();
		if(!userID.equals("anonymousUser")) {
			settingBookMark(detailJobPosting,userID);

		}

		settingEntInfo(detailJobPosting);

		log.debug("detailJobPosting 체크 {}",detailJobPosting);
		log.debug("detailJobPosting 체크 {}",detailJobPosting.get(0));

		return detailJobPosting.get(0);
	}


	/** 유저 아이디로 회원 정보 불러오기
	 * @param userId
	 * @return MemVO
	 */
	@Override
	public MemVO getLoginMemVO(String userId) {
		return this.jobPostingMapper.getLoginMemVO(userId);
	}



	/** 파일 등록후 모든 채용공고에 등록 된 파일을 불러기
	 * @param memId 회원 아이디
	 * @return List<AttachmentVO>
	 */
	@Override
	public List<AttachmentVO> getAttachmentList(String memId) {
		List<AttachmentVO> attachmentVOList = this.jobPostingMapper.getAttachmentList(memId);
		log.debug("attachmentVOList {}",attachmentVOList);
		splitFileName(attachmentVOList);

		return attachmentVOList;
	}


	/** 이력서 지원 유무 체크
	 * @param employStatusVO
	 * @return
	 */
	@Override
	public boolean JobPostingApplyCheck(EmployStatusVO employStatusVO) {
		boolean check = true;

		String rsmNo = employStatusVO.getRsmNo();

		MemVO memVO = this.jobPostingMapper.getMemIdForResume(rsmNo);

		log.debug("memVO.getMemId 확인 {}",memVO.getMemId());
		log.debug("employStatusVO.getJobPstgNo 확인 {}",employStatusVO.getJobPstgNo());
		Map<String, String>  applyCheckMap = new HashMap();
		applyCheckMap.put("memId", memVO.getMemId());
		applyCheckMap.put("jobPstgNo",employStatusVO.getJobPstgNo());

		int count = this.jobPostingMapper.getAllJobPostingResume(applyCheckMap);
		log.debug("count 확인 {}",count);

		if(count>0) {
			check =false;
		}
		log.debug("check 확인 {}",check);

		return check;
	}




	//파일 이름 분리
	public void splitFileName(List<AttachmentVO> attachmentVOList) {
		for(AttachmentVO attachment :attachmentVOList) {
			 int check = attachment.getAttNm().indexOf("_");
			 ++check;
			 log.debug("check 값 확인 {}",check);
			String realFileName =attachment.getAttNm().substring(check, attachment.getAttNm().length());
			int checkCheck = realFileName.indexOf(".");


			String fileName =  realFileName.substring(0,checkCheck);
			log.debug("fileName {}",fileName);
			String fileType =realFileName.substring(checkCheck+1,realFileName.length());
			log.debug("fileType {}",fileType);

			attachment.setAttNm(fileName);
			attachment.setAttClfcNm(fileType);
		}
	}
	// 기업 정보 세팅
	public void settingEntInfo(List<JobPostingVO> JobPostingList) {
		for (JobPostingVO jpVO :JobPostingList ) {
			String entNo =  jpVO.getEntNo();

			EnterpriseVO entInfo =this.jobPostingMapper.getEntInfo(entNo);
			log.debug("entInfo 체크 {}",entInfo);

			jpVO.setEnterpriseVO(entInfo);
		}
	}

	// 북마크 세팅
	public void settingBookMark(List<JobPostingVO> JobPostingList,String userID) {
		for (JobPostingVO jpVO :JobPostingList ) {

			Map<String, String> bookMarkMap = new HashMap<String, String>();
			bookMarkMap.put("userID", userID);
			bookMarkMap.put("jobPstgNo", jpVO.getJobPstgNo());

			String recBmkYn =this.jobPostingMapper.getBookMark(bookMarkMap);

			boolean getRecBmkYn= false;
			log.debug("북마크 recBmkYn 값 확인 {}",recBmkYn);

			if(recBmkYn== null) {
				recBmkYn="N";
			}

			if(recBmkYn.equals("Y") ) {
				getRecBmkYn = true;
				log.debug("북마크 getRecBmkYn 값 확인 {}",getRecBmkYn);
			}

			jpVO.setRecBmkYn(getRecBmkYn);
		}
	}
	// 기업 이미지 세팅
	public void settingEntImages(List<JobPostingVO> JobPostingList) {
		for (JobPostingVO jpVO :JobPostingList ) {
			String entNo =  jpVO.getEntNo();

			List<AttachmentVO> attachmentList=this.jobPostingMapper.getOneEntImages(entNo);

			jpVO.setAttachmentList(attachmentList);
		}
	}


	// 유저 아이디 가져오는 메서드
	private String getUserName() {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();


		if(principal instanceof String) {
			return (String)principal;

		}else {
			UserDetails userDetails = (UserDetails) principal;
			return userDetails.getUsername();
		}

	}

	/** 이력서 지원
	 * @param employStatusVO
	 * jobPstgNo 채용공고 번호
	 * rsmNo 이력서 번호
	 * attNo 첨부파일 번호
	 * @return 성공 양수 실패 0 또는 음수
	 */
	@Override
	public int applyToResume(EmployStatusVO employStatusVO) {
		int result = 0;
		result += this.jobPostingMapper.signUpEmploy(employStatusVO);
		log.debug("1번 result {}",result);
		log.debug("employStatusVO {}",employStatusVO);
		result += this.jobPostingMapper.signUpEmployStatus(employStatusVO);
		log.debug("employStatusVO {}",employStatusVO);
		log.debug("2번 result {}",result);


		return result;
	}


	@Override
	public List<Map<String, String>> mainJobPostingRecomm() {
		return this.jobPostingMapper.mainJobPostingRecomm();
	}





}
