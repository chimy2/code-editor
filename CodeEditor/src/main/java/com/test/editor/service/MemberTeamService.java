package com.test.editor.service;

import org.springframework.stereotype.Service;

import com.test.editor.dao.MemberTeamDAO;
import com.test.editor.model.MemberDTO;
import com.test.editor.model.TeamDTO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberTeamService {

	private final MemberTeamDAO dao;

	public int insert(MemberDTO member, TeamDTO team) {
		return dao.insert(member, team);
	}
}
