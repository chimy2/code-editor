<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="settings-body">
<div class="settings-main">
    <header>
        <div>
            Setting
        </div>
        <img src="/editor/resources/image/icon/settings-close.svg" class="settings-close-icon">
    </header>
    
    <div class="settings-container">
        <ul class="settings-menu">
            <li class="settings-main-item">
                <button onclick="toggleSubMenu('theme')" id="theme-button">
                    <img src="/editor/resources/image/icon/right-arrow.svg" class="arrow-icon">
                    Theme
                </button>
                <ul class="settings-sub-menu" id="theme" style="display: none;">
                    <li onclick="showContent('appearance')">Appearance</li>
                    <li onclick="showContent('colors')">Colors</li>
                    <li onclick="showContent('font')">Font</li>
                </ul>
            </li>
            <li class="settings-main-item">
				<button onclick="showContent('template')" id="template-button">
				    Template
				</button>
                <ul class="settings-sub-menu" id="template" style="display: none;">
                </ul>
            </li>
        </ul>
        
        <div class="theme-content" id="appearance-content" style="display: none;">
	        <h2>Appearance</h2>
	        <hr>
	        <h3>Theme</h3>
	        <fieldset class="theme-selector">
	          <label class="theme-mode">
	              <input type="radio" name="theme" value="dark" id="dark-button" checked>
	              <span>Dark</span>
	          </label>
	          <label class="theme-mode">
	              <input type="radio" name="theme" value="light" id="light-button" >
	              <span>Light</span>
	          </label>
	        </fieldset>
        </div>
        <div class="settings-content" id="colors-content" style="display: none;">
            Colors 내용 
        </div>
        <div class="settings-content" id="font-content" style="display: none;">
            Font 내용 
        </div>
        <div class="settings-content" id="template-content" style="display: none;">
		    Template 내용
		</div>
		        
    </div>

    <footer>
        <img src="/editor/resources/image/icon/check-circle.svg">
    </footer>
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
        const darkButton = document.getElementById('dark-button');
        const lightButton = document.getElementById('light-button');

        if (theme === 'dark') {
            darkButton.classList.add('selected');
            lightButton.classList.remove('selected');
        } else if (theme === 'light') {
            lightButton.classList.add('selected');
            darkButton.classList.remove('selected');
        }
    }

    // 이벤트 리스너 추가
    document.getElementById('dark-button').addEventListener('click', () => toggleThemeSelection('dark'));
    document.getElementById('light-button').addEventListener('click', () => toggleThemeSelection('light'));

</script>


