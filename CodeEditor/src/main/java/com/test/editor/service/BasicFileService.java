package com.test.editor.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.test.editor.dao.BasicFileDAO;
import com.test.editor.model.BasicFileDTO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BasicFileService {

    private final BasicFileDAO dao;
  
    public List<BasicFileDTO> getAllFiles() {
    	return dao.getAllFiles();
    }
}
