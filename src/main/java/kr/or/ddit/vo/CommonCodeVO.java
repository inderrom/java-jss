package kr.or.ddit.vo;

import lombok.Data;

@Data
public class CommonCodeVO {
	/** 분류 코드 */
	private String cmcdClfc;
	/** 상세 코드 */
	private String cmcdDtl;
	/** 분류 코드명 */
	private String cmcdClfcNm;
	/** 상세 코드명 */
	private String cmcdDtlNm;
	/** 사용여부 */
	private String cmcdUseYn;
}
