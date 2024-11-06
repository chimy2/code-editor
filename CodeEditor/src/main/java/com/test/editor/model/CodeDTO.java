package com.test.editor.model;

import lombok.Data;

@Data
public class CodeDTO {

//	private String code;
//	private String sender;
//	private String receiver;
//	private String content;
//	private String regdate;

    private String tabId;
    private String content;
    private int cursorLine;
    private int cursorColumn;
    private String userId; // For future extension to identify users by nickname or ID.

}
