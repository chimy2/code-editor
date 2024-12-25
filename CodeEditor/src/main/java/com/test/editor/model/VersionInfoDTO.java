package com.test.editor.model;

import lombok.Data;

/**
 * VersionInfoDTO는 버전 정보를 저장하고 전달하기 위한 데이터 전송 객체입니다.
 * 
 * Data: Lombok 애노테이션으로, 다음을 자동으로 생성합니다.
 *        - Getter/Setter 메서드
 *        - toString(), equals(), hashCode() 메서드
 *        - 기본 생성자 및 모든 필드를 포함하는 생성자
 */
@Data
public class VersionInfoDTO {

    /**
     * 버전 정보의 고유 식별자.
     */
    private String seq;

    /**
     * 버전이 등록된 날짜.
     * 예: "2024-11-18"
     */
    private String regdate;

    /**
     * 버전과 관련된 메시지 또는 설명.
     * 예: "Initial commit", "Bug fixes" 등.
     */
    private String message;

    /**
     * 프로젝트의 고유 식별자.
     * 이 버전이 속한 프로젝트를 참조합니다.
     */
    private String project_seq;

    /**
     * 멤버(사용자)의 고유 식별자.
     * 이 버전을 등록한 사용자를 참조합니다.
     */
    private String member_seq;

	public VersionInfoDTO getDefault() {
		this.message = "기본 버전입니다.";
		return this;
	}
}
