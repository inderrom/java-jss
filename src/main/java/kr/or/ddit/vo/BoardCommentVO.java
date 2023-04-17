package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

@Data
public class BoardCommentVO {
	/** 댓글 번호 */
	private String cmntNo;

	/** 댓글 내용 */
	private String cmntContent;

	/** 댓글 작성일 */
	private Date cmntRegDt;

	/** 댓글 작성자 아이디 */
	private String memId;

	/** 댓글 작성자 이름 */
	private String memNm;

	/** 댓글 작성자 프로필사진 이름 */
	private String attNm;

	/** 부모 게시글 번호 */
	private String boardNo;
	
	/** 부모 게시글 댓글갯수 */
	private String cmntCnt;
}
