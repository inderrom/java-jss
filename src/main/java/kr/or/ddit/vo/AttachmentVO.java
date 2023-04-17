package kr.or.ddit.vo;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class AttachmentVO {
	//전사적 아이디
	private String etpId;
	//파일 관리 번호
	private String atchNo;
	//파일 번호
	private String attNo;
	//첨부파일 분류 번호
	private String attClfcNo;
	// 파일 경로
	private String attPath;
	// 파일명
	private String attNm;
	//등록일
	private Date attRegDt;
	//첨부 파일
	private MultipartFile[] uploadFile;

	//첨부파일분류명
	private String attClfcNm;
}
