package com.test.editor.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.test.editor.model.MemberDTO;
import com.test.editor.model.MemberProject;

@Mapper
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

	List<MemberProject> getSelProject(Map<String, String> selTeam);

	void join(MemberDTO dto);

	MemberDTO get(String seq);

	List<String> getAutoLoginIDs();

}
