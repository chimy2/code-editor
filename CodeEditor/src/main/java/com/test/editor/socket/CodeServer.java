package com.test.editor.socket;

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
import com.test.editor.domain.Message;
import com.test.editor.model.MemberDTO;

/**
 * 
 * 실시간 협업 코드 편집을 처리하는 WebSocket 서버 엔드포인트입니다. 연결 열기, 메시지 수신 및 브로드캐스트, 에러 처리, 연결
 * 종료를 지원합니다.
 *
 * 이 서버는 "/vs/code/{projectSeq}" 엔드포인트에서 작동하며, javax.websocket API를 사용하여 통신을
 * 관리합니다.
 * 
 * @author sohye park
 */
@ServerEndpoint("/vs/code/{projectSeq}")
public class CodeServer {

    /** 활성화된 WebSocket 세션 목록. */
	private static ArrayList<Session> sessionList;

    /** 특정 파일과 관련된 세션 목록을 관리하는 매핑. */
	private static HashMap<String, List<Session>> fileList;

    /** JSON 메시지를 Java 객체로 변환하기 위한 ObjectMapper. */
	private static ObjectMapper objectMapper;

	static {
		sessionList = new ArrayList<Session>();
		fileList = new HashMap<String, List<Session>>();
		objectMapper = new ObjectMapper();
	}

    /**
     * 클라이언트가 WebSocket 서버에 새로 연결될 때 처리합니다.
     *
     * @param session 연결된 클라이언트를 나타내는 세션.
     */
	@OnOpen
	public void handleOpen(Session session) {
		System.out.println("서버 오픈");

		sessionList.add(session);

		System.out.println("현재 접속: " + sessionList);
	}

    /**
     * 클라이언트로부터 수신된 메시지를 처리합니다.
     *
     * @param session        메시지를 보낸 세션.
     * @param receiveMessage 수신된 메시지(문자열 형식).
     */
	@OnMessage
	public void handleMessage(Session session, String receiveMessage) {

		try {
			Message message = objectMapper.readValue(receiveMessage, Message.class);

			message.setReceiver(new MemberDTO());

			System.out.println("Received message: " + message);

			if (message.getType().equals("code")) {
				System.out.println("this is code");

				// Broadcast the received message to all other sessions
				for (Session s : sessionList) {
					if (!s.getId().equals(session.getId())) { // Avoid sending back to sender

						message.getReceiver().setId(s.getId());
						s.getBasicRemote().sendText(objectMapper.writeValueAsString(message));
					}
				}

			} else if (message.getType().equals("cursor")) {
				
			}
		} catch (IOException e) {
			System.out.println("Error processing message: " + e.getMessage());
			handleError(e);
		}
	}

    /**
     * WebSocket 상호작용 중 발생하는 에러를 처리합니다.
     *
     * @param e 발생한 예외.
     */
	@OnError
	public void handleError(Throwable e) {
		System.out.println("에러 발생: " + e.getMessage());
	}

    /**
     * 클라이언트가 WebSocket 서버에서 연결을 종료할 때 처리합니다.
     *
     * @param session 연결이 종료된 클라이언트를 나타내는 세션.
     */
	@OnClose
	public void handleClose(Session session) {
		System.out.println("서버 닫힘");

		sessionList.remove(session);

		System.out.println("현재 접속: " + sessionList);
	}
}
