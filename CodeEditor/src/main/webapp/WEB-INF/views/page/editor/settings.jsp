<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="settings-body">
	<div class="settings-main">
		<div class="settings-header">
			<div>Setting</div>
			<img src="/editor/resources/image/icon/settings-close.svg"
				class="settings-close-icon">
		</div>

		<div class="settings-container">
			<ul class="settings-menu">
				<li class="settings-main-item">
					<button onclick="toggleSubMenu('theme')" id="theme-button">
						<img src="/editor/resources/image/icon/right-arrow.svg"
							class="arrow-icon"> Theme
					</button>
					<ul class="settings-sub-menu" id="theme" style="display: none;">
						<li onclick="showContent('appearance')">Appearance</li>
						<li onclick="showContent('colors')">Colors</li>
						<li onclick="showContent('font')">Font</li>
					</ul>
				</li>
				<li class="settings-main-item">
					<button onclick="showContent('template')" id="template-button">
						Template</button>
					<ul class="settings-sub-menu" id="template" style="display: none;">
					</ul>
				</li>
			</ul>

			<div class="settings-content theme-content" id="appearance-content"
				style="display: none;">
				<h2>Appearance</h2>
				<hr>
				<h3>Theme</h3>
				<fieldset class="theme-selector">
					<div>
						<label for="dark-button" class="theme-mode"> <input
							type="radio" name="theme" value="dark" id="dark-button" checked>
							Dark
						</label>
					</div>

					<div>
						<label for="light-button" class="theme-mode"> <input
							type="radio" name="theme" value="light" id="light-button">
							Light
						</label>
					</div>
				</fieldset>
			</div>
			<div class="settings-content" id="colors-content"
				style="display: none;">
				<h2>Colors</h2>
				<hr>
				<div class="colors-container">
					<div class="colors-selector">
						<div class="colors">
							<input type="color" id="text-color" value="#FFFFFF"> <label>font
								foreground</label>
						</div>

						<div class="colors">
							<input type="color" id="background-color" value="#000000">
							<label>background</label>
						</div>

						<div class="colors">
							<input type="color" id="cursor-color" value="#AEAFAD"> <label>Cursor
								foreground</label>
						</div>

						<div class="colors">
							<input type="color" id="active-line-color" value="#C6C6C6">
							<label>Active Line Number Foreground</label>
						</div>

						<div class="colors">
							<input type="color" id="line-number-color" value="#85857B">
							<label>Line Number foreground</label>
						</div>

						<div class="colors">
							<input type="color" id="selection-background-color"
								value="#304F75"> <label>Selection Background</label>
						</div>

						<div class="colors">
							<input type="color" id="comment-color" value="#54874A"> <label>Comment
								color</label>
						</div>
					</div>
					<div class="btn-colors-edit">
						<button>Edit</button>
					</div>
				</div>
			</div>

			<div class="settings-content" id="font-content"
				style="display: none;">
				<h2>Font</h2>
				<hr>
				<div class="font-selection">
					<div class="font-family">
						<h3>글꼴</h3>
						<div class="selected-font">
							<span>D2Coding</span> <img
								src="/editor/resources/image/icon/bottom-arrow.svg"
								class="arrow-icon">
						</div>
						<ul class="select-font-family">
							<li>D2Coding</li>
							<li>Nanum Gothic Coding</li>
							<li>Intel One Mono</li>
						</ul>
					</div>
					<div class="font-size">
						<h3>크기</h3>
						<div class="selected-size">
							<span>10</span> 
							<img src="/editor/resources/image/icon/bottom-arrow.svg" class="arrow-icon">
						</div>
						<ul class="select-font-size">
							<c:forEach var="i" step="2" begin="8" end="30">
								<li>${i}</li>
							</c:forEach>
						</ul>
					</div>
				</div>
				<div class="font-preview-container">
					<h3>보기</h3>
					<div class="font-preview">AaBbYyZz</div>
				</div>
			</div>
			<div class="settings-content" id="template-content"
				style="display: none;">
				<h2>Template</h2>
				<hr>
			</div>
		</div>
		<div class="settings-footer">
			<img src="/editor/resources/image/icon/check-circle.svg">
		</div>
	</div>
