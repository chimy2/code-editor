package com.test.editor.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.test.editor.dao.VersionRepository;
import com.test.editor.model.VersionInfoDTO;

@Service
public class VersionService {

    @Autowired
    private VersionRepository versionRepository;

    public boolean restoreVersion(String versionDate) {
        // 특정 버전을 조회하고 파일 내용을 복원하는 로직 구현
        VersionInfoDTO versionInfo = versionRepository.findByDate(versionDate);
        if (versionInfo != null) {
            // 파일 데이터 복원
            return true;
        }
        return false;
    }

    public List<VersionInfoDTO> getAllVersionInfos() {
        List<VersionInfoDTO> versionInfos = new ArrayList<>();
        try {
            versionInfos = versionRepository.findAll(); // 모든 버전 정보 가져오기
        } catch (Exception e) {
            e.printStackTrace();
        }
        return versionInfos;
    }

    @GetMapping("/versions")
    public String getVersionInfo(Model model) {
        List<VersionInfoDTO> versionInfos = getAllVersionInfos(); // 인스턴스를 통해 호출하지 않고 직접 호출
        model.addAttribute("versionInfos", versionInfos);
        return "version";
    }
}
