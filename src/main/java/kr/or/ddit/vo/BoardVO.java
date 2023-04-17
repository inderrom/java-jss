package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class BoardVO {
	
	/** 글번호 */
	private String boardNo;
	
	/** 이전 글번호 */
	private String prevNo;
	
	/** 다음 글번호 */
	private String nextNo;
	
	/** 글제목 */
	private String boardTitle;
	
	/** 이전 글제목 */
	private String prevTitle;
	
	/** 다음 글제목 */
	private String nextTitle;
	
	/** 글내용 */
	private String boardContent;
	
	/** 조회수 */
	private int boardInqCnt;
	
	/** 작성일 */
	private Date boardRegDt;
	
	/** 카테고리 */
	private String boardClfcNo;
	
	/** 작성 회원ID */
	private String memId;
	
	/** 작성 회원이름 */
	private String memNm;
	
	/** 작성시간 계산 */
	private String brdTime;
	
	/** 댓글 총 갯수 */
	private int cmntCnt;
	
	/** 작성자 경력(년수) */
	private int crrYear;
	
	/** 작성자 직종 */
	private String memJobNm;
	
	/** 작성자 프로필 이미지 */
	private String brdAttNm;

	/** 첨부파일 */
	private MultipartFile[] uploadFile;
	
	/** 첨부파일 리스트 */
	private List<AttachmentVO> boardAttVOList;
	
	/** 댓글 리스트 */
	private List<BoardCommentVO> boardCmntVOList;

	/** 페이징 전용 RNUM 입니다 . 제가 능력이 부족해서 추가좀 했습니다.*/
	private int rnum;
}
