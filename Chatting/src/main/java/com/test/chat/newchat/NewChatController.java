package com.test.chat.newchat;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class NewChatController {

    /**
     * "/index" 경로로 요청이 들어오면 index.jsp를 반환합니다.
     * 
     * @return index.jsp 뷰 이름을 반환합니다.
     */
    @GetMapping("/index")
    public String index() {
        return "index";
    }
}
