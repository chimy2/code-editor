//package com.test.editor.controller;
//
//import com.test.editor.model.BasicFileDTO;
//import com.test.editor.service.BasicFileService;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.http.HttpStatus;
//import org.springframework.http.ResponseEntity;
//import org.springframework.web.bind.annotation.*;
//
//@RestController
//@RequestMapping("/api/files")
//public class BasicFileController {
//
//    private final BasicFileService basicFileService;
//
//    @Autowired
//    public BasicFileController(BasicFileService basicFileService) {
//        this.basicFileService = basicFileService;
//    }
//
//    // 새로운 파일 생성
//    @PostMapping
//    public ResponseEntity<BasicFileDTO> createFile(@RequestBody BasicFileDTO file) {
//        BasicFileDTO createdFile = basicFileService.createFile(file);
//        return new ResponseEntity<>(createdFile, HttpStatus.CREATED);
//    }
//
//    // ID로 특정 파일 조회
//    @GetMapping("/{seq}")
//    public ResponseEntity<BasicFileDTO> getFileById(@PathVariable String seq) {
//        BasicFileDTO file = basicFileService.getFileById(seq);
//        return file != null ? ResponseEntity.ok(file) : ResponseEntity.notFound().build();
//    }
//
//    // 파일 정보 수정
//    @PutMapping("/{seq}")
//    public ResponseEntity<BasicFileDTO> updateFile(@PathVariable String seq, @RequestBody BasicFileDTO updatedFile) {
//        updatedFile.setSeq(seq);  // 업데이트할 파일의 ID 설정
//        boolean updated = basicFileService.updateFile(updatedFile);
//        return updated ? ResponseEntity.ok(updatedFile) : ResponseEntity.notFound().build();
//    }
//
//    // 파일 삭제
//    @DeleteMapping("/{seq}")
//    public ResponseEntity<Void> deleteFile(@PathVariable String seq) {
//        boolean deleted = basicFileService.deleteFile(seq);
//        return deleted ? ResponseEntity.noContent().build() : ResponseEntity.notFound().build();
//    }
//}
