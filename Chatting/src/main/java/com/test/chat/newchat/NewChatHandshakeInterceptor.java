package com.test.chat.newchat;

import java.util.Map;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.HandshakeInterceptor;
import org.springframework.web.util.UriComponentsBuilder;

public class NewChatHandshakeInterceptor implements HandshakeInterceptor {

    /**
     * WebSocket 핸드셰이크 이전에 실행됩니다.
     * 요청 URI에서 roomId를 추출하고 session 속성에 저장합니다.
     * 
     * @param request   클라이언트의 요청 정보입니다.
     * @param response  서버의 응답 정보입니다.
     * @param wsHandler WebSocket 핸들러입니다.
     * @param attributes WebSocket 세션 속성 정보입니다.
     * @return 핸드셰이크 진행 여부를 반환합니다.
     */
    @Override
    public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler, Map<String, Object> attributes) {
        System.out.println("Request URI: " + request.getURI());

        // 요청 URI에서 roomId 추출
        String roomId = UriComponentsBuilder.fromUri(request.getURI()).build().getQueryParams().getFirst("roomId");

        if (roomId == null) {
            System.err.println("Room ID is null. Check the client-side URL or query parameter.");
        } else {
            attributes.put("roomId", roomId);
            System.out.println("Room ID set to attributes: " + roomId);
        }

        return true;
    }

    /**
     * WebSocket 핸드셰이크 이후에 실행됩니다.
     * 
     * @param request   클라이언트의 요청 정보입니다.
     * @param response  서버의 응답 정보입니다.
     * @param wsHandler WebSocket 핸들러입니다.
     * @param exception 핸드셰이크 중 발생한 예외입니다.
     */
    @Override
    public void afterHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler, Exception exception) {
        // 추가 처리 없음
    }
}
