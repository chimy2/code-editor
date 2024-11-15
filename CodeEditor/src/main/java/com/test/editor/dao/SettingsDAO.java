package com.test.editor.dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.editor.mapper.SettingsMapper;
import com.test.editor.model.StyleSettingDTO;
import com.test.editor.model.TemplateDTO;
import com.test.editor.model.ThemeDTO;

/**
 * SettingsDAO
 * 사용자 설정 관련 데이터에 접근하는 DAO 클래스입니다.
 * 데이터베이스와의 상호작용을 처리합니다.
 * @author ChoiYuJeong
 *
 */
@Repository
public class SettingsDAO {
	
	/**
	 * SettingsMapper의 인스턴스를 자동으로 주입합니다.
	 * 데이터베이스 작업을 수행하기 위해 사용됩니다.
	 */
	@Autowired
	private SettingsMapper mapper;
	
	
	/**
	 * 사용자의 테마 설정을 가져옵니다.
	 * 
	 * @param member_seq 사용자의 고유 식별자
	 * @return 테마 설정 (dark 또는 light)
	 */
	public String getTheme(String member_seq) {
		return mapper.getTheme(member_seq);
	}

	/**
	 * 사용자의 테마 설정을 업데이트합니다.
	 * 
	 * @param theme 업데이트할 테마 정보
	 */
	public void updateTheme(ThemeDTO theme) {
		mapper.updateTheme(theme);
		mapper.callSwitchTheme(theme);
	}

	/**
	 * 사용자의 폰트 설정을 가져옵니다.
	 * 
	 * @param member_seq 사용자의 고유 식별자
	 * @return StyleSettingDTO 리스트
	 */
	public List<StyleSettingDTO> getFont(String member_seq) {
		return mapper.getFont(member_seq);
		
	}
	
	
	/**
	 * 사용자의 색상 설정을 가져옵니다.
	 * 
	 * @param member_seq 사용자의 고유 식별자
	 * @return StyleSettingDTO 리스트
	 */
	public List<StyleSettingDTO> getColor(String member_seq) {
		return mapper.getColor(member_seq);
	}

	/**
	 * 사용자의 템플릿 목록을 가져옵니다.
	 * 
	 * @param member_seq 사용자의 고유 식별자
	 * @return TemplateDTO 리스트
	 */
	public List<TemplateDTO> getTemplate(String member_seq) {
		return mapper.getTemplate(member_seq);
	}
   
	/**
	 * 사용자의 폰트 설정을 업데이트합니다.
	 * 
	 * @param fontStyle 폰트 스타일 정보가 담긴 맵
	 * @return 업데이트된 행의 수
	 */
	public int updateFont(Map<String, Object> fontStyle) {
		return mapper.updateFont(fontStyle);
	}

	/**
	 * 사용자의 색상 설정을 업데이트합니다.
	 * 
	 * @param colorStyle 색상 스타일 정보가 담긴 맵
	 * @return 업데이트된 행의 수
	 */
	public int updateColor(Map<String, Object> colorStyle) {
		return mapper.updateColor(colorStyle);
	}

	/**
	 * 사용자의 템플릿을 업데이트합니다.
	 * 
	 * @param template 업데이트할 템플릿 정보
	 * @return 업데이트된 행의 수
	 */
	public int updateTemplate(TemplateDTO template) {
		return mapper.updateTemplate(template);
	}

	/**
	 * 새 템플릿을 추가합니다.
	 * 
	 * @param template 추가할 템플릿 정보
	 * @return 추가된 템플릿의 ID
	 */
	public int addTemplate(TemplateDTO template) {
		return mapper.addTemplate(template);
	}

	/**
	 * 특정 템플릿을 삭제합니다.
	 * 
	 * @param template_seq 삭제할 템플릿의 식별자
	 * @return 삭제된 행의 수
	 */
	public int delTemplate(String template_seq) {
		return mapper.delTemplate(template_seq);
	}
	
	

}

