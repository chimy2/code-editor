<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyPage</title>
	
	<tiles:insertAttribute name="asset"></tiles:insertAttribute><!-- link, script 기본 세팅 -->
	<tiles:insertAttribute name="asset_main"></tiles:insertAttribute><!-- link, script 메인 세팅 -->
</head>
<body class="mypage">
	<header>
		<tiles:insertAttribute name="header_main"></tiles:insertAttribute> 
	</header>

	<tiles:insertAttribute name="content_mypage"></tiles:insertAttribute> 
</body>
</html>