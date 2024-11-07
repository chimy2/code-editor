package com.test.editor.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.editor.mapper.BotMapper;

@Repository
public class BotDAO {
	
	@Autowired
	private BotMapper mapper;

	public int delbot(int seq) {
		
		return mapper.botdel(seq);
	}

}
