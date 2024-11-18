package com.test.editor.domain;

import lombok.Data;

/**
 * 
 * 코드 편집 시 시작 및 종료 위치를 나타내는 범위 정보 클래스입니다.
 * 편집이 이루어진 행과 열의 정보를 포함합니다.
 * @author sohye park
 *
 */
@Data
public class Range {

    /** 편집 종료 위치의 열 번호 */
	private int endColumn;

    /** 편집 종료 위치의 행 번호 */
	private int endLineNumber;

    /** 편집 시작 위치의 열 번호 */
	private int startColumn;

    /** 편집 시작 위치의 행 번호 */
	private int startLineNumber;
	
}
