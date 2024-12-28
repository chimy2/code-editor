package com.test.editor.service;

import static org.junit.Assert.assertNotNull;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.test.editor.model.BasicFileDTO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/security-context.xml", "classpath:test-context.xml" })
public class BasicFileServiceTest {

	@Autowired
	private BasicFileService basicFileService;
	
	@Test
	public void testGetAllFiles() {
		List<BasicFileDTO> basicFiles = basicFileService.getAllFiles();
		
		System.out.println(basicFiles);
		
		assertNotNull(basicFiles);
	}
}
