package com.test.editor.service;

import org.springframework.stereotype.Service;

import com.test.editor.dao.BasicFileDAO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BasicFileService {

    private final BasicFileDAO dao;
  
}
