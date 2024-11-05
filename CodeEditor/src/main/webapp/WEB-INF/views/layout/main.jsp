<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Main</title>
	<tiles:insertAttribute name="asset"/>
	<tiles:insertAttribute name="asset_main"/><!-- link, script 기본 세팅 -->
</head>
<body>
	<!-- main_header -->
	<tiles:insertAttribute name="header_main"/> 
	<!-- main_content -->
	<tiles:insertAttribute name="content_main"/> 
</body>
</html>