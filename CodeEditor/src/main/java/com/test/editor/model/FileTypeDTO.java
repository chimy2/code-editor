package com.test.editor.model;

import lombok.Data;

/**
 * FileTypeDTO는 파일 유형 정보를 저장하고 전달하기 위한 데이터 전송 객체입니다.
 * 
 * Data: Lombok 애노테이션으로, 다음을 자동으로 생성합니다.
 *        - Getter/Setter 메서드
 *        - toString(), equals(), hashCode() 메서드
 *        - 기본 생성자 및 모든 필드를 포함하는 생성자
 */
@Data
public class FileTypeDTO {

    /**
     * 파일 유형의 고유 식별자.
     */
    private String seq;

    /**
     * 파일 유형의 이름 또는 종류를 나타냅니다.
     * 예: "class", "interface", "txtFile" 등
     */
    private String fileType;
}
