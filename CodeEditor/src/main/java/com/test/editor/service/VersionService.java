package com.test.editor.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.test.editor.dao.VersionRepository;
import com.test.editor.model.VersionInfoDTO;

@Service
public class VersionService {

    @Autowired
    private VersionRepository versionRepository;

    public boolean restoreVersion(String versionDate) {
        VersionInfoDTO versionInfo = versionRepository.findByDate(versionDate);
        if (versionInfo != null) {
            // 파일 데이터 복원 로직
            return true;
        }
        return false;
    }

    public List<VersionInfoDTO> getAllVersionInfos() {
        List<VersionInfoDTO> versionInfos = new ArrayList<>();
        try {
            versionInfos = versionRepository.findAll();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return versionInfos;
    }
}


