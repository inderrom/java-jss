package kr.or.ddit.vo;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class EmployStatusVO {
	/** 채용 상태 번호 */
	private String emplStsNo;
	/** 채용 번호 */
	private String emplNo;
	/** 구인공고 번호 */
	private String jobPstgNo;
	/** 채용 분류 번호 */
	private String emplClfcNo;
	/** 이력서 번호 */
	private String rsmNo;
	/** 변경일시 번호 */
	private Date emplStsChgDt;
	/** 첨부파일 번호 */
	private String attNo;
	/** 첨부파일 */
	private MultipartFile[] uploadFile;

	private int stsCnt; // 채용 상태 카운트
}
