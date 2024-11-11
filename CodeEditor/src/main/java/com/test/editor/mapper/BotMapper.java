package com.test.editor.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.test.editor.model.BotStatsDTO;

@Mapper
public interface BotMapper {

	int botdel(int seq);

	List<BotStatsDTO> stats(int seq);

	List<BotStatsDTO> summary(int seq);

	
}
