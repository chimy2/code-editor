package com.test.bot.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.bot.dto.ChatDTO;
import com.test.bot.mapper.ChatMapper;

/**
 * ChatDAO 클래스
 * 
 * 데이터베이스와의 상호작용을 담당하는 DAO(Data Access Object) 클래스입니다.
 * ChatMapper 인터페이스를 통해 SQL 쿼리를 실행하며, 
 * 사용자와 챗봇 간의 대화 데이터를 관리합니다.
 * @author JGChoi
 */
@Repository
public class ChatDAO {
	
	@Autowired
	private ChatMapper mapper;

	/**
     * 대화 데이터 추가
     * 
     * 데이터베이스에 새로운 대화 데이터를 저장합니다.
     * 
     * @param dto 저장할 대화 데이터를 포함한 ChatDTO 객체
     * @return 성공 시 1, 실패 시 0 (SQL 실행 결과)
     * @author JGChoi
     */
	public int add(ChatDTO dto) {
		
		return mapper.add(dto);
	}
	/**
     * 대화 데이터 조회
     * 
     * 특정 사용자의 대화 내역을 데이터베이스에서 조회하여 반환합니다.
     * 
     * @param seq 조회할 사용자의 고유 식별자
     * @return 조회된 대화 데이터를 포함한 ChatDTO 객체 리스트
     * @author JGChoi
     */
	public List<ChatDTO> list(String seq) {
		
		return mapper.list(seq);
	}

}
