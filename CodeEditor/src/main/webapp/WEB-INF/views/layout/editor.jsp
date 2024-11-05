<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Project 명</title>
	<tiles:insertAttribute name="asset"/>
	<tiles:insertAttribute name="asset_edtior"/>
	<tiles:insertAttribute name="asset_chat"/>
	<tiles:insertAttribute name="asset_bot"/>
</head>
<body>
	<header>
		<tiles:insertAttribute name="main_header"/>
		<tiles:insertAttribute name="editor_header"/>
	</header>
	<main>
		<tiles:insertAttribute name="left_side"/>
		<tiles:insertAttribute name="content"/>
		<tiles:insertAttribute name="settings"/>
		<tiles:insertAttribute name="right_side"/>
	</main>
</body>
</html>