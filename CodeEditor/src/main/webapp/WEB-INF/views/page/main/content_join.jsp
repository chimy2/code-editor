<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<form  method="POST" action="/editor/join">
	<div class="content_join">
		<div class="join_text">회원가입</div>
		<div class="join_box" id="email_box">
			<img class="email_img" src="/editor/resources/image/icon/mail.svg">
			이메일로 회원가입
		</div>
		<div class="join_box">
			<img class="kakao_img" src="/editor/resources/image/icon/kakao.svg">
			카카오로 회원가입
		</div>
		<div class="join_box" id="google">
			<img class="google_img" src="/editor/resources/image/icon/google.svg">
			구글로 회원가입
		</div>
	
		<div class="email_join">
			<div class="join_inner_box_text">zenith</div>
			<div class="join_inner_box">
				<div class="join_id" id="email_duplicate">
					이메일
					<div class="duplicate_check">
						<input type="email" name="username" placeholder="이메일을 입력해주세요."  >
						<button type="button">중복체크</button>
					</div>
					<div id="duplicate_check_email" class="duplicate_check_message"></div>
				</div>
				<div class="join_nick" id="nick_duplicate">
					닉네임
					<div class="duplicate_check">
						<input type="text" name="nick" placeholder="닉네임을 입력해주세요." >
						<button type="button">중복체크</button>
					</div>
					<div id="duplicate_check_nick" class="duplicate_check_message"></div>
				</div>
				<div class="join_password">
					비밀번호 
					<input type="password" name="password" id ="password" placeholder="영문,숫자,특수문자 중 3종류 이상 조합하여 8~12자리">
				</div>
				<div id="pw_check" class="duplicate_check_message"></div>
				<div class="join_password_check">
					비밀번호확인 
					<input type="password" id ="password_check" placeholder="비밀번호를 확인해주세요.">
				</div>
				<div id="pw_again_check" class="duplicate_check_message"></div>
			</div>
			<div class="join_button">
				<button type="submit" id ="join_button" disabled>회원가입</button>
				<button type="button">취소</button>
			</div>
		</div>
	</div>
</form>