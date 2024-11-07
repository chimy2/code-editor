<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>content_teamSetting</title>
	<tiles:insertAttribute name="asset"/>
	<tiles:insertAttribute name="asset_main"/>
</head>
<body>
	<div class="content_memberSetting">
		<div class="header_setting">팀 설정</div>
		<div class="body_setting">
			<div class="info_setting">
				<div class="setting_team_icon"><img src="/editor/resources/image/icon/team.svg"></div>
				<div class="setting_name_edit">
					<input type="text" class="setting_name" value="ssangyoung">
					<img class="setting_name_close" src="/editor/resources/image/icon/settings-close.svg">
				</div>
			</div>
			<hr>
			<div class="etc_setting">
				<ul>
					<li><img src="/editor/resources/image/icon/plus.svg"></li>
					<li><div><img src="/editor/resources/image/icon/user.svg"></div>hong</li>
					<li><div><img src="/editor/resources/image/icon/user.svg"></div>annie<img class="setting_team_delete" src="/editor/resources/image/icon/settings-close.svg"></li>				
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