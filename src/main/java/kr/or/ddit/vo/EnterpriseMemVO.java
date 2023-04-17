package kr.or.ddit.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class EnterpriseMemVO {
	/** 기업 번호 */
	private String entNo;

	/** 기업명 */
	private String entNm;
	
	/** 기업 아이디 */
	private String memId;
	
	/** 가입 일시 */
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date entMemJoinDt;
	
	/** 담당자 명 */
	private String entPicNm;
	
	/** 담당자 전화번호 */
	private String entPicTelno;
	
	/** 담당자 직급 */
	private String entPicJbgd;
	
	/** 담당자 승인 여부 (boolean) */
	private String entAprvYn;
	
	/** 승인 일시 */
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date entAprvDt;
	
	/** 회사 대표 이미지 */
	private String entrprsimgs;
	
	/** 회사 로고 이미지 */
	private String entlogoimgs;
}
