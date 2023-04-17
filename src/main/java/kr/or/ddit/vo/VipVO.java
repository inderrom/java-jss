package kr.or.ddit.vo;

import lombok.Data;

@Data
public class VipVO {
	/** 멤버십 번호 */
	private String vipNo;

	/** 회원 아이디 */
	private String memId;

	/** 멤버십 등급 번호 */
	private String vipGrdNo;

	/** 시작일 */
	private String vipBgngDt;

	/** 종료일 */
	private String vipEndDt;
	
	/** 멤버십 등급 */
	private String vipGrd;

	/** 멤버십 등급 혜택 */
	private String vipGrdBnf;
}
