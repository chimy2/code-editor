package com.test.editor.model;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class TeamDTO {

	private String seq;
	private String teamName;
	private String teamEx;
	private String teamType;
	private String regdate;

	public TeamDTO(MemberDTO member) {
		this.teamName = member.getNick();
		this.teamEx = "기본 팀입니다.";
		this.teamType = "1";
	}
}
