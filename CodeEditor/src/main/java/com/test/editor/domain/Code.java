package com.test.editor.domain;

import com.test.editor.model.MemberDTO;

import lombok.Data;

@Data
public class Code {

    private String tabId;
    private String text;
    private Range range;
    private String sendDate;
}
