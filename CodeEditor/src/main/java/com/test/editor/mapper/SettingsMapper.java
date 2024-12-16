package com.test.editor.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.test.editor.model.StyleSettingDTO;
import com.test.editor.model.TemplateDTO;
import com.test.editor.model.ThemeDTO;

/**
 * SettingsMapper
 * 사용자 설정 관련 데이터베이스 작업을 정의하는 MyBatis Mapper 인터페이스입니다.
 * @author ChoiYuJeong
 *
 */
@Mapper
public interface SettingsMapper {

	/**
	 * 사용자의 테마 설정을 가져옵니다.
	 * 
	 * @param member_seq 사용자의 고유 식별자
	 * @return 테마 설정 (dark 또는 light)
	 */
	String getTheme(String member_seq);

	/**
	 * 사용자의 폰트 설정을 가져옵니다.
	 * 
	 * @param member_seq 사용자의 고유 식별자
	 * @return StyleSettingDTO 리스트
	 */
	List<StyleSettingDTO> getFont(String member_seq);

	/**
	 * 사용자의 색상 설정을 가져옵니다.
	 * 
	 * @param member_seq 사용자의 고유 식별자
	 * @return StyleSettingDTO 리스트
	 */
	List<StyleSettingDTO> getColor(String member_seq);

	/**
	 * 사용자의 템플릿 목록을 가져옵니다.
	 * 
	 * @param member_seq 사용자의 고유 식별자
	 * @return TemplateDTO 리스트
	 */
	List<TemplateDTO> getTemplate(String member_seq);
 
	/**
	 * 사용자의 폰트 설정을 업데이트합니다.
	 * 
	 * @param fontStyle 폰트 스타일 정보가 담긴 맵
	 * @return 업데이트된 행의 수
	 */
	int updateFont(Map<String, Object> fontStyle);

	/**
	 * 사용자의 색상 설정을 업데이트합니다.
	 * 
	 * @param colorStyle 색상 스타일 정보가 담긴 맵
	 * @return 업데이트된 행의 수
	 */
	int updateColor(Map<String, Object> colorStyle);

	/**
	 * 사용자의 템플릿을 업데이트합니다.
	 * 
	 * @param template 업데이트할 템플릿 정보
	 * @return 업데이트된 행의 수
	 */
	int updateTemplate(TemplateDTO template);

	/**
	 * 새 템플릿을 추가합니다.
	 * 
	 * @param template 추가할 템플릿 정보
	 * @return 추가된 템플릿의 ID
	 */
	int addTemplate(TemplateDTO template);

	/**
	 * 특정 템플릿을 삭제합니다.
	 * 
	 * @param template_seq 삭제할 템플릿의 식별자
	 * @return 삭제된 행의 수
	 */
	int delTemplate(String template_seq);

	/**
	 * 테마 전환 작업을 수행합니다.
	 * 
	 * @param theme 테마 정보
	 */
	void callSwitchTheme(ThemeDTO theme);

	/**
	 * 사용자의 테마 설정을 업데이트합니다.
	 * 
	 * @param theme 업데이트할 테마 정보
	 */
	void updateTheme(ThemeDTO theme);
	
}
