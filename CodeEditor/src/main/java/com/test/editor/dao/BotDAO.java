package com.test.editor.dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.editor.mapper.BotMapper;
import com.test.editor.model.BotStatsDTO;

@Repository
public class BotDAO {
	
	@Autowired
	private BotMapper mapper;

	public int delbot(int seq) {
		
		return mapper.botdel(seq);
	}

	public List<BotStatsDTO> stats(int seq) {
		
        return mapper.stats(seq);
    }

	public List<BotStatsDTO> summary(int seq) {
		
		return mapper.summary(seq);
	}

}
