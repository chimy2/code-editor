package com.test.editor.dao;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.editor.mapper.VersionFileMapper;
import com.test.editor.model.VersionFileDTO;

@Repository
public class VersionFileDAO {

    @Autowired
    private VersionFileMapper versionFileMapper;

    public VersionFileDTO getVersionFileById(Integer seq) {
        // 추가 로직이 필요한 경우 작성
        return versionFileMapper.getVersionFileById(seq);
    }

    public List<VersionFileDTO> getAllVersionFiles() {
        // 추가 로직이 필요한 경우 작성
        return versionFileMapper.getAllVersionFiles();
    }

    public void insertVersionFile(VersionFileDTO versionFile) {
        // 추가 로직이 필요한 경우 작성
        versionFileMapper.insertVersionFile(versionFile);
    }
}
