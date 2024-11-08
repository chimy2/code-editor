package com.test.editor.code;

import java.io.IOException;
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
import com.test.editor.domain.Code;

@ServerEndpoint("/vs/code/{project_seq}")
public class CodeServer {
	
	private static List<Session> sessionList;
	private static HashMap<String, List<Session>> fileList;
    private static ObjectMapper objectMapper;

	static {
		sessionList = new ArrayList<Session>();
		fileList = new HashMap<String, List<Session>>();
		objectMapper = new ObjectMapper();
	}
	
	@OnOpen
	public void handleOpen(Session session) {
		System.out.println("서버 오픈");
		
		sessionList.add(session);
		
		System.out.println("현재 접속: " + sessionList);
	}
	
	@OnMessage
	public void handleMessage(Session session, String message) {
	    try {
	        // Deserialize incoming message to CodeDTO
	        Code codeUpdate = objectMapper.readValue(message, Code.class);

	        // Log message content
	        System.out.println("Received message: " + codeUpdate);

	        // Broadcast the received message to all other sessions
	        for (Session s : sessionList) {
	            if (!s.getId().equals(session.getId())) {  // Avoid sending back to sender
	                s.getBasicRemote().sendText(objectMapper.writeValueAsString(codeUpdate));
	            }
	        }
	    } catch (IOException e) {
	        System.out.println("Error processing message: " + e.getMessage());
	        handleError(e);
	    }
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
