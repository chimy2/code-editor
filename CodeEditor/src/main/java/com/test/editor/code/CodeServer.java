package com.test.editor.code;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.test.editor.model.CodeDTO;

import oracle.jdbc.driver.Message;

@ServerEndpoint("/vs/code/{project_seq}")
public class CodeServer {
	
	private static List<Session> sessionList;
	private static HashMap<String, String> fileList;

	static {
		sessionList = new ArrayList<Session>();
		fileList = new HashMap<String, String>();
	}
	
	@OnOpen
	public void handleOpen(Session session) {
		System.out.println("서버 오픈");
		
		sessionList.add(session);
		
		System.out.println("현재 접속: " + sessionList);
	}
	
	@OnMessage
	public void handleMessage(Session session, String message) {
		System.out.println(message);
	}
	
	@OnError
	public void handleError(Throwable e) {
		System.out.println("에러 발생: " + e.getMessage());
	}
	
	@OnClose
	public void handleClose(Session session) {
		System.out.println("서버 닫힘");
		
		sessionList.remove(session);
		
		System.out.println("현재 접속: " + sessionList);
	}
}
