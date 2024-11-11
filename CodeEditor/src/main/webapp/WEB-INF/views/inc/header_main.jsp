<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>  
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<div class="login_header">
	<div class="logo"><a href="/editor">Zenith</a></div>
	<div class="sign_login_header">
		<div class="login_header_box" id="sign_up">
			<img class="user_box" src="/editor/resources/image/icon/user_white.svg">
			Sign up
		</div>	
	<!-- 로그인 하기 전 -->
	<sec:authorize access="isAnonymous()">
		<div class="login_header_box" id="log_in">
			<img class="main_login" src="/editor/resources/image/icon/login.svg">
			Log in
		</div>
	</sec:authorize>
	<!-- 로그인 한 후 -->
	<sec:authorize access="isAuthenticated()">
		<div class="login_header_box" id="log_out">
			<img class="main_logout" src="/editor/resources/image/icon/logout.svg">
			Log out
		</div>
	</sec:authorize>
	</div>
</div>