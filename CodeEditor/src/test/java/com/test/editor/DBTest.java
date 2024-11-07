package com.test.editor;

import static org.junit.Assert.assertNotNull;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.test.editor.mapper.EditorMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
		"file:src/main/webapp/WEB-INF/spring/root-context.xml", 
		"file:src/main/webapp/WEB-INF/spring/security-context.xml"
	})
public class DBTest {
	
	@Autowired
	private EditorMapper mapper;
	
	@Autowired
	private DataSource dataSource;
	
	@Autowired
	private PasswordEncoder passwordEncoder;

	@Test
	public void testNotNull() {
		
		assertNotNull(dataSource);
		assertNotNull(passwordEncoder);
		
	}
	
	/*
	@Test
	public void testEncrypt() {
		String pw1 = "a1234567!";
		System.out.println("결과>>>>"+passwordEncoder.encode(pw1));
		//
		String pw2 = "a1234567!";
		System.out.println("결과>>>>"+passwordEncoder.encode(pw2));

	}
	*/
	
	/*
	@Test
	public void testDB() {
		assertNotNull(mapper);
	}
	*/
	/*
	@Test
	public void insertMember() {
		
		String sql = "insert into member (seq, id, pw, nick, regdate, ing, color, oAuthType) values (seqMember.nextVal,?,?,?,default,default,default,default)";
		
		try {
			Connection conn = dataSource.getConnection();
			PreparedStatement stat = conn.prepareStatement(sql);
			
			stat.setString(1, "dog@naver.com");
			stat.setString(2, passwordEncoder.encode("a1234567!"));
			stat.setString(3, "dog");
			stat.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	*/
	/*
	@Test
	public void updateMember() {
		
		String sql = "UPDATE member SET pw = ? WHERE seq = 21";
		
		try {
			Connection conn = dataSource.getConnection();
			PreparedStatement stat = conn.prepareStatement(sql);
			
			stat.setString(1, passwordEncoder.encode("a1234567!"));
			stat.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	*/
	
	
}
