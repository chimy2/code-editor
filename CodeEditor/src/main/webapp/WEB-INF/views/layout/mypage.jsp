<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyPage</title>
	<tiles:insertAttribute name="asset_main"></tiles:insertAttribute><!-- link, script 기본 세팅 -->
</head>
<body class="mypage">
	<!-- mypage_header -->
	<tiles:insertAttribute name="header_main"></tiles:insertAttribute> 
	<!-- mypage_content -->
	<tiles:insertAttribute name="content_mypage"></tiles:insertAttribute> 
</body>
</html>