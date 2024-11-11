<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<div class="header_editor">
	<div>
		<button class="btn_run">
			<img src="/editor/resources/image/icon/run.svg" />
		</button>
		<button class="btn_console">
			<img src="/editor/resources/image/icon/console.svg" />
		</button>
		
		<!-- 로그인 한 후 -->
		<sec:authorize access="isAuthenticated()">
			<button class="btn_download">
				<img src="/editor/resources/image/icon/download.svg" />
			</button>
			<button class="btn_record">
				<img src="/editor/resources/image/icon/record.svg" />
			</button>
			<!-- 
			<button class="btn_new">test용 생성 버튼</button>
			 -->
		</sec:authorize>
	</div>
	<div>
		<!-- 로그인 한 후 -->
		<sec:authorize access="isAuthenticated()">
			<button class="btn_version">
				<img src="/editor/resources/image/icon/version.svg" />
			</button>
			<button class="btn_settings">
				<img src="/editor/resources/image/icon/settings.svg" />
			</button>
		</sec:authorize>
	</div>
</div>
