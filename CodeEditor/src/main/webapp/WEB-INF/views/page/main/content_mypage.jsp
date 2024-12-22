<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags"%>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<div id="content_mypage">
	<div class="calendar">
		<div class="calendar_box">
			<div class="calendar_name">November 2024</div>
			<div class="calendar_item">
				<img class="calendar_plus" src="/editor/resources/image/icon/plus.svg">
				<div class="calendar_item">일정수정</div>
				<div class="calendar_item">프로젝트 확인하기</div>
				<div class="calendar_item">보드</div>
				<div class="calendar_item">날짜</div>
			</div>
			<div class="calendar_month" id="calendar"></div>
			<div class="contact">Contact us</div>
		</div>

	</div>

	<div class="team_project">
		<div class="inner_box">
			<div class="inner_box_header">
				Team <img class="team_project_plus"	src="/editor/resources/image/icon/plus.svg">
			</div>
			<div class="inner_box_content">
				<c:forEach var="team" items="${dto[0].teamList}" varStatus="status">
					 <c:if test="${status.index == 0}"> 
				        <div class="teamBox_icon" id="userBox" onclick="getSelProject('${team.seq}')">
				            <div>
				                <img class="user_icon" src="/editor/resources/image/icon/user.svg">
				            </div>
				            ${dto[0].nick}
				            <input type="hidden" id="teamSeq" value="${team.seq}">
				        </div>
				    </c:if>
 					<c:if test="${status.index > 0}"> 
					    <div class="teamBox_icon" id="teamBox" onclick="getSelProject('${team.seq}')">
					        <div>
					            <img class="team_icon" src="/editor/resources/image/icon/team.svg">
					        </div>
					        ${team.teamName}
							<input type="hidden" id="teamSeq" value="${team.seq}">
					    </div>
				    </c:if>
				</c:forEach>
			</div>
		</div>
	</div>
	<div class="team_project">
		<div class="inner_box">
			<div class="inner_box_header">
				<!-- teamBox에서 user와 팀 선택에 따라서 동적 변경 -->
				<div class = "projectBoxHeaderIcon">
					<img class="user_icon" src="/editor/resources/image/icon/user.svg">
				</div>
				<div id="teamName">
					${dto[0].nick}
				</div> 
				<div class="total_project">전체 프로젝트 관리</div>
				<img class="team_project_plus"
					src="/editor/resources/image/icon/plus.svg">
			</div>
			<div class="inner_box_content" id="project-container">
				<!-- 동적 추가 --> 
			</div>
		</div>
	</div>
</div>


<!-- 마이페이지 -->
<form  method="POST" action="/editor/mypage">
	<div id="mypage_setting_box">
		<div id="content_memberSetting">
			<div class="header_setting">개인 설정</div>
			<div class="body_setting">
				<div class="info_setting">
					<div class="setting_nick">
						<div class="setting_user_icon"><img src="/editor/resources/image/icon/user.svg"></div>
					</div>
					<div class="setting_name_edit">
						<input type="text" class="setting_name" value="<sec:authentication property="principal.member.nick"/> ">
						<img class="setting_name_close" src="/editor/resources/image/icon/settings-close.svg">
					</div>
					<button id="logout_member_setting" class="logout_member_setting">
						<img class="main_logout" src="/editor/resources/image/icon/logout.svg">
						로그아웃
					</button>
				</div>
				<hr>
				<div class="etc_setting">
					<div class="chat_member_setting">
						<img class="setting_bot" src="/editor/resources/image/icon/bot.svg">
						마이 챗봇 통계 조회하기
					</div>
				</div>
			</div>
			<div class="button_member_setting">
				<button type="button" id="nick_edit">수정</button>
				<button type="button">취소</button>
			</div>
		</div>
	</div>
</form>


<!-- 팀 우클릭 메뉴 -->
<div class = "teamcontextBox">
	<div class ="teamContextSetting">팀 설정</div>
	<div class ="teamContextDelete">팀 삭제</div>
</div>


<!-- 팀 생성 생성-->
<div class="content_memberSetting" id="teamPlus">
	<div class="header_setting">팀 생성</div>
	<div class="body_setting">
		<div class="info_setting">
			<div class="setting_team_icon"><img src="/editor/resources/image/icon/team.svg"></div>
			<div class="setting_name_edit">
				<input type="text" class="setting_name">
				<img class="setting_name_close" src="/editor/resources/image/icon/settings-close.svg">
			</div>
		</div>
		<hr>
		<div class="etc_setting">
			<ul>
				<li><img src="/editor/resources/image/icon/plus.svg"></li>
				<li><div><img src="/editor/resources/image/icon/user.svg"></div>dog</li>			
			</ul>
		</div>
	</div>
	<div class="button_member_setting">
		<button type="button">생성</button>
		<button type="button">취소</button>
	</div>
</div>


