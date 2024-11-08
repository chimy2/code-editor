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
//@Repository
//public class BasicFileDAO {
//	
//	@Autowired
//	private JdbcTemplate jdbcTemplate;
//	
//	
//	public int createFile(String seq,String name, String code, String fileType_seq, String parent_seq) {
//		
//		String sql = "insert into basicFile (seq, name, code, fileType_seq, parent_seq) values (seqBasicFile.nextVal, ?, ?, ?, ?)";
//		
//		return jdbcTemplate.update(seq, name, code,fileType_seq, parent_seq);
//	}
//	
//	public List<Map<String, Object>> getFilesByParent(String parent_seq) {
//		
//		String sql = "select * from basicFile where parent_seq = ?";
//		
//		return jdbcTemplate.queryForList(sql, parent_seq);
//		
//	}
//	
//}
//	
//	
//	
//
