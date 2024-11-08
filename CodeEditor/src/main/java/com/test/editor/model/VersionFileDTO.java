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

}
