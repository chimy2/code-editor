package com.test.editor.model;

import java.util.List;

import lombok.Data;

@Data
public class MemberDTO {
	
	private String seq;
	private String id;
	private String pw;
	private String nick;
	private String regdate;
	private String ing;
	private String color;
	private String oAuthType;
	private List<TeamDTO> teamList;
	private List<ProjectDTO> projectList;
	private List<MemberTeamDTO> memberTeamList;

}
