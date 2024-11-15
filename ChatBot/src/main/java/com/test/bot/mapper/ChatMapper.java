package com.test.bot.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.test.bot.dto.ChatDTO;

/**
 * ChatMapper 인터페이스
 * 
 * MyBatis를 사용하여 데이터베이스와 상호작용하는 매퍼 인터페이스입니다.
 * `ChatDTO` 객체를 기반으로 데이터를 삽입하거나 조회하는 메서드를 정의합니다.
 * @author JGChoi
 */
@Mapper
public interface ChatMapper {

	int add(ChatDTO dto);

	List<ChatDTO> list(String seq);
	
	
}
