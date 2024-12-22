package com.test.editor.model;

import lombok.Data;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.Builder;

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
    private String versionInfo_seq; // 버전 정보에 대한 외래 키
    private String fileType_seq; // 파일 타입에 대한 외래 키
    private String parent_seq; // 부모 디렉토리/파일에 대한 외래 키

}
