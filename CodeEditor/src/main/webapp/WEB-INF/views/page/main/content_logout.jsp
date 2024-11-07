<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<form method="POST" action="/editor/logout">
	<div class="content_logout">
		<div class="logout">
			
			<div class="logout_text">
				<div>Zenith</div>
				<div>로그아웃 하시겠습니까?</div>
			</div>
			
			<div class="logout_button"> 
				<button type="submit">예</button>
				<button type="button">아니오</button>
			</div>
			
		</div>
	
	</div>
	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
</form>