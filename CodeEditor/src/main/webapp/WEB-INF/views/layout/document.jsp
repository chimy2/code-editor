<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Document</title>
	<tiles:insertAttribute name="asset"/>
	<tiles:insertAttribute name="asset_main"/>
</head>
<body>
	<!-- main_header -->
	<tiles:insertAttribute name="header_main"/> 
	<!-- content_document -->
	<tiles:insertAttribute name="content_document"/> 
</body>
</html>