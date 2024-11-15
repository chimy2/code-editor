package com.test.editor.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.test.editor.dao.SettingsDAO;
import com.test.editor.model.MemberDTO;
import com.test.editor.model.StyleSettingDTO;
import com.test.editor.model.TemplateDTO;
import com.test.editor.model.ThemeDTO;

import lombok.RequiredArgsConstructor;


/** 
 * SettingsController
 * 코드 에디터 설정 컨트롤러 입니다.
 * CRUD 작업: 폰트, 색상, 테마, 템플릿에 대한 CRUD 작업이 각각 구현되어 있어, 사용자가 자유롭게 설정을 관리할 수 있습니다.
 * 세션 관리: 모든 설정 메서드는 HttpSession을 사용해 현재 로그인된 사용자의 정보를 가져옵니다. member_seq는 사용자마다 고유한 ID로, 각 사용자별로 설정을 저장하고 관리하는 데 사용됩니다.
 * @author ChoiYuJeong
 */
@Controller
@RequiredArgsConstructor
public class SettingsController {

	
	/**
	 * 데이터베이스와의 모든 작업은 SettingsDAO를 통해 이루어집니다.
	 */
	private final SettingsDAO dao;

	
	/**
	 * 현재 사용자의 테마 설정을 가져옵니다.
	 * @param session 현재 사용자의 세션
	 * @return 테마 설정 (String 형식)
	 */
	@GetMapping("/theme")
	@ResponseBody
	public String getTheme(HttpSession session) {

		MemberDTO member = (MemberDTO) session.getAttribute("member");
		String member_seq = member.getSeq();  
		
		return dao.getTheme(member_seq);
	}
	
	/**
	 * 테마 설정을 업데이트합니다.
	 * @param theme ThemeDTO
	 * @param session 현재 사용자의 세션
	 * @return 업데이트 결과 메시지 (String 형식)
	 */
	@PutMapping(value="/theme", produces="application/json")
	@ResponseBody
	public String updateTheme(@RequestBody ThemeDTO theme, HttpSession session) {

		MemberDTO member = (MemberDTO) session.getAttribute("member");
		String member_seq = member.getSeq(); 
		
		theme.setMember_seq(member_seq);
		dao.updateTheme(theme);

		return "update theme";
	}

	/**
	 * 현재 사용자의 폰트 설정을 가져옵니다.
	 * @param session 현재 사용자의 세션
	 * @return StyleSettingDTO 리스트 (JSON 형식)
	 */
	@GetMapping(value = "/font", produces="application/json")
	@ResponseBody
	public List<StyleSettingDTO> getFont(HttpSession session) {

		MemberDTO member = (MemberDTO) session.getAttribute("member");
		String member_seq = member.getSeq(); 
		
		return dao.getFont(member_seq);
	}
	
