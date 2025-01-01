<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="seq" value="${file.seq}" />
<c:set var="name" value="${file.name}" />
<c:set var="type" value="${file.fileTypeSeq}" />

<c:choose>
	<c:when test="${type == 1}">
		<div class="project">
			<button>
				<img src="/editor/resources/image/icon/project.svg" /> <span
					class="white-text">${name}</span>
			</button>
			<c:forEach var="file" items="${fileMap[seq]}">
				<c:set var="file" value="${file}" scope="request" />
				<jsp:include page="/WEB-INF/views/page/editor/fileItem.jsp" />
			</c:forEach>
		</div>
	</c:when>
	<c:when test="${type == 2}">
		<div class="src">
			<button>
				<img src="/editor/resources/image/icon/src.svg" /> <span
					class="white-text">${name}</span>
			</button>
			<c:forEach var="file" items="${fileMap[seq]}">
				<c:set var="file" value="${file}" scope="request" />
				<jsp:include page="/WEB-INF/views/page/editor/fileItem.jsp" />
			</c:forEach>
		</div>
	</c:when>
	<c:when test="${type == 3}">
		<div class="package">
			<button>
				<img src="/editor/resources/image/icon/package.svg" /> <span
					class="white-text">${name}</span>
			</button>
			<c:forEach var="file" items="${fileMap[seq]}">
				<c:set var="file" value="${file}" scope="request" />
				<jsp:include page="/WEB-INF/views/page/editor/fileItem.jsp" />
			</c:forEach>
		</div>
	</c:when>
	<c:when test="${type == 4}">
		<div class="class">
			<button class="btn_open_editor" data-file-type="class"
				data-file-name="${name}">
				<img src="/editor/resources/image/icon/class.svg" /> <span
					class="white-text">${name}</span>
			</button>
		</div>
	</c:when>
	<c:when test="${type == 5}">
		<div class="interface">
			<button class="btn_open_editor" data-file-type="interface"
				data-file-name="${name}">
				<img src="/editor/resources/image/icon/interface.svg" /> <span
					class="white-text">${name}</span>
			</button>
		</div>
	</c:when>
	<c:when test="${type == 6}">
		<div class="txt-file">
			<button class="btn_open_editor" data-file-type="txt"
				data-file-name="${name}">
				<img src="/editor/resources/image/icon/txt.svg" /> <span
					class="white-text">${name}</span>
			</button>
		</div>
	</c:when>
	<c:when test="${type == 7}">
		<div class="file">
			<button class="btn_open_editor" data-file-type="file"
				data-file-name="${name}">
				<img src="/editor/resources/image/icon/file.svg" /> <span
					class="white-text">${name}</span>
			</button>
		</div>
	</c:when>
</c:choose>
