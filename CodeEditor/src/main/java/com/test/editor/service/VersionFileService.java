package com.test.editor.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.editor.dao.VersionFileDAO;
import com.test.editor.model.VersionFileDTO;

@Service
public class VersionFileService {

    @Autowired
    private VersionFileDAO versionFileDAO;

    public VersionFileDTO getVersionFileById(Integer seq) {
        return versionFileDAO.getVersionFileById(seq);
    }

    public List<VersionFileDTO> getAllVersionFiles() {
        return versionFileDAO.getAllVersionFiles();
    }

    public void insertVersionFile(VersionFileDTO versionFile) {
        versionFileDAO.insertVersionFile(versionFile);
    }

	public void saveVersionFile(VersionFileDTO versionFile) {
		
		versionFileDAO.insertVersionFile(versionFile);
	}
}
