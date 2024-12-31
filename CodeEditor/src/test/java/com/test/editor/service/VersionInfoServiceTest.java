package com.test.editor.service;

import static org.junit.Assert.assertEquals;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/security-context.xml", "classpath:test-context.xml" })
public class VersionInfoServiceTest {

	@Autowired
	private VersionInfoService versionInfoService;
	
	@Test
	public void testGetLastVersionSeq() {
		int result = versionInfoService.getLastVersionSeq("1");
		
		assertEquals(1, result);
	}

}
