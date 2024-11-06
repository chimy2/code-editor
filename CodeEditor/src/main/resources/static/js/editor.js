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
