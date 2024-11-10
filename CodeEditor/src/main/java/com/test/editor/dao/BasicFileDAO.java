//package com.test.editor.dao;
//
//import java.util.List;
//import java.util.Map;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.jdbc.core.BeanPropertyRowMapper;
//import org.springframework.jdbc.core.JdbcTemplate;
//import org.springframework.stereotype.Repository;
//
//import com.test.editor.model.BasicFileDTO;
//
//@Repository
//public class BasicFileDAO {
//
//    @Autowired
//    private JdbcTemplate jdbcTemplate;
//
//    // 파일 생성 메서드 수정: `BasicFileDTO`를 받아 insert 수행
//    public int createFile(BasicFileDTO file) {
//        String sql = "insert into basicFile (seq, name, code, fileType_seq, parent_seq) values (seqBasicFile.nextVal, ?, ?, ?, ?)";
//        return jdbcTemplate.update(sql, file.getName(), file.getCode(), file.getFileType_seq(), file.getParent_seq());
//    }
//
//    // 파일 ID로 조회하는 메서드 추가
//    public BasicFileDTO selectFileById(String seq) {
//        String sql = "select * from basicFile where seq = ?";
//        return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(BasicFileDTO.class), seq);
//    }
//
//    // 모든 파일 조회
//    public List<BasicFileDTO> selectAllFiles() {
//        String sql = "select * from basicFile";
//        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(BasicFileDTO.class));
//    }
//
//    // 파일 업데이트 메서드 추가
//    public int updateFile(BasicFileDTO file) {
//        String sql = "UPDATE basicFile SET name = ?, code = ?, fileType_seq = ?, parent_seq = ? WHERE seq = ?";
//        return jdbcTemplate.update(sql, file.getName(), file.getCode(), file.getFileType_seq(), file.getParent_seq(), file.getSeq());
//    }
//
//    public int deleteFile(String seq) {
//        String sql = "DELETE FROM basicFile WHERE seq = ?";
//        return jdbcTemplate.update(sql, seq);
//    }
//
//    // 부모 ID로 파일 조회
//    public List<Map<String, Object>> getFilesByParent(String parent_seq) {
//        String sql = "select * from basicFile where parent_seq = ?";
//        return jdbcTemplate.queryForList(sql, parent_seq);
//    }
//}
