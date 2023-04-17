package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class InternshipCommunityVO {
	/** 관리번호 */
	private String itnsCmmuNo;

	/** 부모 인턴십 번호 */
	private String itnsNo;

	/** 작성자 아이디 */
	private String memId;
	
	/** 작성자 이름 */
	private String memNm;
	
	/** 작성자 프로필 이미지 */
	private String attNm;

	/** 글 제목 */
	private String itnsCmmuTitle;

	/** 글 내용 */
	private String itnsCmmuContent;

	/** 글 조회수 */
	private String itnsCmmuInqCnt;

	/** 글 작성일 */
	private Date itnsCmmuRegDt;

	/** 첨부파일 */
	private MultipartFile[] uploadFile;
	
	/** 댓글 리스트 */
	private List<InternshipCommunityCommentVO> cmntList;
	
	/** 첨부파일 리스트 */
	private List<AttachmentVO> attList;
	
}
