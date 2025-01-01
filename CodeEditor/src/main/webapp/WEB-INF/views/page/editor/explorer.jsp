<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="explorer_container">
	<div class="explorer_sidebar">
		<div class="package-explorer" id="packageExplorer">
			<div class="folder">
				<c:set var="rootSeq" value="0" />
				<c:set var="files" value="${fileMap}" scope="request"/>

				<!-- 프로젝트 최상위 항목 -->
				<c:forEach var="file" items="${fileMap[rootSeq]}">
    				<c:set var="file" value="${file}" scope="request"/>
				    <jsp:include page="/WEB-INF/views/page/editor/fileItem.jsp" />
				</c:forEach>
			</div>
		</div>
	</div>

	<!-- 사이드탭 버튼 -->
	<div class="explorer_sidetab">
		<button class="explorer_sidetabButton">
			<img src="/editor/resources/image/icon/side.svg" alt="Scroll Icon"
				class="explorer_sidetabImg" />
		</button>
	</div>
</div>
