//package com.test.editor.service;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Service;
//
//import com.test.editor.dao.BasicFileDAO;
//import com.test.editor.model.BasicFileDTO;
//
//@Service
//public class BasicFileService {
//
//    private final BasicFileDAO basicFileDAO;
//
//    @Autowired
//    public BasicFileService(BasicFileDAO basicFileDAO) {
//        this.basicFileDAO = basicFileDAO;
//    }
//
//    // 파일 생성
//    public BasicFileDTO createFile(BasicFileDTO file) {
//        basicFileDAO.createFile(file);  // 여기서 `createFile` 호출
//        return file; // 생성된 파일 정보 반환
//    }
//
//    // ID로 파일 조회
//    public BasicFileDTO getFileById(String seq) {
//        return basicFileDAO.selectFileById(seq);
//    }
//
//    // 파일 업데이트
//    public boolean updateFile(BasicFileDTO file) {
//        return basicFileDAO.updateFile(file) > 0;
//    }
//
//    // 파일 삭제
//    public boolean deleteFile(String seq) {
//        return basicFileDAO.deleteFile(seq) > 0;
//    }
//
//
//  
//}
