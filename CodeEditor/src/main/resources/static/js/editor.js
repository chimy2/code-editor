/**
 *
 */

/* test tab */
$('.add_class').click(() => {
    console.log('class 추가');
    $('.file_tab').append('<div>추가</div>');
});

$(document).ready(function () {
    let tabCounter = 1;

    // Initialize tabs
    $('#tabs').tabs();

    // Make tabs sortable within the tab container
    $('#tabs ul').sortable({
        axis: 'x',
        containment: 'parent', // 탭 목록 내에서만 드래그 가능
        helper: 'original', // 드래그 시 탭이 제자리에서 움직이지 않도록 설정
        start: function (event, ui) {
            // 드래그 시작 시 포커스 이동
            const tabIndex = ui.item.index();
            $('#tabs').tabs('option', 'active', tabIndex);
        },
        stop: function (event, ui) {
            $('#tabs').tabs('refresh');
        },
        scroll: false,
    });
    // Add a new tab
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
        const tabContent = `<div id="${tabId}">모나코를 넣으세요${tabCounter}</div>`;

        // Append new tab and content
        $('#tabs ul').append(tabTemplate);
        $('#tabs').append(tabContent);
        $('#tabs').tabs('refresh');

        const newTabIndex = $('#tabs ul li').length - 1;
        $('#tabs').tabs('option', 'active', newTabIndex);

        // Update tab counter
        tabCounter++;
    });

    // Close a tab on clicking 'x'
    $('#tabs').on('click', '.tab-close', function () {
        const panelId = $(this).prev('a').attr('href');
        $(this).closest('li').remove();
        $(panelId).remove();
        $('#tabs').tabs('refresh');
    });

    // Refresh `x` button visibility on tab change
    $('#tabs').on('tabsactivate', function (event, ui) {
        $('.tab-close').hide(); // 모든 x 버튼 숨기기
        ui.newTab.find('.tab-close').show(); // 활성화된 탭에만 x 버튼 표시
    });

    // Initialize visibility of close buttons
    $('#tabs ul li.ui-tabs-active .tab-close').show();
});

/* editor header button event */
$('.btn_run').click(() => {
    $('.editor').addClass('active_console');
});

$('.btn_console').click(() => {
    $('.editor').toggleClass('active_console');
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

/* console button event */
$('.btn_console_close').click(() => {
    $('.editor').removeClass('active_console');
});

/* popup button event */
$('.btn_popup_close').click(function () {
    toggleDisplay($(this).parents('.popup-container'));
});

$('.settings-close-icon').click(function () {
    $('.settings-body').hide();
});

/* function */
function toggleDisplay(element) {
	const display = element.css('display');
	
	if(display == 'none') {
		element.css('display', 'flex');
	} else {
		element.css('display', 'none');
	}		
}

/* basic code */
$('.select_file_type').selectmenu();