package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class PremiumVO {

	private String prmmNo;			//프리미엄 번호
	private String prmmTitle;		//프리미엄 제목
	private String prmmContent;		//프리미엄 내용
	private Date prmmRegDt;			//프리미엄 등록 일시
	private String prmmClfc;		//프리미엄 분류

	/** attachmentVO를 담은 List */
	private List<AttachmentVO> attachList;

	/** lectureVO를 담은 List (premium 한 개당 lecture 한 개가 기본) */
	private List<LectureVO> lectureList;

	/** internshipVO를 담은 List */
	private List<InternshipVO> internshipList;

	/** 프리미엄 대표 이미지 파일 저장 */
	private MultipartFile[] prmmImg;

	/////////////////////////////////////////
	//인턴십용 파일

	/** 첨부파일 */
	private MultipartFile[] uploadFileImage;

	/** 첨부파일 */
	private MultipartFile[] uploadFileAll;

	/////////////////////////////////////////
	//인턴십용 기업 대표 이미지 가져오기
	private List<AttachmentVO> entAttachList;

}
