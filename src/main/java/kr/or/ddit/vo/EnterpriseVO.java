package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class EnterpriseVO {
	/** 기업 번호 */
	private String entNo;

	/** 기업명 */
	private String entNm;
	
	/** 기업 아이디 */
	private String memId;
	
	/** 기업 소개 */
	private String entDescription;
	
	/** 기업 사이트 링크 */
	private String entUrl;
	
	/** 기업 우편번호 */
	private String entZip;
	
	/** 기업 주소 */
	private String entAddr;
	
	/** 기업 상세주소 */
	private String entDaddr;
	
	/** 기업 매출액 */
	private int entSlsAmt;
	
	/** 기업 산업군 */
	private String entSector;
	
	/** 기업 직원수 */
	private int entEmpCnt;
	
	/** 기업 설립일 */
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date entFndnDt;
	
	private List<EnterpriseMemVO> enterpriseMemVoList;
	
	/** 담당자 명 */
	private String entPicNm;
	
	/** 담당자 전화번호 */
	private String entPicTelno;
	
	/** 담당자 직급 */
	private String entPicJbgd;

	/** 기업 스킬 리스트 */
	private List<EnterpriseSkillVO> entSkillList;
	
	//첨부파일
	/** 사업자등록증명원 */
	private MultipartFile[] entCertificate;
	
	/** 회사 로고 이미지 */
	private MultipartFile[] entlogoimgs;

	/** 회사 대표 이미지 */
	private MultipartFile[] entrprsimgs;

	/** 첨부파일 리스트 */
	private List<AttachmentVO> entAttVOList;
	
	/** 무제한 멤버십 계약서*/
	private MultipartFile[] unlimitMsContract;
	
	/** 멤버십 */
	private VipVO vipVO;
}
