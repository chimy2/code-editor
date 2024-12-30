package com.test.editor;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.List;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.test.editor.dao.MemberDAO;
import com.test.editor.mapper.EditorMapper;
import com.test.editor.mapper.TeamMapper;
import com.test.editor.model.MemberDTO;
import com.test.editor.model.TeamDTO;
import com.test.editor.model.VersionFileDTO;
import com.test.editor.service.MemberService;
import com.test.editor.service.ProjectService;
import com.test.editor.service.TeamService;
import com.test.editor.service.VersionFileService;
import com.test.editor.service.VersionInfoService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/security-context.xml", "classpath:test-context.xml" })
public class DBTest {

	@Autowired
	private EditorMapper mapper;

	@Autowired
	private DataSource dataSource;

	@Autowired
	private PasswordEncoder passwordEncoder;

	@Autowired
	private TeamService teamService;

	@Autowired
	private MemberDAO memberDAO;


	@Test
	public void test() {

		assertTrue(true);
	}

	@Test
	public void insertTeam() {

		MemberDTO member = memberDAO.get("5");

		if (member != null) {
			TeamDTO team = new TeamDTO();

			team.setTeamName("팀이름");
			team.setTeamEx("팀설명입니다.");
			team.setTeamType("1");

			teamService.insert(member, team);

			System.out.println(team);
			System.out.println("시퀀스값은 " + team.getSeq());
		}

		assertTrue(true);
	}

	/*
	 * @Test public void testNotNull() {
	 * 
	 * assertNotNull(dataSource); assertNotNull(passwordEncoder);
	 * 
	 * }
	 */
	/*
	 * @Test public void testEncrypt() { String pw1 = "a1234567!";
	 * System.out.println("결과>>>>"+passwordEncoder.encode(pw1)); // String pw2 =
	 * "a1234567!"; System.out.println("결과>>>>"+passwordEncoder.encode(pw2));
	 * 
	 * }
	 */

	/*
	 * @Test public void testDB() { assertNotNull(mapper); }
	 */
	/*
	 * @Test public void insertMember() {
	 * 
	 * String sql =
	 * "insert into member (seq, id, pw, nick, regdate, ing, color, oAuthType) values (seqMember.nextVal,?,?,?,default,default,default,default)"
	 * ;
	 * 
	 * try { Connection conn = dataSource.getConnection(); PreparedStatement stat =
	 * conn.prepareStatement(sql);
	 * 
	 * stat.setString(1, "dog@naver.com"); stat.setString(2,
	 * passwordEncoder.encode("a1234567!")); stat.setString(3, "dog");
	 * stat.executeUpdate();
	 * 
	 * } catch (Exception e) { e.printStackTrace(); }
	 * 
	 * }
	 */
	/*
	 * @Test public void updateMember() {
	 * 
	 * String sql = "UPDATE member SET pw = ? WHERE seq = 21";
	 * 
	 * try { Connection conn = dataSource.getConnection(); PreparedStatement stat =
	 * conn.prepareStatement(sql);
	 * 
	 * stat.setString(1, passwordEncoder.encode("a1234567!")); stat.executeUpdate();
	 * 
	 * } catch (Exception e) { e.printStackTrace(); }
	 * 
	 * }
	 */

}
