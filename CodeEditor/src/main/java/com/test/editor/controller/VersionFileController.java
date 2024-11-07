package com.test.editor.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.test.editor.model.VersionFileDTO;
import com.test.editor.model.VersionInfoDTO;
import com.test.editor.service.VersionFileService;
import com.test.editor.service.VersionService;

@Controller
@RequestMapping("/versionFile")
public class VersionFileController {

    @Autowired
    private VersionFileService versionFileService;

    @Autowired
    private VersionService versionService;

    // 버전 파일 생성
    @PostMapping("/create")
    public String createVersionFile(@ModelAttribute VersionFileDTO versionFile, Model model) {
        versionFileService.insertVersionFile(versionFile);
        List<VersionFileDTO> versionFiles = versionFileService.getAllVersionFiles();
        model.addAttribute("versionFiles", versionFiles);
        return "version"; 
    }

    // 파일 업로드
    @PostMapping("/upload")
    public String uploadFile(@ModelAttribute VersionFileDTO versionFile, Model model) {
        versionFileService.saveVersionFile(versionFile);
        List<VersionFileDTO> versionFiles = versionFileService.getAllVersionFiles();
        model.addAttribute("versionFiles", versionFiles);
        return "version"; 
    }

    // 버전 파일 목록 조회
    @GetMapping("/list")
    public String listVersionFiles(Model model) {
        List<VersionFileDTO> versionFiles = versionFileService.getAllVersionFiles();
        model.addAttribute("versionFiles", versionFiles);
        return "version"; 
    }

    // 버전 정보 조회
    @GetMapping("/versions")
    public String getVersionInfo(Model model) {
        List<VersionInfoDTO> versionInfos = null;
        try {
            versionInfos = versionService.getAllVersionInfos();
        } catch (Exception e) {
            e.printStackTrace();
        }
        model.addAttribute("versionInfos", versionInfos);
        return "version";
    }
}
