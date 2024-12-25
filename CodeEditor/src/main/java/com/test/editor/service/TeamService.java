package com.test.editor.service;

import org.springframework.stereotype.Service;

import com.test.editor.dao.TeamDAO;
import com.test.editor.model.MemberDTO;
import com.test.editor.model.ProjectDTO;
import com.test.editor.model.TeamDTO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class TeamService {

	private final TeamDAO dao;
	
	private final MemberTeamService memberTeamService;
	
	private final ProjectService projectService;
	
	public int insert(MemberDTO member, TeamDTO team) {
		dao.insert(team);
		return memberTeamService.insert(member, team);
	}
	
	public int insertDefault(MemberDTO member) {
		TeamDTO team = new TeamDTO(member);
		insert(member, team);
		return projectService.insertDefault(member, team);
	}
	
}
