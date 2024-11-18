<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<div class="header">
	<div class = "headerImg">
		<a href="/editor/mypage"><img src="/editor/resources/image/icon/home.svg"></a>
		<img id="member_setting_box" src="/editor/resources/image/icon/edit.svg">
	</div>
	<div class="nick">

		<!-- 로그인 하기 전 -->
		<sec:authorize access="isAnonymous()">
			Guest
		</sec:authorize>
		
		<!-- 로그인 한 후 -->
		<sec:authorize access="isAuthenticated()">
			${dto[0].nick}
		</sec:authorize>

	</div>
	<div class="header_project">
		<!-- <div class="header_project_icon"><img src="/editor/resources/image/icon/project2.svg"></div> -->
		<div class="project_name">
			
			<!-- 로그인 하기 전 -->
			<sec:authorize access="isAnonymous()">
				Test Project
			</sec:authorize>
			
			<!-- 로그인 한 후 -->
			<sec:authorize access="isAuthenticated()">
				<!-- project name으로 바꿔야함 -->
			<!-- 	스프링 프로젝트 -->
			</sec:authorize>
		
		</div>
	</div>
</div>