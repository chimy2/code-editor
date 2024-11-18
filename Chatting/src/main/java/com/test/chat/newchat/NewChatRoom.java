package com.test.chat.newchat;

import org.springframework.web.socket.WebSocketSession;
import java.util.HashSet;
import java.util.Set;

/**
 * 채팅방을 나타내는 클래스입니다.
 * 특정 roomId에 연결된 WebSocket 세션들을 관리합니다.
 */
public class NewChatRoom {
    private String roomId; // 채팅방 ID입니다.
    private Set<WebSocketSession> sessions = new HashSet<>(); // 채팅방에 연결된 세션 목록입니다.

    /**
     * 채팅방 객체를 생성합니다.
     * 
     * @param roomId 채팅방의 고유 ID입니다.
     */
    public NewChatRoom(String roomId) {
        this.roomId = roomId;
    }

    /**
     * 채팅방의 ID를 반환합니다.
     * 
     * @return roomId
     */
    public String getRoomId() {
        return roomId;
    }

    /**
     * 채팅방에 WebSocket 세션을 추가합니다.
     * 
     * @param session 추가할 WebSocket 세션입니다.
     */
    public void addSession(WebSocketSession session) {
        sessions.add(session);
    }

    /**
     * 채팅방에서 WebSocket 세션을 제거합니다.
     * 
     * @param session 제거할 WebSocket 세션입니다.
     */
    public void removeSession(WebSocketSession session) {
        sessions.remove(session);
    }

    /**
     * 채팅방에 연결된 모든 WebSocket 세션을 반환합니다.
     * 
     * @return WebSocket 세션들의 집합(Set)입니다.
     */
    public Set<WebSocketSession> getSessions() {
        return sessions;
    }
}