	/**
	 * 폰트 설정을 업데이트합니다.
	 * @param styleSettings StyleSettingDTO 리스트 (JSON 형식)
	 * @param session 현재 사용자의 세션
	 * @return 업데이트 결과 메시지 (String 형식)
	 */
	@PutMapping(value="/font", produces="application/json")
	@ResponseBody
	public String updateFont(@RequestBody List<StyleSettingDTO> styleSettings, HttpSession session) {

		MemberDTO member = (MemberDTO) session.getAttribute("member");
		String member_seq = member.getSeq(); 
		
	    Map<String, Object> fontStyle = new HashMap<>();
	    
	    for (StyleSettingDTO setting : styleSettings) {
	        if ("1".equals(setting.getStyleType_seq())) {
	        	fontStyle.put("fontSize", setting);
	        } else if ("2".equals(setting.getStyleType_seq())) {
	        	fontStyle.put("fontFamily", setting);
	        }
	    }
	    
	    fontStyle.put("member_seq", member_seq);
	    
	    dao.updateFont(fontStyle);
	    
		return "update font";
	}
	
	
	/**
	 * 현재 사용자의 색상 설정을 가져옵니다.
	 * @param session 현재 사용자의 세션
	 * @return tyleSettingDTO 리스트 (JSON 형식)
	 */
	@GetMapping(value="/color", produces="application/json")
	@ResponseBody
	public List<StyleSettingDTO> getColor(HttpSession session) {

		MemberDTO member = (MemberDTO) session.getAttribute("member");
		String member_seq = member.getSeq(); 
		
		return dao.getColor(member_seq);
	}
	
	
	/**
	 * 색상 설정을 업데이트합니다.
	 * @param styleSettings StyleSettingDTO 리스트 (JSON 형식)
	 * @param session 현재 사용자의 세션
	 * @return 업데이트 결과 메시지 (String 형식)
	 */
	@PutMapping(value="/color", produces="application/json")
	@ResponseBody
	public String updateColor(@RequestBody List<StyleSettingDTO> styleSettings, HttpSession session) {
		
		MemberDTO member = (MemberDTO) session.getAttribute("member");
		String member_seq = member.getSeq(); 
		
		Map<String, Object> colorStyle = new HashMap<>();
		
		for (StyleSettingDTO data : styleSettings) {
			if ("3".equals(data.getStyleType_seq())) {
			    colorStyle.put("background", data);
			} else if ("4".equals(data.getStyleType_seq())) {
			    colorStyle.put("foreground", data);
			} else if ("5".equals(data.getStyleType_seq())) {
			    colorStyle.put("comment", data);
			} else if ("6".equals(data.getStyleType_seq())) {
			    colorStyle.put("keyword", data);
			} else if ("7".equals(data.getStyleType_seq())) {
			    colorStyle.put("String", data);
			} 
			
		}
		colorStyle.put("member_seq", member_seq);
		dao.updateColor(colorStyle);
		
		return "update color";
	}

	
	/**
	 * 현재 사용자의 템플릿 목록을 가져옵니다.
	 * @param model 뷰에 데이터를 전달하기 위한 객체
	 * @param session 현재 사용자의 세션
	 * @return TemplateDTO 리스트 (JSON 형식)
	 */
    @GetMapping(value="/template", produces="application/json")
    @ResponseBody 
    public List<TemplateDTO> getTemplate(Model model, HttpSession session) {

    	MemberDTO member = (MemberDTO) session.getAttribute("member");
		String member_seq = member.getSeq(); 
		
    	List<TemplateDTO> template = dao.getTemplate(member_seq); 
	    model.addAttribute("template", template);
	    return template; 
    }
    
    
    /**
     * 템플릿을 업데이트합니다.
     * @param template TemplateDTO (JSON 형식)
     * @return 업데이트된 템플릿의 수 (int 형식)
     */
    @PutMapping(value="/template", produces="application/json")
    @ResponseBody
    public int updateTemplate(@RequestBody TemplateDTO template) {
    	return dao.updateTemplate(template);
    }
    
    /**
     * 새로운 템플릿을 추가합니다.
     * @param template TemplateDTO (JSON 형식)
     * @param session 현재 사용자의 세션
     * @return 추가된 템플릿의 ID (int 형식)
     */
    @PostMapping(value="/template", produces="application/json")
    @ResponseBody 
    public int addTemplate(@RequestBody TemplateDTO template, HttpSession session) {
    	
    	MemberDTO member = (MemberDTO) session.getAttribute("member");
		String member_seq = member.getSeq(); 
		
    	template.setMember_seq(member_seq);
    	return dao.addTemplate(template);
    }
    
    /**
     * 템플릿을 삭제합니다.
     * @param template_seq 경로 변수: template_seq (삭제할 템플릿의 ID)
     * @return 삭제된 템플릿의 수 (int 형식)
     */
    @DeleteMapping(value="/template/{template_seq}", produces="application/json")
    @ResponseBody
    public int delTemplate(@PathVariable("template_seq") String template_seq) {
    	return dao.delTemplate(template_seq);
    }

}
