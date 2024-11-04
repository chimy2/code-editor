<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="settings-html">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body class="settings-body">
<main class="settings-main">
	<header>
		<div>
			Setting
		</div>
	</header>
	
	<div class="settings-container">
	    <ul class="menu">
	        <li class="main-item">
	            <button onclick="toggleSubMenu('theme')">Theme</button>
	            <ul class="sub-menu" id="theme" style="display: none;">
	                <li onclick="showContent('appearance')">Appearance</li>
	                <li onclick="showContent('colors')">Colors</li>
	                <li onclick="showContent('font')">Font</li>
	            </ul>
	        </li>
	        <li class="main-item">
	            <button onclick="toggleSubMenu('template')">Template</button>
	            <ul class="sub-menu" id="template" style="display: none;">
	                <!-- Template 하위 메뉴를 필요 시 추가 -->
	            </ul>
	        </li>
	    </ul>
	    
	    <div class="content" id="appearance-content" style="display: none;">
	        <!-- Appearance 내용 -->
	    </div>
	    <div class="content" id="colors-content" style="display: none;">
	        <!-- Colors 내용 -->
	    </div>
	    <div class="content" id="font-content" style="display: none;">
	        <!-- Font 내용 -->
	    </div>
	</div>


    <footer>
        <img src="/editor/resources/image/icon/check-circle.svg">
    </footer>
</main>
</body>

    <script>

	    function toggleSubMenu(menuId) {
	        // 모든 서브 메뉴를 숨김
	        document.querySelectorAll('.sub-menu').forEach(menu => {
	            if (menu.id !== menuId) {
	                menu.style.display = 'none';
	            }
	        });
	        
	        // 클릭한 서브 메뉴만 토글 (보이기/숨기기)
	        const menu = document.getElementById(menuId);
	        if (menu.style.display === 'none') {
	            menu.style.display = 'block';
	        } else {
	            menu.style.display = 'none';
	        }
	    }
	
	    function showContent(contentId) {
	        // 모든 콘텐츠를 숨김
	        document.querySelectorAll('.content').forEach(content => content.style.display = 'none');
	        // 선택한 콘텐츠만 보이게 설정
	        document.getElementById(contentId + '-content').style.display = 'block';
	    }

        

    </script>

</html>