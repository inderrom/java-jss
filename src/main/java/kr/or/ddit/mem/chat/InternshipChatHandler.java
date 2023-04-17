package kr.or.ddit.mem.chat;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import kr.or.ddit.premium.service.PremiumService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class InternshipChatHandler extends TextWebSocketHandler{
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	@Autowired
	PremiumService premiumService;
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		log.debug("#ChattingHandler, after Connection Established");
		
		sessionList.add(session);
		log.debug("{}님이 입장하셨습니다.", session.getPrincipal().getName());
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		log.debug("#ChattingHandler, handleMessage");
		log.debug("handleTextMessage id : {} / message : {}" ,session.getId(), message);

		for(WebSocketSession s : sessionList) {
			s.sendMessage(new TextMessage(session.getPrincipal().getName() + ":" + message.getPayload()));
		}
		
		String[] textTmp = message.getPayload().split("/");
		log.debug("message split // 아이디 : {}", textTmp[0]);
		log.debug("message split // 이름 : {}", textTmp[1]);
		log.debug("message split // 내용 : {}",  textTmp[2]);
		log.debug("message split // 인턴십번호 : {}", textTmp[3]);
		
		Map<String, String> map = new HashMap();
		map.put("sessionId", textTmp[0]);
		map.put("message", textTmp[2]);
		map.put("itnsNo", textTmp[3]);
		premiumService.chatMsgInsert(map);
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		log.debug("#ChattingHandler, after Connection Closed");

		sessionList.remove(session);
		log.debug("{}님이 퇴장하셨습니다.", session.getPrincipal().getName());
	}
}