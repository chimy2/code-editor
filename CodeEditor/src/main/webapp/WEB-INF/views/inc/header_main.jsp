<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>  
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<div class="login_header">
	<div class="logo"><a href="/editor">Zenith</a></div>
	<div class="sign_login_header">
		<div class="login_header_box">
			<img class="user_box" src="/editor/resources/image/icon/user_white.svg">
			Sign up
		</div>
		<div class="login_header_box">
			<form method="post" action="/editor/login">
				<input type="hidden" name="id" value="test@google.com">			
				<input type="hidden" name="pw" value="a1234567!">			
				<button style="color:white;">자동 로그인: test</button>
			</form>
		</div>
		<div class="login_header_box" style="color:white;">
			<form method="post" action="/editor/login">
				<input type="hidden" name="id" value="test2@naver.com">		
				<input type="hidden" name="pw" value="1234">	
				<button style="color:white;">자동 로그인: hong</button>
			</form>
		</div>
		<div class="login_header_box">
			${member}
		</div>
	
	<!-- 로그인 하기 전 -->
	<%-- <sec:authorize access="isAnonymous()"> --%>
		<div class="login_header_box">
			<img class="main_login" src="/editor/resources/image/icon/login.svg">
			Log in
		</div>
	<%-- </sec:authorize> --%>
	<!-- 로그인 한 후 -->
	<%-- <sec:authorize access="isAuthenticated()"> --%>
		<div class="login_header_box">
			<img class="main_logout" src="/editor/resources/image/icon/logout.svg">
			Log out
		</div>
<%-- 	</sec:authorize> --%>
	</div>
</div>