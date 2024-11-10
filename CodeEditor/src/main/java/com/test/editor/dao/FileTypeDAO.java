//package com.test.editor.dao;
//
//import java.util.List;
//import java.util.Map;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.jdbc.core.JdbcTemplate;
//import org.springframework.stereotype.Repository;
//
//@Repository
//public class FileTypeDAO {
//
//	@Autowired
//	private JdbcTemplate jdbcTemplate;
//	
//	//파일 조회
//	public List<Map<String, Object>> getAllFileTypes() {
//	
//		String sql = "select * from fileType";
//		
//		return jdbcTemplate.queryForList(sql);
//	}
//}
