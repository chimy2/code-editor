package com.test.editor.model;

import lombok.Data;

@Data
public class CodeDTO {

	private String code;
	private String sender;
	private String receiver;
	private String content;
	private String regdate;
}
