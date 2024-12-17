package com.test.editor.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.TransactionSynchronizationManager;

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

	public void checkTransaction() {
		System.out.println("트랜잭션 활성화 여부: " + TransactionSynchronizationManager.isActualTransactionActive());
	}
}
