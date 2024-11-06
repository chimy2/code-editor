<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Content_login</title>
</head>
<body>
	<div class="content_login">
		<div class="login">
			<img class="setting_close" src="/editor/resources/image/icon/settings-close.svg">
			<div class="login_inner_box_text">zenith</div>
			<div class="login_inner_box">
				<div class="login_id">
					이메일
					<input type="email" placeholder="이메일을 입력해주세요." required>
				</div>
				<div class="login_password">
					비밀번호
					<input type="password" placeholder="비밀번호를 입력해주세요." required>
				</div>
				<div  class="login_button">
					<button type="button" disabled>로그인</button>
					<button type="button">회원가입</button>
				</div>
				
				
				<div class="oAuth_line">
					<span class="login_line"></span>간편 로그인<span class="login_line"></span>
				</div>
				<div class="oAuth_button">
					<img class="kakao_img" src="/editor/resources/image/icon/kakao.svg">
					<img class="google_img" src="/editor/resources/image/icon/google.svg">
				</div>
			</div>
		</div>
	</div>
</body>
</html>