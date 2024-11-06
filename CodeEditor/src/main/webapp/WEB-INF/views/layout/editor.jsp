<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="tilesx" uri="http://tiles.apache.org/tags-tiles-extras"%>
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
		<tiles:insertAttribute name="console" />
		<tilesx:useAttribute id="list" name="popups" classname="java.util.List" />
		<c:forEach var="item" items="${list}">
			<tiles:insertAttribute value="${item}" flush="true" />
		</c:forEach>
		<tiles:insertAttribute name="right_side"/>
		
		<tiles:insertAttribute name="chat_main"/>
		
	</main>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js" ></script>
	<script>
		
	</script>
</body>
</html>