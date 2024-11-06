package com.test.bot.dto;

import java.util.List;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import lombok.Data;

@Data
@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
public class GPTRequest {

    private String model;
    private List<Message> messages;
    private int temperature;
    private int maxTokens;
    private int topP;
    private int frequencyPenalty;
    private int presencePenalty;

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
