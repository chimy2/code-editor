package com.test.editor.dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.editor.mapper.MemberMapper;
import com.test.editor.model.MemberDTO;
import com.test.editor.model.MemberProject;


/**
 * 
 * MemberDAO
 * 메인페이지와 마이페이지와 관련된 메서드를 모아둔 클래스입니다. 
 * @author bohwa Jang
 *
 */
@Repository
public class MemberDAO  {

	/**
	 * 데이터베이스 연동을 담당하는 객체
	 */
	@Autowired
	private MemberMapper mapper;

	/**
	 * 닉네임을 통해 유저 모든 정보를 가져오는 메서드
	 * @param nick 유저 닉네임 정보
	 * @return 동일한 닉네임의 모든 정보
	 */
	public MemberDTO list(String nick) {
	
		return mapper.list(nick);
	}

	/**
	 * 회원가입 시 이메일 중복체크를 위한 메서드
	 * @param check 이메일 정보
	 * @return 이메일 존재 여부
	 */
	public int duplicatedCheck(String check) {
		
		return mapper.duplicatedCheck(check);
	}

	/**
	 * 회원가입 시 닉네임 중복체크를 위한 메서드
	 * @param check 닉네임 정보
	 * @return 닉네임 존재 여부 
	 */
	public int duplicatedNickCheck(String check) {
		
		return mapper.duplicatedNickCheck(check);
	}

	/**
	 * 회원가입 시 유저 테이블의 모든 정보를 저장하기 위한 메서드
	 * @param dto 유저테이블 정보
	 * @return 유정 정보가 정상적으로 insert되었는지 확인 여부
	 */
	public int joinOk(MemberDTO dto) {

		return mapper.joinOk(dto);
	}
	
	public void join(MemberDTO member) {
		mapper.join(member);
	}
	
	public MemberDTO get(String seq) {
		return mapper.get(seq);
	}

	/**
	 * 자동 로그인을 위한 메서드
	 * @return 특정 seq 유정 모든 정보
	 */
	public List<MemberDTO> username() {
		
		return mapper.username();
	}

	/**
	 * 회원가입 시 코드편집기와 관련된 테이블의 기본 정보를 저장하기 위한 메서드
	 * @param member_seq 유저 seq
	 */
	public void callInsertDefaultSettings(String member_seq) {
		mapper.callInsertDefaultSettings(member_seq);
	}

	/**
	 * 회원가입한 유저 seq를 불러오기 위한 메서드
	 * @return 최근 회원가입한 유저 seq
	 */
	public String getMaxSeq() {
		return mapper.getMaxSeq();
	}

	/**
	 * 변경한 닉네임을 insert하는 메서드
	 * @param dto 유저의 모든 정보
	 * @return 닉네임 변경 확인 여부
	 */
	public int nickEdit(MemberDTO dto) {
		
		return mapper.nickEdit(dto);
	}

	/**
	 * 특정 seq의 유저의 모든 정보를 가져오는 메서드
	 * @param seq 유저 seq
	 * @return seq의 유저의 모든 정보
	 */
	public List<MemberDTO> load(String seq) {
		// TODO Auto-generated method stub
		return mapper.load(seq);
	}

	/**
	 * 유저의 모든 팀 정보를 가져오는 메서드
	 * @param member_seq 유저 seq
	 * @return 유저의 모든 팀 seq
	 */
	public List<MemberProject> getMemberProject(String member_seq) {
		return mapper.getMemberProject(member_seq);
	}

	/**
	 * 팀의 모든 프로젝트 정보를 가져오는 메서드
	 * @param selTeam 팀과 유저 seq
	 * @return 팀과 유저 seq에 해당하는 프로젝트 정보
	 */
	public List<MemberProject> getSelProject(Map<String, String> selTeam) {
		return mapper.getSelProject(selTeam);
	}

	public List<String> getAutoLoginIDs() {
		return mapper.getAutoLoginIDs();
	}




	
	
	
}
