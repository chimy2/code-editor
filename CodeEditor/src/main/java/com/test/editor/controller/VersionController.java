package com.test.editor.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.test.editor.service.VersionService;

@Controller
public class VersionController {

    @PostMapping("/restoreVersion")
    @ResponseBody
    public Map<String, Object> restoreVersion(@RequestBody Map<String, String> request) {
        String versionDate = request.get("versionDate");
        boolean success = VersionService.restoreVersion(versionDate);
        
        Map<String, Object> response = new HashMap<>();
        response.put("success", success);
        return response;
    }
}

