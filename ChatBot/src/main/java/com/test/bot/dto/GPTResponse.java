package com.test.bot.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * GPTResponse 클래스
 * 
 * OpenAI GPT API의 응답 데이터를 표현하는 DTO(Data Transfer Object) 클래스입니다.
 * API 호출 후 반환된 응답 데이터를 처리하기 위해 사용됩니다.
 * @author JGChoi
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class GPTResponse {

    private List<Choice> choices;

    /**
     * Choice 클래스
     *  
     * 응답 데이터의 개별 선택지를 표현하는 내부 클래스입니다.
     * @author JGChoi
     */
    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    public static class Choice {

        private int index;

        private Message message;
    }
}
