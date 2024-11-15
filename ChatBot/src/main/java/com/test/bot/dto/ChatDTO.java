package com.test.bot.dto;

import lombok.Getter;
import lombok.Setter;

/**
 * ChatDTO 클래스
 * 
 * 사용자와 챗봇 간의 대화 데이터를 저장하는 DTO(Data Transfer Object) 클래스입니다.
 * 이 클래스는 데이터베이스와의 상호작용을 통해 주고받은 메시지, 
 * 대화에 대한 메타데이터를 포함한 정보를 전달합니다.
 * @author JGChoi
 */
@Getter
@Setter
public class ChatDTO {
    
    private String seq;

    private String memberseq;

    private String botmsg;

    private String membermsg;

    private String chatdate;
}