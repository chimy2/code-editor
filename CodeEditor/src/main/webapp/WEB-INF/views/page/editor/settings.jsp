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
			<img src="/editor/resources/image/icon/check-circle.svg">
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
            <img src="/editor/resources/image/icon/check-circle.svg">
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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

	document.addEventListener("DOMContentLoaded", function() {
	    const templatePreview = document.getElementById("template-preview");
	    let selectedRow = null;

	    document.querySelectorAll(".template-table tr").forEach(row => {
	        const codeCell = row.cells[1];

	        if (codeCell) {
	            row.addEventListener("click", function() {
	                if (selectedRow) {
	                    selectedRow.classList.remove("selected-row");
	                }

	                selectedRow = row;
	                row.classList.add("selected-row");

	                // 개행을 <br> 태그로 변환하여 templatePreview에 HTML 형식으로 표시
	                const formattedContent = codeCell.innerHTML
	                    .replace(/\\n/g, "<br>")    // '\n' 그대로 사용된 경우
	                    .replace(/\n/g, "<br>");    // 실제 개행 문자의 경우
	                templatePreview.innerHTML = formattedContent;
	            });
	        }
	    });
	});

	let selectedRowData = null; 

	// 테이블 행(tr) 클릭 시 선택한 데이터를 저장
	$('.template-table tr').click(function() {
		console.log('hello');
	    const keyword = $(this).find('td').eq(0).text(); 
	    const code = $(this).find('td').eq(1).text();   

	    selectedRowData = { keyword, code };

	    $('.template-table tr').removeClass('selected-row'); // 기존 선택 제거
	    $(this).addClass('selected-row');                    // 현재 선택 추가
	});

	// Edit 버튼 클릭 시 처리
	$('#edit-setting').click(() => {
	    if (!selectedRowData) {
	        alert('선택해 뭐하는거야');
	        return;
	    }

	    // 선택된 항목이 있으면 Edit 모드로 전환
	    toggleDisplay($('.edit-template-body'));

	    const formattedContent = selectedRowData.code
	        .replace(/\\n/g, "<br>")    // '\n' 그대로 사용된 경우
	        .replace(/\n/g, "<br>");    // 실제 개행 문자의 경우
	    
	    // 선택된 항목의 데이터를 Edit 창에 표시
	    $('.edit-template-body .template-name-input').val(selectedRowData.keyword); 
	    $('.edit-template-body textarea').val(selectedRowData.code);  
	    // // 개행을 유지하여 원본 코드 표시
	});


	
</script>



<!-- 

System.out.println(\\${1});\\${0}
try {\n    \\${1}\n} catch (\\${2:Exception} \\${3:e}) {\n    \\${4}\n}\\${0}
try {\n    \\${1}\n} finally {\n    \\${2}\n}\\${0}
public static void main(String[] args) {\n    \\${0}\n}
if (\\${1:condition}) {\n    \\${2}\n}\\${0}
else {\n    \\${1}\n}\\${0}
catch (\\${1:Exception} \\${2:e}) {\n    \\${3}\n}\\${0}
finally {\n    \\${1}\n}\\${0}
switch (\\${1:key}) {\n    case \\${2:value}:\n        \\${0}\n        break;\n    default:\n        break;\n}
while (\\${1:condition}) {\n    \\${2}\n}\\${0}
do {\n    \\${0}\n} while (\\${1:condition});
for (int \\${1:index} = 0; \\${1:index} < \\${2:array}.length; \\${1:index}++) {\n    \\${3}\n}\\${0}
for (\\${1:Type} \\${2:item} : \\${3:collection}) {\n    \\${0}\n}
System.err.println(\\${1});\\${0}
if (\\${1:condition}) {\n    \\${2}\n} else {\n    \\${2}\n}\\${0}
if (\\${1:condition}) {\n    \\${2}\n} else if (\\${3:condition}) {\n    \\${4}\n} else {\n    \\${5}\n}\\${0} 

-->
