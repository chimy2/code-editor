package com.test.editor.service;

import org.springframework.stereotype.Service;

import com.test.editor.dao.TeamDAO;
import com.test.editor.model.TeamDTO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class TeamService {

	private final TeamDAO dao;
	
	public void insert(TeamDTO dto) {
		dao.insert(dto);
	}
}
