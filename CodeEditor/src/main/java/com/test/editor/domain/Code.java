package com.test.editor.domain;

import com.test.editor.model.MemberDTO;

import lombok.Data;

/**
 * 
 * 코드 편집에 대한 정보를 나타내는 클래스입니다.
 * 탭 ID, 텍스트, 편집 범위, 전송 일자를 포함합니다.
 * @author sohye park
 *
 */
@Data
public class Code {

    /** 현재 작업 중인 탭의 ID */
    private String tabId;
    
    /** 코드 또는 텍스트 내용 */
    private String text;

    /** 코드 편집의 범위를 나타내는 Range 객체 */
    private Range range;

    /** 메시지 또는 코드 전송 날짜 및 시간 */
    private String sendDate;
}
