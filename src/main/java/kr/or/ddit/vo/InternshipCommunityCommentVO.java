package kr.or.ddit.vo;

import lombok.Data;

@Data
public class InternshipCommunityCommentVO {
	/** 댓글 관리번호 */
    private String itnsCmmuCmntNo;
    
    /** 부모 게시글 번호 */
    private String itnsCmmuNo;
    
    /** 댓글 작성자 아이디 */
    private String memId;
    
    /** 댓글 작성자 이름 */
    private String memNm;
    
    /** 댓글 작성자 프로필 사진 */
    private String attNm;
    
    /** 댓글 내용 */
    private String itnsCmmuCmntContent;
    
    /** 댓글 등록일 */
    private String itnsCmmuCmntRegDt;
}
