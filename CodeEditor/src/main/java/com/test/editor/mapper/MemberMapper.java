package com.test.editor.mapper;

import java.util.List;

import com.test.editor.model.MemberDTO;
import com.test.editor.model.MemberProject;

public interface MemberMapper {

	MemberDTO loadUser(String username);

	MemberDTO list(String nick);

	int duplicatedCheck(String email);

	int duplicatedNickCheck(String check);

	int joinOk(MemberDTO dto);

	List<MemberDTO> username();

	void callInsertDefaultSettings(String member_seq);

	String getMaxSeq();

	int nickEdit(MemberDTO dto);

	List<MemberDTO> load(String seq);

	List<MemberProject> getMemberProject(String member_seq);


	
	
	
}
