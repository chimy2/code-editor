package com.test.chat.newchat;

import java.util.Map;
import org.springframework.http.server.reactive.ServerHttpRequest;
import org.springframework.http.server.reactive.ServerHttpResponse;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;
import org.springframework.web.util.UriComponentsBuilder;

/**
 * WebSocket 핸들러 클래스입니다.
 * 채팅방 생성, 메시지 브로드캐스트, 연결 및 종료 관리를 수행합니다.
 */
public class NewChatWebSocketHandler extends TextWebSocketHandler {

    private final NewChatRoomService chatRoomService; // 채팅방 관리 서비스입니다.

    /**
     * 생성자입니다.
     * @param chatRoomService 채팅방 관리 서비스 객체입니다.
     */
    public NewChatWebSocketHandler(NewChatRoomService chatRoomService) {
        this.chatRoomService = chatRoomService;
    }

    /**
     * WebSocket 핸드셰이크 전 실행됩니다.
     * URI에서 roomId를 추출하여 세션 속성에 저장합니다.
     */
    public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler, Map<String, Object> attributes) {
        try {
            String roomId = UriComponentsBuilder.fromUri(request.getURI()).build().getQueryParams().getFirst("roomId");
            if (roomId != null) {
                attributes.put("roomId", roomId);
            } else {
                System.err.println("Failed to extract roomId.");
            }
        } catch (Exception e) {
            System.err.println("Error during WebSocket handshake: " + e.getMessage());
        }
        return true;
    }

    /**
     * WebSocket 연결이 성립된 후 호출됩니다.
     * 사용자를 특정 채팅방에 추가합니다.
     */
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        String roomId = getRoomIdFromSession(session);
        NewChatRoom room = chatRoomService.getOrCreateRoom(roomId);
        room.addSession(session);
        System.out.println("User joined room: " + roomId);
    }

    /**
     * 클라이언트가 메시지를 보낼 때 호출됩니다.
     * 해당 메시지를 동일한 채팅방의 모든 사용자에게 전송합니다.
     */
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        String roomId = getRoomIdFromSession(session);
        NewChatRoom room = chatRoomService.getOrCreateRoom(roomId);

        for (WebSocketSession s : room.getSessions()) {
            if (s.isOpen()) {
                s.sendMessage(message);
            }
        }
    }

    /**
     * WebSocket 연결이 종료될 때 호출됩니다.
     * 사용자를 채팅방에서 제거합니다.
     */
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        String roomId = getRoomIdFromSession(session);
        NewChatRoom room = chatRoomService.getOrCreateRoom(roomId);
        room.removeSession(session);
        System.out.println("User left room: " + roomId);
    }

    /**
     * WebSocketSession에서 roomId를 가져옵니다.
     * @param session WebSocket 세션입니다.
     * @return roomId를 반환합니다.
     */
    private String getRoomIdFromSession(WebSocketSession session) {
        Map<String, Object> attributes = session.getAttributes();
        return (String) attributes.get("roomId");
    }
}
