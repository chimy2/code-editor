package com.test.chat.newchat;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

/**
 * WebSocket 설정 클래스입니다.
 * WebSocket 핸들러와 인터셉터를 등록하고 관련 설정을 구성합니다.
 */
@Configuration
@EnableWebSocket
public class WebSocketConfig implements WebSocketConfigurer {

    /**
     * NewChatRoomService를 Bean으로 등록합니다.
     * 
     * @return NewChatRoomService 인스턴스
     */
    @Bean
    public NewChatRoomService chatRoomService() {
        return new NewChatRoomService();
    }

    /**
     * WebSocket 핸들러를 등록합니다.
     * "/newchat" 경로에 대해 NewChatWebSocketHandler를 설정하며, HandshakeInterceptor를 추가합니다.
     * 
     * @param registry WebSocket 핸들러 등록 객체입니다.
     */
    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
        registry.addHandler(new NewChatWebSocketHandler(chatRoomService()), "/newchat")
                .addInterceptors(new NewChatHandshakeInterceptor()) // Handshake 인터셉터 등록
                .setAllowedOrigins("*"); // 모든 출처 허용
    }
}
