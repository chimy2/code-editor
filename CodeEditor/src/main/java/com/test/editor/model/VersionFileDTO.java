package com.test.editor.model;

import java.sql.Blob;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 버전 파일 정보를 저장하는 DTO 클래스
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class VersionFileDTO {

    private String seq; // 기본 키(Primary Key)
    private String name; // 파일 이름
    private String code; // 파일 내용 (바이트 배열)
    private String versionInfoSeq; // 버전 정보에 대한 외래 키
    private String fileTypeSeq; // 파일 타입에 대한 외래 키
    private String parentSeq; // 부모 디렉토리/파일에 대한 외래 키

}
