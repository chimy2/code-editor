package com.test.editor.service;

import static org.junit.Assert.assertNotNull;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.test.editor.model.BasicFileDTO;
import com.test.editor.model.VersionFileDTO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/security-context.xml", "classpath:test-context.xml" })
public class VersionFileServiceTest {

	@Autowired
	private VersionFileService versionFileService;
	
	@Test
	public void testSelectVersionFiles() {
		List<VersionFileDTO> files = versionFileService.getAllVersionFiles("6");

		System.out.println(files);
		assertNotNull(files);
	}

}
