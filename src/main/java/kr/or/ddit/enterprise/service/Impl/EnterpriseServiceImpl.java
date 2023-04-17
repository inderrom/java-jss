package kr.or.ddit.enterprise.service.Impl;

import java.io.Console;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.preauth.PreAuthenticatedAuthenticationToken;
import org.springframework.stereotype.Service;

import kr.or.ddit.enterprise.controller.EnterpriseController;
import kr.or.ddit.enterprise.mapper.EnterpriseMapper;
import kr.or.ddit.enterprise.service.EnterpriseService;
import kr.or.ddit.security.CustomUserDetailsService;
import kr.or.ddit.vo.CommonCodeVO;
import kr.or.ddit.vo.EmployStatusVO;
import kr.or.ddit.vo.EnterpriseMemVO;
import kr.or.ddit.vo.EnterpriseSkillVO;
import kr.or.ddit.vo.EnterpriseVO;
import kr.or.ddit.vo.JobPostingSkillVO;
import kr.or.ddit.vo.JobPostingTagVO;
import kr.or.ddit.vo.JobPostingVO;
import kr.or.ddit.vo.RequireJobVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class EnterpriseServiceImpl implements EnterpriseService {

	// 의존성 주입
	@Autowired
	EnterpriseMapper enterprisemapper;

	// 채용공고 목록 리스트
	@Override
	public List<JobPostingVO> jobPostingList(Map<String, String> pagination) {
		return this.enterprisemapper.jobPostingList(pagination);
	}

	// 채용공고 등록
	@Override
	public int jobPostingInsert(JobPostingVO jobPostingVO, List<String> selectTagList, List<String> selectJobList,
			List<String> selectSkillList) {

		// 최신 채용 번호 가져오기
		String jobPstgNo = enterprisemapper.getjobPstgNo();
		log.info(jobPstgNo);
		// 채용공고 번호 넣기
		jobPostingVO.setJobPstgNo(jobPstgNo);
		int result = 0;
		// 채용 공고 등록
		result = enterprisemapper.jobPostingInsert(jobPostingVO);

		// JOB_POSTING_TAG insert
		if (selectTagList.size() != 0 && selectTagList != null) {

			// List<JobPostingTagVO> 생성
			List<JobPostingTagVO> tagVOList = new ArrayList<JobPostingTagVO>();

			// List의 값을 1개씩 insert
			for (int i = 0; i < selectTagList.size(); i++) {
				JobPostingTagVO jobPostingTagVO = new JobPostingTagVO();
				CommonCodeVO codeVO = new CommonCodeVO();

				// VO에 값넣기
				codeVO = this.enterprisemapper.getCommenCode(selectTagList.get(i));

				jobPostingTagVO.setJobPstgNo(jobPstgNo);
				jobPostingTagVO.setJobPstgTagNm(codeVO.getCmcdDtlNm());
				jobPostingTagVO.setJobPstgTagNo(codeVO.getCmcdDtl());
				// List에 담기
				tagVOList.add(jobPostingTagVO);
			}
			// VOList insert
			result += this.enterprisemapper.insertTagList(tagVOList);

		}

		// 직업 insert
		if (selectJobList.size() != 0 && selectJobList != null) {
			List<RequireJobVO> requireJobVOList = new ArrayList<RequireJobVO>();

			// List의 값을 1개씩 insert
			for (int i = 0; i < selectJobList.size(); i++) {
				RequireJobVO jobVO = new RequireJobVO();
				CommonCodeVO codeVO = new CommonCodeVO();

				// VO에 값넣기
				codeVO = this.enterprisemapper.getCommenCode(selectJobList.get(i));

				jobVO.setJobPstgNo(jobPstgNo);
				jobVO.setRqrJobNm(codeVO.getCmcdDtlNm());
				jobVO.setRqrJobNo(codeVO.getCmcdDtl());

				requireJobVOList.add(jobVO);
			}

			result += enterprisemapper.insertJobList(requireJobVOList);
		}

		// 스킬 insert
		if (selectSkillList.size() != 0 && selectSkillList != null) {
			List<JobPostingSkillVO> jobPostingSkillVOList = new ArrayList<JobPostingSkillVO>();

			// List의 값을 1개씩 insert
			for (int i = 0; i < selectSkillList.size(); i++) {
				JobPostingSkillVO skillVO = new JobPostingSkillVO();
				CommonCodeVO codeVO = new CommonCodeVO();

				// VO에 값넣기
				codeVO = this.enterprisemapper.getCommenCode(selectSkillList.get(i));

				skillVO.setJobPstgNo(jobPstgNo);
				skillVO.setJobPstgSklNm(codeVO.getCmcdDtlNm());
				skillVO.setJobPstgSklNo(codeVO.getCmcdDtl());

				jobPostingSkillVOList.add(skillVO);
			}

			result += enterprisemapper.insertSkillList(jobPostingSkillVOList);
		}

		return result;
	}

	// 기업 서비스 회원 체크
	@Override
	public Map<String, String> enterpriseCheck(String memId) {
		return this.enterprisemapper.enterpriseCheck(memId);
	}

	// 공통 코드리스트 가져오기
	@Override
	public List<CommonCodeVO> getCodeList(String jobCode) {
		return this.enterprisemapper.getCodeList(jobCode);
	}

	/**
	 * 상세 채용 공고 가져오기 jobPstgNo로 상세 채용 공고 가져온다.
	 */
	@Override
	public JobPostingVO getDetailJobPosting(String jobPstgNo) {
		return this.enterprisemapper.getDetailJobPosting(jobPstgNo);
	}

	/**
	 * 모든 공통코드 가져오기
	 *
	 */
	@Override
	public List<CommonCodeVO> getAllCommonCodeList() {
		return this.enterprisemapper.getAllCommonCodeList();
	}

	/**
	 * 모든 공통코드 리펙토링 원하는 CmcdClfc 코드를 적으면 Map에 담아서 출력
	 */
	@Override
	public Map<String, List<CommonCodeVO>> getAllCommonCodeList(List<String> commonCodeVOList) {
		List<CommonCodeVO> getAllCodeVOList = this.enterprisemapper.getAllCommonCodeList();
		//
		Map<String, List<CommonCodeVO>> outputCodeVOMap = new HashMap<String, List<CommonCodeVO>>();

		for (int i = 0; i < commonCodeVOList.size(); i++) {

			List<CommonCodeVO> CodeVOList = new ArrayList<CommonCodeVO>();

			for (int j = 0; j < getAllCodeVOList.size(); j++) {
				if (getAllCodeVOList.get(j).getCmcdClfc().equals(commonCodeVOList.get(i))) {
					CodeVOList.add(getAllCodeVOList.get(j));
				} // end if
			} // j for

			outputCodeVOMap.put(commonCodeVOList.get(i), CodeVOList);
		} // i for

		return outputCodeVOMap;
	}

	/**
	 * 채용 공고 스킬 가져오기
	 *
	 */
	@Override
	public List<JobPostingSkillVO> getSkillList(String jobPstgNo) {
		return this.enterprisemapper.getSkillList(jobPstgNo);
	}

	/**
	 * 채용 공고 태그 가져오기
	 *
	 */
	@Override
	public List<JobPostingTagVO> getTagList(String jobPstgNo) {
		return this.enterprisemapper.getTagList(jobPstgNo);
	}

	/**
	 * 채용 공고 직업 가져오기
	 *
	 */
	@Override
	public List<RequireJobVO> getJobList(String jobPstgNo) {
		return this.enterprisemapper.getJobList(jobPstgNo);
	}

	/**
	 * 직군 찾기
	 *
	 */
	@Override
	public CommonCodeVO getselectJobGroup(String rqrJobNo) {
		return this.enterprisemapper.getselectJobGroup(rqrJobNo);
	}

	/**
	 * 채용공고 수정
	 *
	 */
	@Override
	public int modifyJobPosting(JobPostingVO jobPostingVO, List<String> selectJobList, List<String> selectSkillList,
			List<String> selectTagList) {

		// 수정할 채용공고 번호 추출
		String jobPstgNo = jobPostingVO.getJobPstgNo();

		int result = 0;
		result = this.enterprisemapper.jobPostingInsert(jobPostingVO);
		log.info("수정 확인 : " + result);

		// 직무 수정
		if (selectJobList.size() != 0 && selectJobList != null) {

			// 직무 내용 삭제
			result = enterprisemapper.deleteByJobJobPstgNo(jobPstgNo);
			log.info("직무 삭제 확인 : " + result);

			// 직무 내용 수정
			log.info(" selectJobList modify check");
			List<RequireJobVO> requireJobVOList = new ArrayList<RequireJobVO>();

			// List의 값을 1개씩 insert
			for (int i = 0; i < selectJobList.size(); i++) {
				RequireJobVO jobVO = new RequireJobVO();
				CommonCodeVO codeVO = new CommonCodeVO();

				// VO에 값넣기
				codeVO = this.enterprisemapper.getCommenCode(selectJobList.get(i));

				jobVO.setJobPstgNo(jobPstgNo);
				jobVO.setRqrJobNm(codeVO.getCmcdDtlNm());
				jobVO.setRqrJobNo(codeVO.getCmcdDtl());

				requireJobVOList.add(jobVO);
			}

			result += enterprisemapper.insertJobList(requireJobVOList);
		}

		// 스킬 수정
		if (selectSkillList.size() != 0 && selectSkillList != null) {

			// 직무 내용 삭제
			result = enterprisemapper.deleteBySkillJobPstgNo(jobPstgNo);

			// 직무 내용 수정
			List<JobPostingSkillVO> jobPostingSkillVOList = new ArrayList<JobPostingSkillVO>();

			// List의 값을 1개씩 insert
			for (int i = 0; i < selectSkillList.size(); i++) {
				JobPostingSkillVO skillVO = new JobPostingSkillVO();
				CommonCodeVO codeVO = new CommonCodeVO();

				// VO에 값넣기
				codeVO = this.enterprisemapper.getCommenCode(selectSkillList.get(i));

				skillVO.setJobPstgNo(jobPstgNo);
				skillVO.setJobPstgSklNm(codeVO.getCmcdDtlNm());
				skillVO.setJobPstgSklNo(codeVO.getCmcdDtl());

				jobPostingSkillVOList.add(skillVO);
			}

			result += enterprisemapper.insertSkillList(jobPostingSkillVOList);
		}
		// 채용공고 태그 수정
		if (selectTagList.size() != 0 && selectTagList != null) {

			// 직무 내용 삭제
			result = enterprisemapper.deleteByTagJobPstgNo(jobPstgNo);

			// 직무 내용 수정
			List<JobPostingTagVO> jobPostingTagVOList = new ArrayList<JobPostingTagVO>();

			// List의 값을 1개씩 insert
			for (int i = 0; i < selectTagList.size(); i++) {
				JobPostingTagVO tagVO = new JobPostingTagVO();
				CommonCodeVO codeVO = new CommonCodeVO();

				// VO에 값넣기
				codeVO = this.enterprisemapper.getCommenCode(selectTagList.get(i));

				tagVO.setJobPstgNo(jobPstgNo);
				tagVO.setJobPstgTagNm(codeVO.getCmcdDtlNm());
				tagVO.setJobPstgTagNo(codeVO.getCmcdDtl());

				jobPostingTagVOList.add(tagVO);
			}

			result += enterprisemapper.insertTagList(jobPostingTagVOList);
		}

		return result;
	}

	/**
	 * 채용공고 삭제 jobPstgNo로 채용공고 직무, 태그, 스킬 삭제한다.
	 */
	@Override
	public int deleteJobPosting(String jobPstgNo) {
		// 직군 테이블 삭제
		int result = enterprisemapper.deleteByJobJobPstgNo(jobPstgNo);
		// 스킬 테이블 삭제
		result = enterprisemapper.deleteBySkillJobPstgNo(jobPstgNo);
		// 태그 테이블 삭제
		result = enterprisemapper.deleteByTagJobPstgNo(jobPstgNo);
		// 채용공고 테이블 삭제
		result = enterprisemapper.deleteJobPosting(jobPstgNo);

		return result;
	}

	/**
	 * 기업회원 정보등록
	 *
	 * @param entVO 등록할 정보가 담긴 entVO
	 * @return 등록한 기업의 번호
	 */
	public void enterpriseJoin(EnterpriseVO entVO) {
		this.enterprisemapper.enterpriseJoin(entVO);
	}

	@Override
	public void enterpriseMemInsert(EnterpriseMemVO entVO) {
		this.enterprisemapper.enterpriseMemInsert(entVO);
	}

	/**
	 * 기업회원 기본정보 수정
	 *
	 * @param entVO 수정할 기업의 정보가 담긴 EnterpriseVO
	 */
	@Override
	public void enterpriseUpdate(EnterpriseVO entVO) {
		this.enterprisemapper.enterpriseUpdate(entVO);
	}

	/**
	 * 기업회원 담당자정보 수정
	 *
	 * @param entMemVO 수정할 기업의 정보가 담긴 EnterpriseMemVO
	 */
	@Override
	public void enterpriseMemUpdate(EnterpriseMemVO entMemVO) {
		this.enterprisemapper.enterpriseMemUpdate(entMemVO);
	}

	@Override
	public void entSkillUpdate(EnterpriseVO entVO) {
		this.enterprisemapper.entSkillUpdate(entVO);
	}

	/**
	 * 로그인한 기업회원의 모든 채용공고 총 개수 가져오기
	 *
	 * @param entNo 기업회원
	 * @return total
	 */
	@Override
	public int getTotalJobPosting(String entNo) {
		return this.enterprisemapper.getTotalJobPosting(entNo);
	}

	@Override
	public List<Map<String, String>> getEmployState(Map<String, String> map) {
		return this.enterprisemapper.getEmployState(map);
	}

	@Override
	public List<Map<String, String>> getApplyList(Map<String, String> map) {
		return this.enterprisemapper.getApplyList(map);
	}

	@Override
	public List<EnterpriseSkillVO> getEntSkillList(String memId) {
		return this.enterprisemapper.getEntSkillList(memId);
	}

	@Override
	public Map<String, String> getEnterpriseDetail(String entNo) {
		return this.enterprisemapper.getEnterpriseDetail(entNo);
	}

	@Override
	public List<String> getEntAllTag(String entNo) {
		return this.enterprisemapper.getEntAllTag(entNo);
	}

	@Override
	public CommonCodeVO getCommonCode(String cmcdDtl) {
		return this.enterprisemapper.getCommenCode(cmcdDtl);
	}

	@Override
	public void updateEmpState(Map<String, String> map) {
		enterprisemapper.updateEmpState(map);
	}}
