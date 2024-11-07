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
import com.test.editor.service.VersionFileService;

@Controller
@RequestMapping("/versionFile")
public class VersionFileController {

    @Autowired
    private VersionFileService versionFileService;

    // 버전 파일 생성
    @PostMapping("/create")
    public String createVersionFile(@ModelAttribute VersionFileDTO versionFile, Model model) {
        versionFileService.insertVersionFile(versionFile);
        // 생성 후 목록을 다시 가져와서 version.jsp로 전달
        List<VersionFileDTO> versionFiles = versionFileService.getAllVersionFiles();
        model.addAttribute("versionFiles", versionFiles);
        return "version"; // version.jsp로 이동
    }

    // 파일 업로드
    @PostMapping("/upload")
    public String uploadFile(@ModelAttribute VersionFileDTO versionFile, Model model) {
        versionFileService.saveVersionFile(versionFile);
        // 업로드 후 목록을 다시 가져와서 version.jsp로 전달
        List<VersionFileDTO> versionFiles = versionFileService.getAllVersionFiles();
        model.addAttribute("versionFiles", versionFiles);
        return "version"; // version.jsp로 이동
    }

    // 버전 파일 목록 조회
    @GetMapping("/list")
    public String listVersionFiles(Model model) {
        List<VersionFileDTO> versionFiles = versionFileService.getAllVersionFiles();
        model.addAttribute("versionFiles", versionFiles);
        return "version"; // version.jsp로 이동
    }
}
