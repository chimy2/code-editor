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
				Team <img class="team_project_plus"
					src="/editor/resources/image/icon/plus.svg">
			</div>
			<div class="inner_box_content">
				<c:forEach var="team" items="${dto[0].teamList}" varStatus="status">
					 <c:if test="${status.index == 0}"> 
				        <div class="teamBox_icon">
				            <div>
				                <img class="user_icon" src="/editor/resources/image/icon/user.svg">
				            </div>
				            ${team.teamName}
				        </div>
				    </c:if>
 					<c:if test="${status.index > 0}"> 
					    <div class="teamBox_icon">
					        <div>
					            <img class="team_icon" src="/editor/resources/image/icon/team.svg">
					        </div>
					        ${team.teamName}
					    </div>
				    </c:if>
				</c:forEach>
			</div>
		</div>
	</div>
	<div class="team_project">
		<div class="inner_box">
			<div class="inner_box_header">
				<div>
					<img class="team_icon" src="/editor/resources/image/icon/team.svg">
				</div>
				ssangyoung
				<div class="total_project">전체 프로젝트 관리</div>
				<img class="team_project_plus"
					src="/editor/resources/image/icon/plus.svg">
			</div>
			<div class="inner_box_content">
				<button class="projectBox_icon" onclick="location.href='/editor/code/1';">
					<div>
						<img class="project2_icon"
							src="/editor/resources/image/icon/project2.svg">
					</div>
					Spring project
				</button>
				<div class="projectBox_icon">
					<div>
						<img class="project2_icon"
							src="/editor/resources/image/icon/project2.svg">
					</div>
					Spring project
				</div>
				<div class="projectBox_icon">
					<div>
						<img class="project2_icon"
							src="/editor/resources/image/icon/project2.svg">
					</div>
					Spring project
				</div>
				<div class="projectBox_icon">
					<div>
						<img class="project2_icon"
							src="/editor/resources/image/icon/project2.svg">
					</div>
					Spring project
				</div>
				<div class="projectBox_icon">
					<div>
						<img class="project2_icon"
							src="/editor/resources/image/icon/project2.svg">
					</div>
					Spring project
				</div>
				<div class="projectBox_icon">
					<div>
						<img class="project2_icon"
							src="/editor/resources/image/icon/project2.svg">
					</div>
					Spring project
				</div>
				<div class="projectBox_icon">
					<div>
						<img class="project2_icon"
							src="/editor/resources/image/icon/project2.svg">
					</div>
					Spring project
				</div>
				<div class="projectBox_icon">
					<div>
						<img class="project2_icon"
							src="/editor/resources/image/icon/project2.svg">
					</div>
					Spring project
				</div>
				<div class="projectBox_icon">
					<div>
						<img class="project2_icon"
							src="/editor/resources/image/icon/project2.svg">
					</div>
					Spring project
				</div>
				<div class="projectBox_icon">
					<div>
						<img class="project2_icon"
							src="/editor/resources/image/icon/project2.svg">
					</div>
					Spring project
				</div>


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
					<button class="logout_member_setting">
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



<%-- <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
<sec:authentication property="principal.member.seq"/>
<div><sec:authentication property="principal.member"/></div>
<input type="hidden" value="<sec:authentication property="principal.member"/>"> --%>
<%-- <input type="hidden" value ="${sessionScope.member}">  --%>
<input type="hidden" value ="${sessionScope.member.seq}"> 
