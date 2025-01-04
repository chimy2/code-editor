<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="seq" value="${file.seq}" />
<c:set var="name" value="${file.name}" />
<c:set var="typeSeq" value="${file.fileTypeSeq}" />

<c:choose>
	<c:when test="${typeSeq == 1}">
		<c:set var="type" value="project" />
	</c:when>
	<c:when test="${typeSeq == 2}">
		<c:set var="type" value="src" />
	</c:when>
	<c:when test="${typeSeq == 3}">
		<c:set var="type" value="package" />
	</c:when>
	<c:when test="${typeSeq == 4}">
		<c:set var="type" value="class" />
	</c:when>
	<c:when test="${typeSeq == 5}">
		<c:set var="type" value="interface" />
	</c:when>
	<c:when test="${typeSeq == 6}">
		<c:set var="type" value="txt-file" />
	</c:when>
	<c:when test="${typeSeq == 7}">
		<c:set var="type" value="file" />
	</c:when>
</c:choose>

<c:choose>
	<c:when test="${typeSeq <= 3}">
		<div class="${type}">
			<button>
				<img src="/editor/resources/image/icon/${type}.svg" /> <span
					class="white-text">${name}</span>
			</button>
			<c:forEach var="file" items="${fileMap[seq]}">
				<c:set var="file" value="${file}" scope="request" />
				<jsp:include page="/WEB-INF/views/page/editor/fileItem.jsp" />
			</c:forEach>
		</div>
	</c:when>
	<c:otherwise>
		<div class="${type}">
			<button class="btn_open_editor" data-file-seq="${seq}"
				data-file-type="${type}" data-file-name="${name}">
				<img src="/editor/resources/image/icon/${type}.svg" /> <span
					class="white-text">${name}</span>
			</button>
		</div>
	</c:otherwise>
</c:choose>
