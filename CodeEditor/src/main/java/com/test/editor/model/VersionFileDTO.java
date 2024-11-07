package com.test.editor.model;

import lombok.Data;

@Data
public class VersionFileDTO {

	private Integer seq;
	private String name;
	private byte[] code;
	private Integer versionInfo_seq;
	private Integer fileType_seq;
	private Integer parent_seq;

    private String date;      // 날짜
    private String member;    // 작성자 이름
    private String message;   // 기록 내용
}
