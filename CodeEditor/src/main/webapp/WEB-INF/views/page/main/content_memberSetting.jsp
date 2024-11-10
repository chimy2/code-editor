<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>content_memberSetting</title>
	<tiles:insertAttribute name="asset"/>
	<tiles:insertAttribute name="asset_main"/>
</head>
<body>
	<div id="content_memberSetting">
		<div class="header_setting">개인 설정</div>
		<div class="body_setting">
			<div class="info_setting">
				<div class="setting_nick">
					<div class="setting_user_icon"><img src="/editor/resources/image/icon/user.svg"></div>
				</div>
				<div class="setting_name_edit">
					<input type="text" class="setting_name" value="test">
					<img class="setting_name_close" src="/editor/resources/image/icon/settings-close.svg">
				</div>
				<button class="logout_member_setting">
					<img class="main_logout" src="/editor/resources/image/icon/logout.svg">
					로그아웃
				</button>
			</div>
			<hr>
			<div class="etc_setting">
				<div class="chat_member_setting">
					<img class="setting_bot" src="/editor/resources/image/icon/bot.svg">
					마이 챗봇 통계 조회하기
				</div>
			</div>
		</div>
		<div class="button_member_setting">
			<button type="button">수정</button>
			<button type="button">취소</button>
		</div>
	</div>
</body>
</html>