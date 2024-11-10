package com.test.editor.domain;

import com.test.editor.model.MemberDTO;

import lombok.Data;

@Data
public class Message {

	private String type;
    private MemberDTO sender;
    private MemberDTO receiver;
	private Cursor cursor;
	private Code code;
}
