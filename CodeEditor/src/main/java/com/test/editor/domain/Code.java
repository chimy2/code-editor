package com.test.editor.domain;

import lombok.Data;

@Data
public class Code {

    private String tabId;
    private String sender;
    private String receiver;
    private String text;
    private Range range;
    private String sendDate;
}
