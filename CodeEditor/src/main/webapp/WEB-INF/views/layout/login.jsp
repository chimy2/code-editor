<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %> 
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
	<tiles:insertAttribute name="asset"/>
	<tiles:insertAttribute name="asset_main"/><!-- link, script 기본 세팅 -->
</head>
<body>
	<!-- main_header -->
	<tiles:insertAttribute name="header_main"/> 
	<sec:authorize access="isAnonymous()">
		<tiles:insertAttribute name="content_login"/> 
	</sec:authorize>
	<!-- 로그인 한 후 -->
	<sec:authorize access="isAuthenticated()">
		<tiles:insertAttribute name="content_logout"/> 
	</sec:authorize>
</body>
</html>