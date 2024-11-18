package com.test.editor.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.test.editor.service.VersionService;

/**
 * VersionController는 버전 관리와 관련된 HTTP 요청을 처리하는 컨트롤러 클래스입니다.
 * Spring의 @Controller 애노테이션을 사용하여 스프링 컨테이너에 등록됩니다.
 */
@Controller
public class VersionController {

    /**
     * VersionService는 버전 복원과 관련된 비즈니스 로직을 처리하는 서비스 클래스입니다.
     * @Autowired 애노테이션을 사용하여 Spring 컨테이너에서 자동으로 주입됩니다.
     */
    @Autowired
    private VersionService versionService;

    /**
     * /restoreVersion 경로로 들어오는 POST 요청을 처리합니다.
     * 클라이언트로부터 JSON 형식의 요청을 받아, 해당 버전을 복원하는 작업을 수행합니다.
     * 
     * @param request 클라이언트에서 전달된 JSON 데이터를 맵으로 매핑한 객체입니다.
     *                예: {"versionDate": "2024-01-01"}
     * @return Map<String, Object> - 성공 여부를 포함한 응답 데이터입니다.
     *                               예: {"success": true}
     * 
     * @PostMapping: 이 메서드가 /restoreVersion 경로의 POST 요청을 처리하도록 지정합니다.
     * @ResponseBody: 메서드의 반환 값을 JSON 형식으로 클라이언트에 응답하도록 지정합니다.
     * @RequestBody: 요청 본문에 포함된 JSON 데이터를 Java 객체(Map<String, String>)로 변환합니다.
     */
    @PostMapping("/restoreVersion")
    @ResponseBody
    public Map<String, Object> restoreVersion(@RequestBody Map<String, String> request) {
        // 클라이언트에서 전달된 versionDate 값을 추출
        String versionDate = request.get("versionDate");
        
        // VersionService를 통해 지정된 버전 복원을 수행
        boolean success = versionService.restoreVersion(versionDate);
        
        // 결과를 담은 응답 맵 생성 및 반환
        Map<String, Object> response = new HashMap<>();
        response.put("success", success);
        return response;
    }
}
