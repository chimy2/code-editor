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
	<div class="content_memberSetting">
		<div class="header_member_setting">개인 설정 수정</div>
		<div class="body_member_setting">
			<div class="info_member_setting">
				<div class="setting_user_icon"><img src="/editor/resources/image/icon/user.svg"></div>
				<div class="setting_nick">
					<input type="text" class="setting_user_nick" value="test">
					<img class="setting_nick_close" src="/editor/resources/image/icon/settings-close.svg">
				</div>
				<button class="logout_member_setting">
					<img class="main_logout" src="/editor/resources/image/icon/logout.svg">
					로그아웃
				</button>
			</div>
			<div class="chat_member_setting">
				마이 챗봇 통계 조회하기
			</div>
		</div>
		<div class="button_member_setting">
			<button type="button">수정</button>
			<button type="button">취소</button>
		</div>
	</div>
</body>
</html>