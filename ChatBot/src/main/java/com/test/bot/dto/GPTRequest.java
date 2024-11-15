package com.test.bot.dto;

import java.util.List;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import lombok.Data;

/**
 * GPTRequest 클래스
 * 
 * OpenAI GPT API 호출을 위한 요청 데이터를 구성하는 DTO 클래스입니다.
 * 요청에 필요한 모델 정보, 메시지 내역, 파라미터 값을 포함하고 있습니다.
 * @author JGChoi
 */
@Data
@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class) // JSON 필드 이름을 snake_case로 변환
public class GPTRequest {

    private String model;

    private List<Message> messages;

    private int temperature;

    private int maxTokens;

    private int topP;

    private int frequencyPenalty;

    private int presencePenalty;

    /**
     * GPTRequest 생성자
     * 
     * 요청 데이터를 초기화합니다.
     * 
     * @param model OpenAI 모델 이름
     * @param messages 대화 메시지 리스트
     * @param temperature 온도 값
     * @param maxTokens 생성할 최대 토큰 수
     * @param topP Top-p 샘플링 값
     * @param frequencyPenalty 빈도 페널티
     * @param presencePenalty 존재 페널티
     * @author JGChoi
     */
    public GPTRequest(String model, List<Message> messages, int temperature, int maxTokens, int topP, int frequencyPenalty, int presencePenalty) {
        this.model = model;
        this.messages = messages;
        this.temperature = temperature;
        this.maxTokens = maxTokens;
        this.topP = topP;
        this.frequencyPenalty = frequencyPenalty;
        this.presencePenalty = presencePenalty;
    }
}
