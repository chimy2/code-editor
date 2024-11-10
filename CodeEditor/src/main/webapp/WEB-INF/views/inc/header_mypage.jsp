<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<div class="header">
	<div class = "headerImg">
		<a href="/editor/mypage"><img src="/editor/resources/image/icon/home.svg"></a>
		<img id="member_setting_box" src="/editor/resources/image/icon/edit.svg">
	</div>
	<div class="nick">
		${dto[0].nick}
	</div>
	<div class="header_project">
		<div class="header_project_icon"><img src="/editor/resources/image/icon/project2.svg"></div>
		<div class="project_name">Spring project</div>
	</div>
</div>