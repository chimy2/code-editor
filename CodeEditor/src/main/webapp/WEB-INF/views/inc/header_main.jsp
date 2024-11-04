<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

</head>
<body>

	<!-- <div class = "svg"><img src="/editor/resources/image/icon/user.svg"></div> -->
	<header>
		<div class="header">
			<div class = "headerImg">
				<img src="/editor/resources/image/icon/Home.svg">
				<img src="/editor/resources/image/icon/Edit.svg">
			</div>
			<div id="nick">test</div>
		</div>
	</header>
	
</body>
<script>

/* 버튼에 따라서 위치 이동 및 개인 설정 창 띄우기 */

const header = document.querySelectorAll('.headerImg img');

header[0].onclick = function(event) {
	//alert(event.target);
	//마이페이지로 이동
};

header[1].onclick = function(event) {
	//alert(event.target);
	//개인 설정 창이 떠야 함 > child 창
};

</script>
</html>