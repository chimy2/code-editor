package com.test.editor.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.test.editor.mapper.BasicFileMapper;
import com.test.editor.model.BasicFileDTO;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class BasicFileDAO {
	
	private final BasicFileMapper mapper;

	public List<BasicFileDTO> getAllFiles() {
		return mapper.getAllFiles();
	}

}
