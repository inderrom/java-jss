package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class ResumeVO {
	private String rnum;
	private String rsmNo; 			// 이력서 번호
	private String memId;			// 회원 번호
	private String rsmTitle;		// 이력서 제목
	private String rsmAboutMe;		// 자기소개서
	private String rsmUrl;			// 이메일
	private String rsmTmprStrgYn;	// 임시저장여부
	private String rsmRprs;			// 대표이력서
	private Date rsmRegDt;
	
	private String memNm;			// 회원이름
	private String memJob;			// 직무
	private String memTelno;		// 멤버 번호
	private String recBmkYn;		// 기록여부
	private String tvrRsmNo;			//  열람한 이력서 번호
	
	private List<AcademicBackgroundVO> academicList;  // 학력
	private List<CareerVO> history;					  // 경력, 근무이력
	private List<MySkillVO> mySkillList;			  // 회원기술스택
//	private List<CareerVO>recentList;				  // 최근 근무이력
	private List<CareerVO>beforeList;				  // 이전 근무이력
	private RecordVO record;

	private List<CareerVO> careerVOList;			// 경력
	private List<LanguageVO> languageVOList;		// 언어
	private List<AwardsVO> awardsVOList;			// 수상
	
}
