package kr.or.ddit.vo;

import lombok.Data;

@Data
public class JobPostingTagVO {
	/** 구인 공고 태그 번호 (공통코드 태그상세코드) */
	private String jobPstgTagNo;
	/** 구인 공고 번호 */
	private String jobPstgNo;
	/** 구인 공고 태그 (공통코드 태그상세명) */
	private String jobPstgTagNm;
}
