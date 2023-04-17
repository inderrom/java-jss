package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class InternshipVO {
	/**인턴십번호*/
	private String itnsNo;
	
	/**기업번호*/
	private String entNo;
	
	/**기업이름*/
	private String entNm;
	
	/**프리미엄 번호*/
	private String prmmNo;
	
	/**승인여부*/
	private String itnsAprvYn;
	
	/**인턴십 참여 총인원*/
	private int itnsEntrtNope;
	
	/**인턴십 시작일*/
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date itnsBgngDt;
	
	/**인턴십 종료일*/
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date itnsEndDt;

	/**인턴십 조건*/
	private String itnsCondition;
	
	/**인턴십 모집 시작*/
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date itnsRecStart;
	
	/**인턴십 모집 마감*/
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date itnsRecEnd;
	
	/** 인턴십 등록 기업 대표이미지 */
	private String attNm;
	
	//////////////////////////////////////////
	/*프리미엄 테이블*/
	/**프리미엄 제목*/
	private String prmmTitle;

	/**프리미엄 내용*/
	private String prmmContent;
	
	/**프리미엄 분류*/
	private String prmmClfc;
	
	/////////////////////////////////////////
	
	/**실체 참여 인원*/
	public int itnsEntrtCount;
	
	////////////////////////////////////////
	/**기업 정보*/
	public List<EnterpriseVO> entVOList;
	
	/**기업 회원 정보*/
	public List<EnterpriseMemVO> entMemVOList;
	
	////////////////////////////////////////
	/**인턴십 참가자 목록*/
	public List<InternshipEntryantVO> itnsEntrtVOList;
	
	////////////////////////////////////////
	/**인턴십 채팅 리스트*/
	
	/**인턴십 화상회의*/
	
	/**인턴십 일정*/
	
	/**인턴십 게시판*/
	
	
	
	
	
	
}
