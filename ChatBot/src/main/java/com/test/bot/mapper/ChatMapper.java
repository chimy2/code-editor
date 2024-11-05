package com.test.bot.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.test.bot.dto.ChatDTO;


@Mapper
public interface ChatMapper {

	int add(ChatDTO dto);

	List<ChatDTO> list(String seq);
	
	
}
