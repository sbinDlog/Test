package kr.or.ddit.handler;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import lombok.extern.slf4j.Slf4j;

//웹 소켓 도착지
@Slf4j
public class AlramHandler extends TextWebSocketHandler {
	 
	
	// 전체 세션
	private static List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();
	
	
	// 웹소켓 연결이 성사 되고 나서 해야할 일들.
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		log.info("Socket 연결");
		log.info("session : " + session );

		sessions.add(session);	// 리스트에 접속한 session들을 담음
		 
	}

	// 서버단으로 메세지가 도착했을때 해줘야 하는 일
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		System.out.println( "handleTextMessage : " + session.getId());
		//System.out.println( "handleTextMessage : " + message.getPayload());

		for(WebSocketSession single : sessions) {
			// message.getPayload()를 통해 메시지에 담긴 텍스트값을 얻을 수 있다.
			String msg = message.getPayload(); //자바스크립트에서 넘어온 메세지
			log.info(" msg : "+ msg);
//			int count = alarmService.selectAlarmCount(memId);
//			
//			//리스트에 담긴 세션의 id와 메세지를 보내줄 세션의 id가 같고, uchkList가 0이 아닐 경우 메세지 전송
//			if(single.getId().equals(session.getId()) && count != 0) {
//				TextMessage sendMsg = new TextMessage(memId + "님 새 알림이 있습니다");
//				single.sendMessage(sendMsg);
			}
		}
	

	//﻿ 웹 소켓 연결이 종료되고 나서 서버단에서 실행해야 할 일들을 정의
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		log.info("Socket 끊음");
		//전체 세션리스트에서 세션 삭제 
		sessions.remove(session);
		
	}
	
}
