package kr.or.ddit.vo;

import lombok.Data;

@Data
public class JobPostingSkillVO {
	/** 구인 공고 스킬 번호 (공통코드 태그상세코드) */
	private String jobPstgSklNo;
	/** 구인 공고 번호 */
	private String jobPstgNo;
	/** 구인 공고 스킬명 (공통코드 태그상세명) */
	private String jobPstgSklNm;
}
