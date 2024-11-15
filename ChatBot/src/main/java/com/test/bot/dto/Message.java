package com.test.bot.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
/**
 * Message 클래스
 * 
 * OpenAI GPT API에서 사용되는 메시지 형식을 나타내는 DTO(Data Transfer Object) 클래스입니다.
 * 사용자와 모델 간의 대화를 표현하며, 역할(role)과 내용(content)을 포함합니다.
 * @author JGChoi
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Message {
	
	private String role;
    private String content; 
}
