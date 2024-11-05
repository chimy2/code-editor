<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>jQuery UI Sortable Tabs with Conditional Close Button</title>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <style>
        #tabs { width: 600px; margin: 20px auto; }
        #tabs ul { overflow: hidden; }
        #tabs ul li { float: left; width: 100px; position: relative; }
        .ui-tabs-active .tab-close { display: inline; } /* 활성화된 탭에서만 x 표시 */
        .tab-close { display: none; position: absolute; right: 5px; top: 5px; cursor: pointer; color: red; }
        #add-tab { margin: 10px 0; }
    </style>
</head>
<body>

<div id="tabs">
    <ul>
    </ul>
</div>
<button id="add-tab">Add Tab</button>

</body>
</html>