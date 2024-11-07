<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>content_projectSetting</title>
	<tiles:insertAttribute name="asset"/>
	<tiles:insertAttribute name="asset_main"/>
</head>
<body>
	<div class="content_memberSetting">
		<div class="header_setting">프로젝트 설정</div>
		<div class="body_setting">
			<div class="info_project_setting">
				<div class="setting_project_icon"><img src="/editor/resources/image/icon/project.svg"></div>
				<div class="setting_nick">
					<input type="text" class="setting_name" value="spring project">
					<img class="setting_name_close" src="/editor/resources/image/icon/settings-close.svg">
					<textarea class="setting_project_explain">스프링 프로젝트입니다.</textarea>
				</div>
			</div>
			<hr>
			<div class="project_etc_setting">
				<ul>
					<li>
						<div>Member</div>
						<ul>
							<li>+</li>
							<li>test</li>
							<li>hong</li>
						</ul>
					</li>				
					<li><div>Project Date</div></li>				
					<li><div>Registration Date</div></li>				
					<li>
						<div>Priority</div>
						<ul>
							<li>High</li>
							<li>Medium</li>
							<li>Low</li>
						</ul>
					</li>								
				</ul>
			</div>
		</div>
		<div class="button_member_setting">
			<button type="button">수정</button>
			<button type="button">취소</button>
		</div>
	</div>
</body>
</html>