<!-- 팀 설정 편집-->
<div class="content_memberSetting" id="teamSetting">
	<div class="header_setting">팀 설정</div>
	<div class="body_setting">
		<div class="info_setting">
			<div class="setting_team_icon"><img src="/editor/resources/image/icon/team.svg"></div>
			<div class="setting_name_edit">
				<input type="text" class="setting_name" value="ssangyoung">
				<img class="setting_name_close" src="/editor/resources/image/icon/settings-close.svg">
			</div>
		</div>
		<hr>
		<div class="etc_setting">
			<ul>
				<li><img src="/editor/resources/image/icon/plus.svg"></li>
				<li><div><img src="/editor/resources/image/icon/user.svg"></div>dog</li>
				<li><div><img src="/editor/resources/image/icon/user.svg"></div>cat<img class="setting_team_delete" src="/editor/resources/image/icon/settings-close.svg"></li>				
			</ul>
		</div>
	</div>
	<div class="button_member_setting">
		<button type="button">수정</button>
		<button type="button">취소</button>
	</div>
</div>

<!-- 팀삭제 logout과 동일하게 생성 -->
<div id="team_delete">
	<div class="content_team_delete">
		<div class="team_delete">
			
			<div class="team_delete_text">
				<div>팀 삭제</div>
				<div>팀을 삭제 하시겠습니까?</div>
			</div>
			
			<div class="team_delete_button"> 
				<button type="submit">예</button>
				<button type="button">아니오</button>
			</div>
			
		</div>
	</div>
</div>

<!-- 프로젝트 우클릭 메뉴 -->
<div class = "projectcontextBox">
	<div class ="projectContextSetting">프로젝트 설정</div>
	<div class ="projectContextDelete">프로젝트 삭제</div>
</div>

<!-- 프로젝트 추가 -->
<div class="content_memberSetting" id="projectPlus">
	<div class="header_setting">프로젝트 생성</div>
	<div class="body_setting">
		<div class="info_project_setting">
			<div class="setting_project_icon"><img src="/editor/resources/image/icon/project.svg"></div>
			<div class="setting_name_edit">
				<input type="text" class="setting_name">
				<img class="setting_name_close" src="/editor/resources/image/icon/settings-close.svg">
			</div>
			<div class="setting_project_explain_edit">
				<textarea></textarea>
				<img class="setting_name_close" src="/editor/resources/image/icon/settings-close.svg">
			</div>
		</div>
		<hr>
		<div class="project_etc_setting">
			<ul>
				<li>
					<div>Member</div>
					<ul class="project_member">
						<li>+</li>
						<li>dog</li>
					</ul>
				</li>				
				<li class="Project_Date">
					<div>Project Date</div>
					<input type="date"> ~ <input type="date">
				</li>				
				<li class="Registration_Date">
					<div>Registration Date</div>
					<input type="date">
				</li>				
				<li>
					<div>Priority</div>
					<ul class="priority_color">
						<li>High</li>
						<li>Medium</li>
						<li>Low</li>
					</ul>
				</li>								
			</ul>
		</div>
	</div>
	<div class="button_member_setting">
		<button type="button">생성</button>
		<button type="button">취소</button>
	</div>
</div>



<!-- 프로젝트 설정 -->
<div class="content_memberSetting" id="projectSetting">
	<div class="header_setting">프로젝트 설정</div>
	<div class="body_setting">
		<div class="info_project_setting">
			<div class="setting_project_icon"><img src="/editor/resources/image/icon/project.svg"></div>
			<div class="setting_name_edit">
				<input type="text" class="setting_name" value="spring project">
				<img class="setting_name_close" src="/editor/resources/image/icon/settings-close.svg">
			</div>
			<div class="setting_project_explain_edit">
				<textarea>스프링 프로젝트입니다.</textarea>
				<img class="setting_name_close" src="/editor/resources/image/icon/settings-close.svg">
			</div>
		</div>
		<hr>
		<div class="project_etc_setting">
			<ul>
				<li>
					<div>Member</div>
					<ul class="project_member">
						<li>+</li>
						<li>dog <img class="setting_name_close" src="/editor/resources/image/icon/settings-close.svg"></li>
						<li>cat <img class="setting_name_close" src="/editor/resources/image/icon/settings-close.svg"></li>
					</ul>
				</li>				
				<li class="Project_Date">
					<div>Project Date</div>
					<input type="date"> ~ <input type="date">
				</li>				
				<li class="Registration_Date">
					<div>Registration Date</div>
					<input type="date">
				</li>		
				<li>
					<div>Priority</div>
					<ul class="priority_color">
						<li>High</li>
						<li>Medium</li>
						<li>Low</li>
					</ul>
				</li>								
			</ul>
		</div>
	</div>
	<div class="button_member_setting">
		<button type="button">수정</button>
		<button type="button">취소</button>
	</div>
</div>

<!-- 프로젝트 삭제 logout과 동일하게 생성 -->
<div id="project_delete">
	<div class="content_project_delete">
		<div class="project_delete">
			
			<div class="project_delete_text">
				<div>프로젝트 삭제</div>
				<div>프로젝트를 삭제 하시겠습니까?</div>
			</div>
			
			<div class="project_delete_button"> 
				<button type="submit">예</button>
				<button type="button">아니오</button>
			</div>
			
		</div>
	</div>
</div>
<input type="hidden" id="mypageMemberSeq" value ="${sessionScope.member.seq}"> 









