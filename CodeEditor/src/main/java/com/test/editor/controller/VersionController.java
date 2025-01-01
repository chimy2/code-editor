package com.test.editor.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.test.editor.service.VersionService;

import lombok.RequiredArgsConstructor;

/**
 * VersionController는 버전 관리와 관련된 HTTP 요청을 처리하는 컨트롤러 클래스입니다.
 * Spring의 Controller 애노테이션을 사용하여 스프링 컨테이너에 등록됩니다.
 */
@RestController
@RequiredArgsConstructor
public class VersionController {

    /**
     * VersionService는 버전 복원과 관련된 비즈니스 로직을 처리하는 서비스 클래스입니다.
     */
    private final VersionService versionService;
    
    

    /**
     * /restoreVersion 경로로 들어오는 POST 요청을 처리합니다.
     * 클라이언트로부터 JSON 형식의 요청을 받아, 해당 버전을 복원하는 작업을 수행합니다.
     * 
     * @param request 클라이언트에서 전달된 JSON 데이터를 맵으로 매핑한 객체입니다.
     * @return 성공 여부를 포함한 응답 데이터입니다.
     */
    @PostMapping("/restoreVersion")
    @ResponseBody
    public Map<String, Object> restoreVersion(@RequestBody Map<String, String> request) {
        // 클라이언트에서 전달된 versionDate 값을 추출
        String versionDate = request.get("versionDate");
        
        // VersionService를 통해 지정된 버전 복원을 수행
//        boolean success = versionService.restoreVersion(versionDate);
        
        // 결과를 담은 응답 맵 생성 및 반환
        Map<String, Object> response = new HashMap<>();
//        response.put("success", success);
        return response;
    }
}
