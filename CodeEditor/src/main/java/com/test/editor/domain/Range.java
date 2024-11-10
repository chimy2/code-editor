package com.test.editor.domain;

import lombok.Data;

@Data
public class Range {
	
	private int endColumn;
	private int endLineNumber;
	private int startColumn;
	private int startLineNumber;
	
}