</div>

<script>


    function toggleSubMenu(menuId) {
        // 선택한 서브 메뉴와 버튼의 아이콘 찾기
        const menu = document.getElementById(menuId);
        const button = document.getElementById(menuId + '-button');
        const icon = button.querySelector('.arrow-icon');
        
        // 모든 서브 메뉴 숨기기 및 아이콘 초기화
        document.querySelectorAll('.settings-sub-menu').forEach(subMenu => {
            if (subMenu !== menu) {
                subMenu.style.display = 'none';
                const siblingIcon = subMenu.previousElementSibling.querySelector('.arrow-icon');
                if (siblingIcon) siblingIcon.src = '/editor/resources/image/icon/right-arrow.svg';
            }
        });
        
        // 선택한 서브 메뉴 토글 및 아이콘 변경
        if (menu.style.display === 'none') {
            menu.style.display = 'block';
            if (icon) icon.src = '/editor/resources/image/icon/bottom-arrow.svg'; // 아이콘 변경
        } else {
            menu.style.display = 'none';
            if (icon) icon.src = '/editor/resources/image/icon/right-arrow.svg'; // 아이콘 복원
        }
    }

    function showContent(contentId) {
        // 모든 콘텐츠를 숨김
        document.querySelectorAll('.settings-content').forEach(content => content.style.display = 'none');
        // 선택한 콘텐츠만 보이게 설정
        document.getElementById(contentId + '-content').style.display = 'block';
    }
    
 	// Dark와 Light 버튼 클릭 시 선택 상태를 적용하는 함수
	function toggleThemeSelection(theme) {
	    const darkLabel = document.querySelector('label[for="dark-button"]');
	    const lightLabel = document.querySelector('label[for="light-button"]');
	
	    if (theme === 'dark') {
	        darkLabel.classList.add('selected');
	        lightLabel.classList.remove('selected');
	    } else if (theme === 'light') {
	        lightLabel.classList.add('selected');
	        darkLabel.classList.remove('selected');
	    }
	}
 	
	window.addEventListener('DOMContentLoaded', () => {
	    const initialTheme = document.querySelector('input[name="theme"]:checked').value;
	    toggleThemeSelection(initialTheme);
	});
	
	document.getElementById('dark-button').addEventListener('click', () => toggleThemeSelection('dark'));
	document.getElementById('light-button').addEventListener('click', () => toggleThemeSelection('light'));

	
	/* font */
	document.addEventListener("DOMContentLoaded", function () {
	    const fontItems = document.querySelectorAll(".select-font-family li");
	    const sizeItems = document.querySelectorAll(".select-font-size li");
	    
	    const selectedFont = document.querySelector(".selected-font");
	    const selectedFontText = selectedFont.querySelector("span"); // 텍스트 부분만 선택
	    const selectedSize = document.querySelector(".selected-size");
	    const selectedSizeText = selectedSize.querySelector("span"); // 텍스트 부분만 선택
	    
	    // 기본 선택 항목 설정 (예: 첫 번째 항목을 기본 선택으로 설정)
	    const defaultFontItem = fontItems[0];
	    const defaultSizeItem = sizeItems[1]; 
	    
	    // 기본 선택 항목에 selected 클래스 추가 및 텍스트 업데이트
	    defaultFontItem.classList.add("selected");
	    selectedFontText.textContent = defaultFontItem.textContent;
	    
	    defaultSizeItem.classList.add("selected");
	    selectedSizeText.textContent = defaultSizeItem.textContent;
	
	    // 클릭 시 선택된 항목을 업데이트하는 이벤트 리스너
	    fontItems.forEach(item => {
	        item.addEventListener("click", () => {
	            fontItems.forEach(el => el.classList.remove("selected"));
	            item.classList.add("selected");
	            selectedFontText.textContent = item.textContent;
	        });
	    });
	    
	    sizeItems.forEach(item => {
	        item.addEventListener("click", () => {
	            sizeItems.forEach(el => el.classList.remove("selected"));
	            item.classList.add("selected");
	            selectedSizeText.textContent = item.textContent;
	        });
	    });
	});




	
</script>


