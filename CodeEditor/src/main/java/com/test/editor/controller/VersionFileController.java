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
import com.test.editor.service.VersionInfoService;

/**
 * VersionFileController는 버전 파일과 관련된 HTTP 요청을 처리하는 컨트롤러 클래스입니다.
 *
 */
@Controller
@RequestMapping("/versionFile")
public class VersionFileController {

    /**
     * VersionFileService는 버전 파일과 관련된 비즈니스 로직을 처리합니다.
     * @Autowired: Spring 컨테이너에서 VersionFileService 객체를 자동으로 주입합니다.
     */
    @Autowired
    private VersionFileService versionFileService;

    /**
     * VersionService는 버전 정보와 관련된 비즈니스 로직을 처리합니다.
     * @Autowired: Spring 컨테이너에서 VersionService 객체를 자동으로 주입합니다.
     */
    @Autowired
    private VersionInfoService versionService;

    /**
     * 버전 파일 생성 요청을 처리합니다.
     * 
     * @param versionFile 클라이언트가 전송한 버전 파일 정보를 담고 있는 객체
     * @param model 뷰에 데이터를 전달하기 위한 Spring MVC의 Model 객체
     * @return "version" 뷰 이름
     * 
     * PostMapping("/create"): /versionFile/create 경로로 들어오는 POST 요청을 처리합니다.
     * ModelAttribute: 클라이언트에서 전송된 데이터를 VersionFileDTO 객체로 바인딩합니다.
     */
    @PostMapping("/create")
    public String createVersionFile(@ModelAttribute VersionFileDTO versionFile, Model model) {
        // 새로운 버전 파일을 생성
        versionFileService.insertVersionFile(versionFile);
        // 모든 버전 파일 목록을 가져와 모델에 추가
        List<VersionFileDTO> versionFiles = versionFileService.getAllVersionFiles();
        model.addAttribute("versionFiles", versionFiles);
        return "version"; // version 뷰를 반환
    }

    /**
     * 파일 업로드 요청을 처리합니다.
     * 
     * @param versionFile 클라이언트가 업로드한 파일 정보를 담고 있는 객체
     * @param model 뷰에 데이터를 전달하기 위한 Spring MVC의 Model 객체
     * @return "version" 뷰 이름
     * 
     * PostMapping("/upload"): /versionFile/upload 경로로 들어오는 POST 요청을 처리합니다.
     * ModelAttribute: 클라이언트에서 전송된 데이터를 VersionFileDTO 객체로 바인딩합니다.
     */
    @PostMapping("/upload")
    public String uploadFile(@ModelAttribute VersionFileDTO versionFile, Model model) {
        // 업로드된 파일 저장
        versionFileService.saveVersionFile(versionFile);
        // 모든 버전 파일 목록을 가져와 모델에 추가
        List<VersionFileDTO> versionFiles = versionFileService.getAllVersionFiles();
        model.addAttribute("versionFiles", versionFiles);
        return "version"; // version 뷰를 반환
    }

    /**
     * 버전 파일 목록 조회 요청을 처리합니다.
     * 
     * @param model 뷰에 데이터를 전달하기 위한 Spring MVC의 Model 객체
     * @return "version" 뷰 이름
     * 
     * GetMapping("/list"): /versionFile/list 경로로 들어오는 GET 요청을 처리합니다.
     */
    @GetMapping("/list")
    public String listVersionFiles(Model model) {
        // 모든 버전 파일 목록을 가져와 모델에 추가
        List<VersionFileDTO> versionFiles = versionFileService.getAllVersionFiles();
        model.addAttribute("versionFiles", versionFiles);
        return "version"; // version 뷰를 반환
    }

    /**
     * 버전 정보 조회 요청을 처리합니다.
     * 
     * @param model 뷰에 데이터를 전달하기 위한 Spring MVC의 Model 객체
     * @return "version" 뷰 이름
     * 
     * GetMapping("/versions"): /versionFile/versions 경로로 들어오는 GET 요청을 처리합니다.
     */
    @GetMapping("/versions")
    public String getVersionInfo(Model model) {
        List<VersionInfoDTO> versionInfos = null;
        try {
            // 모든 버전 정보를 가져옴
            versionInfos = versionService.getAllVersionInfos();
        } catch (Exception e) {
            e.printStackTrace(); // 예외 처리
        }
        model.addAttribute("versionInfos", versionInfos); // 뷰에 버전 정보 추가
        return "version"; // version 뷰를 반환
    }
}
