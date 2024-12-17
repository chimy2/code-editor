package com.test.editor.model;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class MemberTeamDTO {

	private String seq;
	private String member_seq;
	private String team_seq;
	private String position;

	MemberTeamDTO(MemberDTO member, TeamDTO team) {
		this.member_seq = member.getSeq();
		this.team_seq = team.getSeq();
	}

	MemberTeamDTO(MemberDTO member, TeamDTO team, String position) {
		this.member_seq = member.getSeq();
		this.team_seq = team.getSeq();
		this.position = position;
	}
}
