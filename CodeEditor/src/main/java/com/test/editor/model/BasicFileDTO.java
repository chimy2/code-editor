package com.test.editor.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * BasicFileDTO는 파일의 기본 정보를 저장하고 전달하기 위한 데이터 전송 객체입니다.
 * 
 * Data: Lombok 애노테이션으로, 다음을 자동으로 생성합니다.
 *        - Getter/Setter 메서드
 *        - toString(), equals(), hashCode() 메서드
 *        - 기본 생성자 및 모든 필드를 포함하는 생성자
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BasicFileDTO {

    /**
     * 파일의 고유 식별자.
     */
    private String seq;

    /**
     * 파일의 이름.
     */
    private String name;

    /**
     * 파일의 코드 또는 내용 (예: 소스 코드, 텍스트 등).
     */
    private String code;

    /**
     * 파일 유형의 고유 식별자.
     * fileType_seq는 파일 유형(예: class, interface, txt 등)을 나타내는 외래 키 역할을 합니다.
     */
    private String fileTypeSeq;

    /**
     * 상위 파일의 고유 식별자.
     * parent_seq는 이 파일의 부모 파일(예: 디렉터리 또는 프로젝트)의 식별자를 나타냅니다.
     */
    private String parentSeq;

    public VersionFileDTO toVersionFile(VersionInfoDTO versionInfo, int versionInfoSeq) {
    	String parentSeq = this.parentSeq == null ? null : String.valueOf(versionInfoSeq + Integer.parseInt(this.parentSeq));
    	
		return VersionFileDTO.builder()
    			.name(this.name)
    			.code(this.code)
    			.versionInfoSeq(versionInfo.getSeq())
    			.fileTypeSeq(this.fileTypeSeq)
    			.parentSeq(parentSeq)
    			.build();
    }
}
