//package com.test.editor.controller;
//
//import java.util.List;
//import java.util.Map;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.http.ResponseEntity;
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.ResponseBody;
//
//import com.test.editor.service.FileTypeService;
//
//@Controller
//@RequestMapping("/api/filetypes")
//public class FileTypeController {
//
//    @Autowired
//    private FileTypeService fileTypeService;
//
//    // 전체 파일 유형 조회 메서드
//    @GetMapping
//    @ResponseBody // REST 응답을 위해 추가
//    public ResponseEntity<List<Map<String, Object>>> getAllFileTypes() {
//        List<Map<String, Object>> fileTypes = fileTypeService.getAllFileTypes();
//        return ResponseEntity.ok(fileTypes);
//    }
//}
