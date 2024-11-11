<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="main_content">
	<div class="main_text">
		<div>Zenith</div>
		<small>주니어 개발자를 위한 협업 사이트로서<br>코드 편집기와 프로젝트 관리 기능을 제공하고 있습니다.</small>
	</div>
	<div class="main_menu">
		<div class="main_menu_box">
			<img class="document" src="/editor/resources/image/icon/document.svg">
			Document
		</div>
		<div class="main_menu_box">
			<img class="code" src="/editor/resources/image/icon/code.svg">
			Code
		</div>
	</div>
</div>
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
<input type="hidden" id="memberSeq" value ="${sessionScope.member.seq}">