package com.test.chat.server;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import com.google.gson.Gson;
import com.test.chat.domain.Message;

@ServerEndpoint("/server")
public class chatServer {
	
	//현재 채팅에 참여한 모든 사람들
	private static List<Session> sessionList;
	
	static {
		sessionList = new ArrayList<Session>();
	}
	
	@OnOpen
	public void handleOpen(Session session) {
		
		System.out.println("[LOG] 클라이언트가 접속했습니다.");
		
		sessionList.add(session);
		
		//System.out.println(sessionList.size());
				
	}
	
	@OnMessage
	public void handleMessaage(String chatScreenMsg, Session session) {
		
		//{"code":1,"sender":"강아지","receiver":"","content":"","regdate":"2024-10-24 14:21:00"}
		System.out.println(chatScreenMsg);
		
		Gson gson = new Gson();
		
		Message message = gson.fromJson(chatScreenMsg, Message.class);
		
		System.out.println(message);
		
		if (message.getCode().equals("1")) {
			
			//새로운 유저가 접속했습니다.
			for (Session s : sessionList) {
				if (s != session) {
					
					try {
						s.getBasicRemote().sendText(chatScreenMsg);
					} catch (IOException e) {
						e.printStackTrace();
					}
					
				}
			}
			
		} else if (message.getCode().equals("2")) {
			
			//기존 유저가 나갔습니다.
			sessionList.remove(session);
			
			for (Session s : sessionList) {
				try {
					s.getBasicRemote().sendText(chatScreenMsg);
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			
		} else if (message.getCode().equals("3") || message.getCode().equals("4")) {
			
			//클라이언트가 보낸 메시지를 다른 클라이언트에게 전달
			for (Session s : sessionList) {
				if (s != session) {
					try {
						s.getBasicRemote().sendText(chatScreenMsg);
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
			
		}
		
	}
	
	@OnClose
	public void handleClose(Session session) {
		System.out.println("[LOG] 클라이언트가 접속 종료했습니다.");
		
		//System.out.println(session);
		sessionList.remove(session);
		
	}
	
	@OnError
	public void handleError(Throwable e) {
		System.out.println("[LOG] 에러가 발생했습니다. " + e.getMessage());	
	}

}













