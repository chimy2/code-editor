package com.test.editor.domain;

import com.test.editor.model.MemberDTO;

import lombok.Data;

/**
 * 
 * WebSocket을 통해 전송되는 메시지를 나타내는 클래스입니다.
 * 메시지의 유형, 발신자, 수신자, 커서 위치, 코드 내용을 포함합니다.
 * @author sohye park
 *
 */
@Data
public class Message {

    /** 메시지 유형을 나타내는 문자열 (예: 'cursor' 또는 'code') */
	private String type;
	
    /** 메시지를 보낸 사용자 정보 */
    private MemberDTO sender;

    /** 메시지를 받는 사용자 정보 */
    private MemberDTO receiver;

    /** 커서 위치 정보 */
	private Cursor cursor;

    /** 코드 관련 정보 */
	private Code code;
}
