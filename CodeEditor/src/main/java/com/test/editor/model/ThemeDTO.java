package com.test.editor.model;

import lombok.Data;

/**
 * ThemeDTO
 * 사용자 테마 정보를 담고 있는 데이터 전송 객체입니다.
 *  
 * @author ChoiYuJeong
 *
 */
@Data
public class ThemeDTO {

	private String seq;
	private String theme;
	private String member_seq;
	
}
