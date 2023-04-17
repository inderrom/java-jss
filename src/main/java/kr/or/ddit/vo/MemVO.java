package kr.or.ddit.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class MemVO {
	/**  회원 아이디 */
	private String memId;
	
	/**  카카오 계정 여부 */
	private String memKakaoYn;
	
	/**  회원 비밀번호 */
	private String memPass;
	
	/**  회원명 */
	private String memNm;
	
	/**  회원 전화번호 */
	private String memTelno;
	
	/**  회원 가입일시 */
	private String memJoinDt;
	
	/**  회원 닉네임 */
	private String memNickname;
	
	/**  회원 한줄 소개 */
	private String memDescription;
	
	/**  회원 ??? 머죠? */
	private String memUrl;
	
	/**  개인정보수집동의 여부 */
	private String memPrvcClctAgreYn;
	
	/**  공개 여부 */
	private String memRlsYn;
	
	/**  회원 권한 */
	private String memAuth;
	
	/**  사용여부 */
	private String enabled;
	
	/**  ??? */
	private String attNm;
	
	/**  ??? */
	
	private String crrYear;
	/**  회원여부 */
	
	private String memJob;
	
	/**  멤버십 가입여부 (0:미가입, 1:가입) */
	private int msyn;

	/**  가입한 멤버십 종류 */
	private String vipGrdNo;
	
	/**  가입한 멤버십 이름 */
	private String vipGrdNm;
	
	/**  멤버십 번호 */
	private String vipNo;
	
	/** 멤버십  끝나는 기간*/
	private String vipEndDt;
	
	/** 열람권 수량 */
	private String tcktQntt; 
	
	/**  회원 직군 */
	private String memJobGroup;
	
//----------------------------------
	private int rnum;
	private String vip;
	private String vipGrade;
	private List<String> memAuthList;
	private List<ReportVO> reportClassList;
	private List<ReportClassificationVO> memReportList;
	private List<EnterpriseVO> enterPriseList;
	private List<EnterpriseMemVO> enterPriseMemList;
	
	/** 첨부파일 */
	private MultipartFile[] uploadFile;
	
	/** 첨부파일 리스트 */
	private List<AttachmentVO> boardAttVOList;
	
	
}