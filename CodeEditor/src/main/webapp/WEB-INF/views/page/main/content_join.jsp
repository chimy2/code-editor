<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Content_join</title>
</head>
<body>
	<div class="content_join">
		<div class="join_text">회원가입</div>
		<div class="join_box">
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
				<div class="join_id">
					이메일
					<div class = "duplicate_check">
						<input type="email" placeholder="이메일을 입력해주세요." required>
						<button type="button">중복체크</button>
					</div>
				</div>
				<div class="join_nick">
					닉네임
					<div class = "duplicate_check">
						<input type="text" placeholder="닉네임을 입력해주세요." required>
						<button type="button">중복체크</button>
					</div>
				</div>
				<div class="join_password">
					비밀번호
					<input type="password" placeholder="영문,숫자,특수문자 중 2종류 이상 조합하여 8~12자리" required>
				</div>
				<div class="join_password_check">
					비밀번호확인
					<input type="password" placeholder="비밀번호를 확인해주세요." required>
				</div>
			</div>
			<div class="join_button"> 
				<button type="button" disabled>회원가입</button>
				<button type="button">취소</button>
			</div>
		</div>
	
	
	</div>
</body>
</html>