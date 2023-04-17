package kr.or.ddit.vo;

import lombok.Data;

@Data
public class RequireJobVO {
	/** 모집분야 번호 (공통코드 직업상세코드) */
	private String rqrJobNo;
	/** 구인 공고 번호 */
	private String jobPstgNo;
	/** 모집분야명 (공통코드 직업상세명) */
	private String rqrJobNm;
	
}
