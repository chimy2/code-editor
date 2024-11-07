package com.test.editor.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.editor.mapper.SettingsMapper;
import com.test.editor.model.ThemeDTO;

@Repository
public class SettingsDAO {

	@Autowired
	private SettingsMapper mapper;
	
	public String getTheme(String member_seq) {
		return mapper.getTheme(member_seq);
	}

	public String updateTheme(ThemeDTO theme) {
		return mapper.updateTheme(theme);
	}

}















