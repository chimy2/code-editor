package com.test.bot.controller;

import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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

@Controller
@RequestMapping("/gpt")
public class GPTController {

    @Autowired
    private ChatDAO dao;

    private String model = "gpt-3.5-turbo";	//  "gpt-3.5-turbo" , "ft:gpt-4o-mini-2024-07-18:personal::AQ28Huai" 
    private String apiKey = "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";
    private String apiUrl = "https://api.openai.com/v1/chat/completions";
    private final RestTemplate restTemplate;
    
    // 대화 내역을 저장할 리스트
    private List<Message> messages = new ArrayList<>();

    public GPTController() {
        this.restTemplate = new RestTemplate();
        this.restTemplate.getMessageConverters().add(0, new StringHttpMessageConverter(StandardCharsets.UTF_8));
    }

    @GetMapping("/chat")
    public String chatPage(@RequestParam("seq") String seq, Model model) {
        // seq에 해당하는 사용자의 기존 대화 내역을 DB에서 조회
        List<ChatDTO> list = dao.list(seq);

        // 조회한 대화 내역을 messages 리스트에 추가
        messages.clear();
        for (ChatDTO chat : list) {
            messages.add(new Message("user", chat.getMembermsg()));
            messages.add(new Message("assistant", chat.getBotmsg()));
        }

        // JSP로 전달하기 위해 모델에 이전 대화 내역을 추가
        model.addAttribute("chatHistory", messages);
        model.addAttribute("seq", seq); // 사용자 seq도 JSP에 전달
        
        return "chatbot";
    }

    @PostMapping(value = "/chat", produces = "application/json; charset=UTF-8")
    @ResponseBody
    public Map<String, String> chatPost(@RequestParam("prompt") String prompt, @RequestParam("seq") String seq, ChatDTO dto) {
        // 사용자 메시지를 messages 리스트에 추가
        messages.add(new Message("user", prompt));

        // GPTRequest 객체 생성 시 messages 리스트 전달
        GPTRequest request = new GPTRequest(model, messages, 1, 256, 1, 2, 2);

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
