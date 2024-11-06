package com.test.editor.mapper;

import java.util.List;

import com.test.editor.model.ThemeDTO;

public interface SettingsMapper {

	String getTheme(String member_seq);

	String updateTheme(ThemeDTO theme);
	
}
