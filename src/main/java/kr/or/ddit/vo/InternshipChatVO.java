package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

@Data
public class InternshipChatVO {
	/** 시퀀스 */
    private String itnsChatNo;
    
    /** 부모 인턴십 번호 */
    private String itnsNo;
    
    /** 채팅방 번호 */
    private String itnsChatRoom;
    
    /** 채팅 내용 */
    private String itnsChatContent;
    
    /** 채팅 전송일자 */
    private Date itnsChatDt;
    
    /** 보낸사람 */
    private String itnsChatSndr;
    
    /** 보낸사람 이름 */
    private String sdnm;
    
    /** 받는사람 */
    private String itnsChatRcvr;
    
    /** 받는사람 이름 */
    private String rcnm;
	
}
