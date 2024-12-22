package com.test.editor.dao;

import org.springframework.stereotype.Repository;

import com.test.editor.mapper.VersionInfoMapper;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class VersionInfoDAO {
	
	private final VersionInfoMapper mapper;
	
	
}
