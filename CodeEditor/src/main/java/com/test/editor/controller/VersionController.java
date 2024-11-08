package com.test.editor.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.test.editor.service.VersionService;

@Controller
public class VersionController {

    @Autowired
    private VersionService versionService;

    @PostMapping("/restoreVersion")
    @ResponseBody
    public Map<String, Object> restoreVersion(@RequestBody Map<String, String> request) {
        String versionDate = request.get("versionDate");
        boolean success = versionService.restoreVersion(versionDate); // 인스턴스 메서드로 호출
        
        Map<String, Object> response = new HashMap<>();
        response.put("success", success);
        return response;
    }
}
