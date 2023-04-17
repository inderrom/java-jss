package kr.or.ddit.mem.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.preauth.PreAuthenticatedAuthenticationToken;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.common.service.AttachService;
import kr.or.ddit.mem.mapper.MemMapper;
import kr.or.ddit.mem.service.MemService;
import kr.or.ddit.security.CustomUserDetailsService;
import kr.or.ddit.vo.AcademicBackgroundVO;
import kr.or.ddit.vo.AchievementVO;
import kr.or.ddit.vo.AwardsVO;
import kr.or.ddit.vo.BoardCommentVO;
import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.CareerVO;
import kr.or.ddit.vo.CommonCodeVO;
import kr.or.ddit.vo.EnterpriseVO;
import kr.or.ddit.vo.LanguageScoreVO;
import kr.or.ddit.vo.LanguageVO;
import kr.or.ddit.vo.MemAuthVO;
import kr.or.ddit.vo.MemVO;
import kr.or.ddit.vo.MySkillVO;
import kr.or.ddit.vo.ResumeVO;
import kr.or.ddit.vo.TicketVO;
import kr.or.ddit.vo.VipVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MemServiceImpl implements MemService {

	@Autowired
	private MemMapper memMapper;
	
	@Autowired
	private CustomUserDetailsService customUserDetailsService;

	@Autowired
	private AttachService<MemVO> memAttachService;


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

	@Override
	public int memJoin(MemVO memVO) {
		memVO.setMemAuth("ROLE_NORMAL");
		memVO.setMemKakaoYn("N");
		memVO.setMemPrvcClctAgreYn("Y"); // 개인정보수집동의
		memVO.setMemRlsYn("Y");
		return memMapper.memJoin(memVO);
	}

	@Override
	public int entJoinPost(EnterpriseVO entVO) {
		int joinResult = memMapper.entJoinPost(entVO);
		if (joinResult > 0) {
			MemAuthVO memAuthVO = new MemAuthVO();
			memAuthVO.setMemId(entVO.getMemId());
			memAuthVO.setAuth("ROLE_ENTERPRISE");
			memMapper.grantMemAuth(memAuthVO);
		}
		return joinResult;
	}

	@Override
	public int existMem(String memId) {
		int result = 0;
		MemVO memVO = memMapper.existMem(memId);
		log.info(memVO+"");
		if (memVO != null) {
			result = 1;
			if("Y".equals(memVO.getMemKakaoYn())) {
				result = 2;
			}
		}
		return result;
	}

	@Override
	public void kakaoLogin(MemVO memVO) {
		this.memMapper.kakaoLogin(memVO);
	}

	@Override
	public MemVO memSearch(String memId) {
		return this.memMapper.memSearch(memId);
	}

	@Override
	public List<BoardVO> myBoardList(String memId) {
		return this.memMapper.myBoardList(memId);
	}

	@Override
	public int getTotal(Map<String, Object> map) {
		return this.memMapper.getTotal(map);
	}

	@Override
	public List<BoardCommentVO> myCmntList(String memId) {
		return this.memMapper.myCmntList(memId);
	}

	@Override
	public List<Map<String, String>> getMyEmployStatus() {
		MemVO memVO = new MemVO();
		memVO.setMemId(this.getUserName());
		return this.memMapper.getMyEmployStatus(memVO);
	}

	@Override
	public int updateMem(Map<String, String> param) {
		param.put("memId", this.getUserName());
		int result = this.memMapper.updateMem(param);

		this.setUserDetails();

		return result;
	}

	@Override
	public List<ResumeVO> getMyResume() {
		String memId = this.getUserName();
		return this.memMapper.getMyResume(memId);
	}

	@Override
	public List<CommonCodeVO> getCommonCode(Map<String, String> map) {
		return this.memMapper.getCommonCode(map);
	}

	@Override
	public int createResume(ResumeVO resumeVO) {
		resumeVO.setMemId(this.getUserName());
		return this.memMapper.createResume(resumeVO);
	}

	@Override
	public void insertInformation(MemVO memVO) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		List<GrantedAuthority> updatedAuthorities = new ArrayList<>(auth.getAuthorities());
		updatedAuthorities.add(new SimpleGrantedAuthority("ROLE_NORMAL"));
		Authentication newAuth = new UsernamePasswordAuthenticationToken(auth.getPrincipal(), auth.getCredentials(), updatedAuthorities);
		SecurityContextHolder.getContext().setAuthentication(newAuth);

		this.memMapper.insertInformation(memVO);
	}

	@Override
	public int updatePass(Map<String, String> map) {
		return this.memMapper.updatePass(map);
	}

	@Transactional
	@Override
	public void updateResume(ResumeVO resumeVO) {
		String[] arrTblNm = {"ACADEMIC_BACKGROUND", "CAREER", "MY_SKILL", "LANGUAGE", "AWARDS"};
		Map<String, String> map = new HashMap<String, String>();
		map.put("rsmNo", resumeVO.getRsmNo());
		for(String tblNm : arrTblNm) {
			map.put("tblNm", tblNm);
			this.memMapper.deleteResumeData(map);
		}
		this.memMapper.updateResume(resumeVO);

		if(resumeVO.getAcademicList() != null) {
			for(AcademicBackgroundVO acbgVO : resumeVO.getAcademicList()) {
				acbgVO.setRsmNo(resumeVO.getRsmNo());
			}
			this.memMapper.insertAcademicBackground(resumeVO.getAcademicList());
		}

		if(resumeVO.getCareerVOList() != null) {
			for(CareerVO careerVO : resumeVO.getCareerVOList()) {
				careerVO.setRsmNo(resumeVO.getRsmNo());
				this.memMapper.insertCareer(careerVO);

				if(careerVO.getAchievementVOList() != null) {
					for(AchievementVO achievementVO: careerVO.getAchievementVOList()) {
						achievementVO.setRsmNo(resumeVO.getRsmNo());
						achievementVO.setCrrNo(careerVO.getCrrNo());
					}
					this.memMapper.insertAchievement(careerVO.getAchievementVOList());
				}
			}
		}

		if(resumeVO.getMySkillList() != null) {
			for(MySkillVO mySklVO : resumeVO.getMySkillList()) {
				mySklVO.setRsmNo(resumeVO.getRsmNo());
			}
			this.memMapper.insertMySkill(resumeVO.getMySkillList());
		}

		if(resumeVO.getLanguageVOList() != null) {
			for(LanguageVO lanVO : resumeVO.getLanguageVOList()) {
				lanVO.setRsmNo(resumeVO.getRsmNo());
			}
			this.memMapper.insertLanguage(resumeVO.getLanguageVOList());
			for(LanguageVO lanVO : resumeVO.getLanguageVOList()) {
				if(lanVO.getLanguageScoreVOList() != null) {
					for(LanguageScoreVO lanScoreVO : lanVO.getLanguageScoreVOList()) {
						lanScoreVO.setRsmNo(resumeVO.getRsmNo());
						lanScoreVO.setLanNo(lanVO.getLanNo());
					}
					this.memMapper.insertLanguageScore(lanVO.getLanguageScoreVOList());
				}
			}
		}

		if(resumeVO.getAwardsVOList() != null) {
			for(AwardsVO awardsVO : resumeVO.getAwardsVOList()) {
				awardsVO.setRsmNo(resumeVO.getRsmNo());
			}
			this.memMapper.insertAwards(resumeVO.getAwardsVOList());
		}

	}

	@Override
	public ResumeVO resumeDetail(ResumeVO resumeVO) {
		return this.memMapper.resumeDetail(resumeVO);
	}


	@Override
	public List<VipVO> myMembership(String memId) {
		return this.memMapper.myMembership(memId);
	}

	// vipNo 가져오기
	@Override
	public String getNextVipNo() {
		return this.memMapper.getNextVipNo();
	}

	@Override
	public int insertVip(VipVO vipVO) {
		int result = 0;
		result = this.memMapper.insertVip(vipVO);
		if(result > 0) {
			TicketVO ticketVO = new TicketVO();
			ticketVO.setVipNo(vipVO.getVipNo());
			int tcktQntt = 30;
			if(vipVO.getVipGrdNo().equals("VIPGRD0003")) {
				tcktQntt = 100;
			}
			if(vipVO.getVipGrdNo().equals("VIPGRD0004")) {
				tcktQntt = 1000000;
			}

			ticketVO.setTcktQntt(tcktQntt);
			this.memMapper.insertTicket(ticketVO);
		}
		this.setUserDetails();

		return result;
	}

	@Override
	public int deleteResume(ResumeVO resumeVO) {
		return this.memMapper.deleteResume(resumeVO);
	}

	@Override
	public List<Map<String, String>> getMyEmployStatusInfo(String emplClfcNo) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("memId", this.getUserName());
		map.put("emplClfcNo", emplClfcNo);
		return this.memMapper.getMyEmployStatusInfo(map);
	}

	@Override
	public int setRprsRsm(String rsmNo) {
		int result = 0;
		ResumeVO resumeVO = new ResumeVO();
		resumeVO.setMemId(this.getUserName());
		result += this.memMapper.setRprsRsm(resumeVO);
		resumeVO.setRsmNo(rsmNo);
		result += this.memMapper.setRprsRsm(resumeVO);
		return result;
	}

	@Override
	public List<Map<String, String>> getOfferList() {
		return this.memMapper.getOfferList(this.getUserName());
	}

	@Override
	public List<Map<String, String>> getLikeList() {
		return this.memMapper.getLikeList(this.getUserName());
	}

	@Override
	public List<Map<String, String>> getViewList() {
		return this.memMapper.getViewList(this.getUserName());
	}

	@Override
	public void acceptMatchingOffer(String mtchOfferNo) {
		this.memMapper.acceptMatchingOffer(mtchOfferNo);
	}

	@Override
	public List<Map<String, String>> getSearchList(Map<String, String> map) {
		return this.memMapper.getSearchList(map);
	}

	@Override
	public List<CommonCodeVO> getMemJob(String cmcdClfc) {
		return this.memMapper.getMemJob(cmcdClfc);
	}

	@Override
	public void profileUpdate(MemVO memVO) {
		MultipartFile[] uploadFile = memVO.getUploadFile();

		if (uploadFile[0].getOriginalFilename() != null && !uploadFile[0].getOriginalFilename().equals("")) {
			this.memAttachService.attachInsert(memVO.getUploadFile(), memVO);
		}
		this.setUserDetails();
	}

}