package com.test.editor.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.test.editor.dao.MemberDAO;
import com.test.editor.model.MemberDTO;

@Service
public class MemberService {

	private final MemberDAO dao;
	private final TeamService teamService;

	@Autowired
	public MemberService(MemberDAO dao, TeamService teamService) {
		this.dao = dao;
		this.teamService = teamService;
	}

	public List<MemberDTO> getUsernames() {
		return dao.username();
	}
	
	@Transactional(rollbackFor = Exception.class)
	public int join(MemberDTO member) {
		dao.join(member);
		
		if (member.getSeq() != null) {
			dao.callInsertDefaultSettings(member.getSeq());
			return teamService.insertDefault(member);
		}
		
		return 0;
	}
	
	public MemberDTO get(String seq) {
		return dao.get(seq);
	}

	public MemberDTO get(int seq) {
		return get(String.valueOf(seq));
	}
	
	public List<String> getAutoLoginIDs() {
		return dao.getAutoLoginIDs();
	}
}
