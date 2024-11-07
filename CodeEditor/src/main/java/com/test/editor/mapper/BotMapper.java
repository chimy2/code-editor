package com.test.editor.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BotMapper {

	int botdel(int seq);
	
}
