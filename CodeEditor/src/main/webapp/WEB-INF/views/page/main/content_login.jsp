<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<form method="POST" action="/editor/login">
<div class="content_login">
	<div class="login">
		<img class="setting_close" src="/editor/resources/image/icon/settings-close.svg">
		<div class="login_inner_box_text">zenith</div>
		<div class="login_inner_box">
			<div class="login_id">
				이메일
				<input type="email" name ="username" placeholder="이메일을 입력해주세요." required>
			</div>
			<div class="login_password">
				비밀번호
				<input type="password" name ="password" placeholder="비밀번호를 입력해주세요." required>
			</div>
			<div  class="login_button">
				<button type="submit">로그인</button>
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
<!-- 22.b CSRF 토큰-->
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">

</form>