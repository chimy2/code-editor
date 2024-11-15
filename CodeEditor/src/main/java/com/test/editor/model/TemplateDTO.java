package com.test.editor.model;

import lombok.Data;


/**
 * TemplateDTO
 * 사용자 정의 템플릿 정보를 담고 있는 데이터 전송 객체입니다.
 * 
 * @author ChoiYuJeong
 *
 */
@Data
public class TemplateDTO {

	private String seq;
	private String keyword;
	private String code;
	private String member_seq;
	
}
