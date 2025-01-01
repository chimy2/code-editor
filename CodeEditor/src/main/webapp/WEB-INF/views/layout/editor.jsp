<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="tilesx" uri="http://tiles.apache.org/tags-tiles-extras"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Project 명</title>
	<tiles:insertAttribute name="asset"/>
	<tiles:insertAttribute name="asset_edtior"/>
	<!-- 로그인 한 후 -->
	<sec:authorize access="isAuthenticated()">
		<tiles:insertAttribute name="asset_chat"/>
		<tiles:insertAttribute name="asset_bot"/>
	</sec:authorize>
</head>
<body>
	<header>
		<tiles:insertAttribute name="main_header"/>
		<tiles:insertAttribute name="editor_header"/>
	</header>
	<main>
	
		<!-- 로그인 한 후 -->
		<sec:authorize access="isAuthenticated()">
			<tiles:insertAttribute name="explorer"/>
		</sec:authorize>
		<tiles:insertAttribute name="content"/>
		
		<tiles:insertAttribute name="console" />
		<tilesx:useAttribute id="list" name="popups" classname="java.util.List" />
		<c:forEach var="item" items="${list}">
			<tiles:insertAttribute value="${item}" flush="true" />
		</c:forEach>
		
		<!-- 로그인 한 후 -->
		<sec:authorize access="isAuthenticated()">
			<tiles:insertAttribute name="chat_main"/>
			<tiles:insertAttribute name="editor_bot"/>
		</sec:authorize>
	</main>
	
	<!-- 로그인 한 후 -->
	<sec:authorize access="isAuthenticated()">
		<meta name="_csrf" content="${_csrf.token}"/>
		<meta name="_csrf_header" content="${_csrf.headerName}"/>
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
		<sec:authentication property="principal.member" var="member"/>
		
		<script type="text/javascript">
		    const member = {
		    	seq: '${member.seq}'
		    	id: '${member.id}',
		    	nick: '${member.nick}'
		    };
		</script>
	</sec:authorize>
	
</body>
</html>