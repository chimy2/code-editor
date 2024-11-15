package com.test.editor.model;

import lombok.Data;

/**
 * StyleSettingDTO
 * 사용자 스타일 설정 정보를 담고 있는 데이터 전송 객체입니다.
 * @author ChoiYuJeong
 *
 */
@Data
public class StyleSettingDTO {

	private String seq;
	private String value;
	private String styleType_seq;
	private String member_seq;
	private StyleTypeDTO styleType;

}
