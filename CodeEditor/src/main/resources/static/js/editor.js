/**
 *
 */

const CODE_URL = 'ws://localhost:8090/editor/vs/code/1';
let ws;

/* test tab */
$(document).ready(function () {
    let tabCounter = 1;

    // Initialize tabs
    $('.editor-tab').tabs();

    // Make tabs sortable within the tab container
    $('.editor-tab ul').sortable({
        axis: 'x',
        containment: 'parent',
        helper: 'original',
        start: function (event, ui) {
            const tabIndex = ui.item.index();
            $('.editor-tab').tabs('option', 'active', tabIndex);
        },
        stop: function () {
            $('.editor-tab').tabs('refresh');
        },
        scroll: false,
    });

    // Configure Monaco path once
    require.config({ paths: { vs: '/editor/resources/lib/monaco' } });

    // Add a new tab with Monaco editor
    $('#add-tab').on('click', function () {
        const tabId = 'tab' + tabCounter;
        const tabTitle = 'Tab ' + tabCounter;
        const tabTemplate = `
        <li>
            <a href="#${tabId}">${tabTitle}</a>
            <span class="tab-close">
                <img src='/editor/resources/image/icon/settings-close.svg'>
            </span>
        </li>`;
        const tabContent = `<div id="${tabId}" class="editor-container"></div>`;

        // Append new tab and content
        $('.editor-tab ul').append(tabTemplate);
        $('.editor-tab').append(tabContent);
        $('.editor-tab').tabs('refresh');

        const newTabIndex = $('.editor-tab ul li').length - 1;
        $('.editor-tab').tabs('option', 'active', newTabIndex);

        // Initialize Monaco editor for the new tab
        require(['vs/editor/editor.main'], function () {
            monaco.editor.create(document.getElementById(tabId), {
                value: '// Start coding here...',
                language: 'java',
                theme: 'vs-dark',
            });
        });

        // Update tab counter
        tabCounter++;
    });

    // Close a tab on clicking 'x'
    $('.editor-tab').on('click', '.tab-close', function () {
        const panelId = $(this).prev('a').attr('href');
        $(this).closest('li').remove();
        $(panelId).remove();
        $('.editor-tab').tabs('refresh');
    });

    // Show close button for the active tab
    $('.editor-tab ul li.ui-tabs-active .tab-close').show();
});

/* editor header button event */
$('.btn_run').click(() => {
    $('.editor-container').addClass('active_console');
});

$('.btn_console').click(() => {
    $('.editor-container').toggleClass('active_console');
});

$('.btn_download').click(() => {
    alert('다운로드해 뭐하는거야');
});

$('.btn_record').click(() => {
    toggleDisplay($('.record-container'));
});

$('.btn_new').click(() => {
    toggleDisplay($('.new-container'));
});

$('.btn_version').click(() => {
    toggleDisplay($('.version-container'));
});

$('.btn_settings').click(() => {
    toggleDisplay($('.settings-body'));
});

$('#new-setting').click(() => {
    toggleDisplay($('.new-template-body'));
}); 

/*
$('#edit-setting').click(() => {
    toggleDisplay($('.edit-template-body'));
}); 
*/

/* console button event */
$('.btn_console_close').click(() => {
    $('.editor-container').removeClass('active_console');
});

/* popup button event */
$('.btn_popup_close').click(function () {
    toggleDisplay($(this).parents('.popup-container'));
});

$('.settings-close-icon').click(function () {
    $('.settings-body').hide();
});

$('.template-close-icon').click(function () {
	console.log('hello?');
    toggleDisplay($(this).parents('.template-body'));
});


/* function */
function toggleDisplay(element) {
    const display = element.css('display');

    if (display == 'none') {
        element.css('display', 'flex');
    } else {
        element.css('display', 'none');
    }
}

/* basic code */
$('.select_file_type').selectmenu();


/* settings */
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
	
	
		
function getThemeData() {
    $.ajax({
        url: "/editor/theme", // URI를 그대로 유지
        method: "GET",
        success: function(data) {
            if (data === "0") {
                $("#dark-button").prop("checked", true);
				toggleThemeSelection("dark")
            } else if (data === "1") {
                $("#light-button").prop("checked", true);
				toggleThemeSelection("light");
            }
        },
        error: function(a,b,c) {
            console.log(a,b,c);
        }
    });
}

$(document).ready(function() {
    getThemeData();
});



