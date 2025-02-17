package com.test.bot.controller;

import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.test.bot.dao.ChatDAO;
import com.test.bot.dto.ChatDTO;
import com.test.bot.dto.GPTRequest;
import com.test.bot.dto.GPTResponse;
import com.test.bot.dto.Message;

/**
 * GPTController 클래스
 * 
 * OpenAI GPT API와 통신하여 사용자와 챗봇 간의 대화를 처리하는 컨트롤러입니다.
 * 사용자 입력을 받아 OpenAI GPT 모델에 요청하고, 결과를 저장 및 반환합니다.
 * @author JGChoi
 */
@Controller
@RequestMapping("/gpt")
public class GPTController {

    @Autowired
    private ChatDAO dao;

    
    //API키 노출 방지 > application.properties로 환경 변수 적용 완료 
    @Value("${openai.api.key}")
    private String apiKey;

    @Value("${openai.api.url}")
    private String apiUrl;

    @Value("${openai.model}")
    private String model;  
    
    private final RestTemplate restTemplate;
    
    // 대화 내역을 저장할 리스트
    private List<Message> messages = new ArrayList<>();

    /**
     * 기본 생성자
     * 
     * RestTemplate을 UTF-8 인코딩을 지원하도록 초기화합니다.
     * @author JGChoi
     */
    public GPTController() {
        this.restTemplate = new RestTemplate();
        this.restTemplate.getMessageConverters().add(0, new StringHttpMessageConverter(StandardCharsets.UTF_8));
    }
    
    /**
     * GET 요청 처리 메서드
     * 
     * 사용자의 대화 내역을 데이터베이스에서 조회하여 반환합니다.
     * 
     * @param seq 사용자의 고유 식별자
     * @return 대화 내역을 포함한 Map 객체
     * @author JGChoi
     */
    @GetMapping(value = "/chat", produces = "application/json")
    @ResponseBody
    public Map<String, Object> chatPage(@RequestParam("seq") String seq) {
        List<ChatDTO> list = dao.list(seq);
        List<Message> chatHistory = new ArrayList<>();

        for (ChatDTO chat : list) {
            chatHistory.add(new Message("user", chat.getMembermsg()));
            chatHistory.add(new Message("assistant", chat.getBotmsg()));
            chatHistory.add(new Message("botConversation",chat.getSeq()));
        }

        Map<String, Object> response = new HashMap<>();
        response.put("chatHistory", chatHistory);
        return response;
    }

    /**
     * POST 요청 처리 메서드
     * 
     * 사용자 입력을 받아 OpenAI GPT 모델에 요청하고, 결과를 반환 및 저장합니다.
     * 
     * @param prompt 사용자 입력 메시지
     * @param seq 사용자의 고유 식별자
     * @param dto 대화 데이터 객체
     * @return GPT 응답 메시지를 포함한 Map 객체
     * @author JGChoi
     */
    @PostMapping(value = "/chat", produces = "application/json; charset=UTF-8")
    @ResponseBody
    public Map<String, String> chatPost(@RequestParam("prompt") String prompt, @RequestParam("seq") String seq, ChatDTO dto) {
        // 사용자 메시지를 messages 리스트에 추가
        messages.add(new Message("user", prompt));

        // GPTRequest 객체 생성 시 messages 리스트 전달
        GPTRequest request = new GPTRequest(model, messages, 1, 2000, 1, 2, 2);

        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "Bearer " + apiKey);
        headers.set("Content-Type", "application/json; charset=UTF-8");
        headers.set("Accept", "application/json; charset=UTF-8");

        HttpEntity<GPTRequest> entity = new HttpEntity<>(request, headers);

        ResponseEntity<GPTResponse> response = restTemplate.exchange(apiUrl, HttpMethod.POST, entity, GPTResponse.class);

        GPTResponse gptResponse = response.getBody();
        String content = gptResponse != null && !gptResponse.getChoices().isEmpty()
                ? gptResponse.getChoices().get(0).getMessage().getContent()
                : "응답 없음";

        // 챗봇 응답을 messages 리스트에 추가
        messages.add(new Message("assistant", content));

        // DB에 사용자 메시지와 챗봇 응답을 저장
        dto.setMembermsg(prompt);
        dto.setBotmsg(content);
        dto.setSeq(seq);

        dao.add(dto);

        Map<String, String> responseMap = new HashMap<>();
        responseMap.put("response", content);

        System.out.println("prompt : " + prompt);
        System.out.println("content: " + content);

        return responseMap;
    }

}
