package com.test.editor.dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.editor.mapper.MemberMapper;
import com.test.editor.model.MemberDTO;
import com.test.editor.model.MemberProject;

@Repository
public class MemberDAO  {

	@Autowired
	private MemberMapper mapper;

	public MemberDTO list(String nick) {
	
		return mapper.list(nick);
	}

	public int duplicatedCheck(String check) {
		
		return mapper.duplicatedCheck(check);
	}

	public int duplicatedNickCheck(String check) {
		
		return mapper.duplicatedNickCheck(check);
	}

	public int joinOk(MemberDTO dto) {

		return mapper.joinOk(dto);
	}

	public List<MemberDTO> username() {
		
		return mapper.username();
	}

	public void callInsertDefaultSettings(String member_seq) {
		mapper.callInsertDefaultSettings(member_seq);
	}

	public String getMaxSeq() {
		return mapper.getMaxSeq();
	}


	public int nickEdit(MemberDTO dto) {
		
		return mapper.nickEdit(dto);
	}

	public List<MemberDTO> load(String seq) {
		// TODO Auto-generated method stub
		return mapper.load(seq);
	}


	public List<MemberProject> getMemberProject(String member_seq) {
		return mapper.getMemberProject(member_seq);
	}


	public List<MemberProject> getSelProject(Map<String, String> selTeam) {
		return mapper.getSelProject(selTeam);
	}




	
	
	
}
