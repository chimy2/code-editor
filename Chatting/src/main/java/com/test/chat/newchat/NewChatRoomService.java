package com.test.chat.newchat;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * 채팅방을 관리하는 서비스 클래스입니다.
 * roomId를 기반으로 채팅방을 생성하거나 기존 채팅방을 반환합니다.
 */
public class NewChatRoomService {
    private Map<String, NewChatRoom> chatRooms = new ConcurrentHashMap<>(); // 채팅방 정보를 저장하는 맵입니다.

    /**
     * roomId에 해당하는 채팅방을 반환하거나, 없으면 새로 생성하여 반환합니다.
     * 
     * @param roomId 채팅방의 고유 ID입니다.
     * @return 생성되었거나 기존의 NewChatRoom 객체를 반환합니다.
     */
    public NewChatRoom getOrCreateRoom(String roomId) {
        // roomId가 존재하지 않으면 새로 생성하여 저장 후 반환합니다.
        return chatRooms.computeIfAbsent(roomId, NewChatRoom::new);
    }
}
