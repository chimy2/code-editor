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
						<li onclick="getThemeData(); showContent('appearance')">Appearance</li>
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
							type="radio" name="theme" value="dark" id="dark-button">
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
					<div class="btn-settings">
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
			<div class="settings-content" id="template-content" style="display: none;">
				<h2>Template</h2>
				<hr>
				<div class="template-container">
					<div class="template-table">
						<table>
						    <tr>
						        <th>Keyword</th>
						        <th>Code</th>
						    </tr>
						    <tr>
						        <td>catch</td>
						        <td>catch (\${1:Exception} \${2:e}) {\n    \${3}\n}\${0}</td>
						    </tr>
						    <tr>
						        <td>dowhile</td>
						        <td>do {\n    \${0}\n} while (\${1:condition});</td>
						    </tr>
						    <tr>
						        <td>else</td>
						        <td>else {\n    \${1}\n}\${0}</td>
						    </tr>
						    <tr>
						        <td>finally</td>
						        <td>finally {\n    \${1}\n}\${0}</td>
						    </tr>
						    <tr>
						        <td>for</td>
						        <td>for (int \${1:index} = 0; \${1:index} < \${2:array}.length; \${1:index}++) {\n    \${3}\n}\${0}</td>
						    </tr>
						    <tr>
						        <td>foreach</td>
						        <td>for (\${1:Type} \${2:item} : \${3:collection}) {\n    \${0}\n}</td>
						    </tr>
						    <tr>
						        <td>if</td>
						        <td>if (\${1:condition}) {\n    \${2}\n}\${0}</td>
						    </tr>
						    <tr>
						        <td>ifelse</td>
						        <td>if (\${1:condition}) {\n    \${2}\n} else {\n    \${2}\n}\${0}</td>
						    </tr>
						    <tr>
						        <td>ifelseif</td>
						        <td>if (\${1:condition}) {\n    \${2}\n} else if (\${3:condition}) {\n    \${4}\n} else {\n    \${5}\n}\${0}</td>
						    </tr>
						    <tr>
						        <td>main</td>
						        <td>public static void main(String[] args) {\n    \${0}\n}</td>
						    </tr>
						    <tr>
						        <td>switch</td>
						        <td>switch (\${1:key}) {\n    case \${2:value}:\n        \${0}\n        break;\n    default:\n        break;\n}</td>
						    </tr>
						    <tr>
						        <td>syserr</td>
						        <td>System.err.println(\${1});\${0}</td>
						    </tr>
						    <tr>
						        <td>sysout</td>
						        <td>System.out.println(\${1});\${0}</td>
						    </tr>
						    <tr>
						        <td>tryfinally</td>
						        <td>try {\n    \${1}\n} finally {\n    \${2}\n}\${0}</td>
						    </tr>
						    <tr>
						        <td>trycatch</td>
						        <td>try {\n    \${1}\n} catch (\${2:Exception} \${3:e}) {\n    \${4}\n}\${0}</td>
						    </tr>
						    <tr>
						        <td>while</td>
						        <td>while (\${1:condition}) {\n    \${2}\n}\${0}</td>
						    </tr>
						</table>
					</div>
					<div class="btn-settings">
						<div id="new-setting">
							<button>New</button>
						</div>
						<div id="edit-setting">
							<button>Edit</button>
						</div>
						<div id="delete-setting">
							<button>Delete</button>
						</div>
					</div>
				</div>
				<div>
					<h2>Preview</h2>
					<div class="template-preview" id="template-preview">
					<div></div>
					</div>
				</div>
			</div>
		</div>
		<div class="settings-footer">
			<button><img src="/editor/resources/image/icon/check-circle.svg"></button>
		</div>
	</div>
</div>

<div class="template-body new-template-body">
    <div class="template-main">
        <div class="template-header">
            <h2>New Template</h2>
            <button class="template-close-icon">
                <img src="/editor/resources/image/icon/settings-close.svg">
            </button>
        </div>
        <div class="template-content">
        	<table>
        		<tr>
        			<th>Name</th>
        			<td>
        				<input type="text" class="template-name-input"/>
       				</td>
        		</tr>
        		<tr>
        			<th>Code</th>
       				<td>
       					<textarea></textarea>
       				</td>
        		</tr>
        	</table>
        </div>
        <div class="template-footer">
            <img src="/editor/resources/image/icon/check-circle.svg">
        </div>
    </div>
</div>

<div class="template-body edit-template-body">
    <div class="template-main">
        <div class="template-header">
            <h2>Edit Template</h2>
            <button class="template-close-icon">
                <img src="/editor/resources/image/icon/settings-close.svg">
            </button>
        </div>
        <div class="template-content">
        	<table>
        		<tr>
        			<th>Name</th>
        			<td>
        				<input type="text" class="template-name-input"/>
       				</td>
        		</tr>
        		<tr>
        			<th>Code</th>
       				<td>
       					<textarea></textarea>
       				</td>
        		</tr>
        	</table>
        </div>
        <div class="template-footer">
            <button><img src="/editor/resources/image/icon/check-circle.svg"></button>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	
let themeModified = false; // 설정 변경 여부 추적
let isModified = false;

//테마 선택 변경 시 변경 여부 설정
$('input[name="theme"]').on('change', function() {
 isModified = true;
 themeModified = true;
});

//색상 변경 시 변경 여부 설정
$('input[type="color"]').on('input', function() {
 isModified = true;
});

//폰트 및 기타 설정 변경 시 변경 여부 설정
$('.select-font-family li, .select-font-size li').on('click', function() {
 isModified = true;
});

function closeSettings() {
    $('.settings-body').hide(); // 창을 숨기거나 다른 방식으로 닫기 처리
}

//저장 버튼 클릭 시 동작
$('.settings-footer button').on('click', function() {
    if (isModified) {
    	
    	if(themeModified) {
    		updateTheme(); 
    	}
        
        alert('업데이트해 뭐하는거야');
    } else {
        closeSettings(); // 변경사항이 없으면 창만 닫음
    }
});



//예: 테마 업데이트 요청
function updateTheme(selectedTheme) {
	
	console.log($('input[name="theme"]:checked').val());
	const theme = $('input[name="theme"]:checked').val();
	let themeNumber;
	
	if (theme === 'dark') {
		themeNumber = '0';
	} else if (theme === 'light') {
		themeNumber = '1';
	}
	
	console.log('뭐하는 거야 왜 안 돼 ' + themeNumber);
	
    $.ajax({
        url: '/editor/theme',
        method: 'PUT',
        contentType: 'application/json',
        data: JSON.stringify({ theme: themeNumber }),
        success: function() {
            console.log('Theme updated successfully.');
        },
        error: function(a,b,c) {
            console.log(a, b, c);
        }
    });
}

</script>



