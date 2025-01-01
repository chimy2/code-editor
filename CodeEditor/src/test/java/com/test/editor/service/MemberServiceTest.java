package com.test.editor.service;

import static org.junit.Assert.assertEquals;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.test.editor.model.MemberDTO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/security-context.xml", "classpath:test-context.xml" })
public class MemberServiceTest {

	@Autowired
	private MemberService memberService;

	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Test
	public void testCreateAutoLoginUser() {
		int result = 0;
		
		result += memberService.join(getTestMember());
		result += memberService.join(getTestMember2());
		result += memberService.join(getTestMember3());
		
		assertEquals(3, result);
	}
	
	@Test
	public void testJoin() {
		MemberDTO member = getTestMember();
		
		int result = memberService.join(member);
		
		assertEquals(1, result);
	}
	
	private MemberDTO getTestMember() {
		MemberDTO member = MemberDTO.builder()
				.id("test@test.com")
				.pw(passwordEncoder.encode("1234"))
				.nick("test")
				.build();
		
		return member;
	}
	
	private MemberDTO getTestMember2() {
		MemberDTO member = MemberDTO.builder()
				.id("test2@test.com")
				.pw(passwordEncoder.encode("1234"))
				.nick("test2")
				.build();
		
		return member;
	}
	
	private MemberDTO getTestMember3() {
		MemberDTO member = MemberDTO.builder()
				.id("test3@test.com")
				.pw(passwordEncoder.encode("1234"))
				.nick("test3")
				.build();
		
		return member;
	}
}
