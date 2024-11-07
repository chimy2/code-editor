package com.test.chat.server;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.server.ServerEndpoint;


@ServerEndpoint("/server.do")
public class chatServer {

	//클라이언트가 연결 요청을 했을떄
	
	@OnOpen
	public void handleopen() {
		System.out.println("클라이언트가 chatserver 접속했습니다");
		
	}
	
	
	@OnClose
	public void handleClose() {
		System.out.println("클라이언트가 종료했습니다.");
	}
	
	@OnMessage
	public String handleMasseage(String msg) {
		System.out.println("클라이언트가 보낸 메시지: " + msg);
		
		return "(응답)" + msg;
	}
	
	@OnError
	public void handleError(Throwable e) {
		System.out.println("에러 발생 " + e.getMessage());
	}
	
}