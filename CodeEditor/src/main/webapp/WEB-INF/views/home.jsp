<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<html>
<head>
	<title>Home</title>
	<tiles:insertAttribute name="asset" />	
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.min.css" />
	<link rel="stylesheet" href="/editor/resources/lib/cool-custom-context-menu/ContextMenu.css">
</head>
<body>
<div class="target">
<h1>
	Hello world!  
</h1>

<P>  The time on the server is ${serverTime}. </P>

	<div style="display:flex; justify-content: space-around;">
		<div>
			
		<select>
			<option value="package">package</option>
			<option value="class">class</option>
			<option value="interface">interface</option>
			<option value="text">text</option>
			<option value="file">file</option>
		</select>
		</div>
	
		<div>
		
	<div>
		<input type="radio"> package
	</div>
	<div>
		<input type="radio"> class
	</div>
	<div>
		<input type="radio"> interface
	</div>
	<div>
		<input type="radio"> text
	</div>
	<div>
		<input type="radio"> file
	</div>
		</div>
	
		<div>
		
	<table style="border: 1px solid black;">
		<tr><td style="background: tomato;border: 1px solid black;">package</td></tr>
		<tr><td style="border: 1px solid black;">class</td></tr>
		<tr><td style="border: 1px solid black;">interface</td></tr>
		<tr><td style="border: 1px solid black;">text</td></tr>
		<tr><td style="border: 1px solid black;">file</td></tr>
	</table>
	
		</div>
	
	
	</div>
</div>
	
	
	<script src="/editor/resources/lib/cool-custom-context-menu/ContextMenu.js"></script>

<script>

const copyIcon = `<svg viewBox="0 0 24 24" width="13" height="13" stroke="currentColor" stroke-width="2.5" style="margin-right: 7px" fill="none" stroke-linecap="round" stroke-linejoin="round" class="css-i6dzq1"><rect x="9" y="9" width="13" height="13" rx="2" ry="2"></rect><path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"></path></svg>`;

const menuItems = [
{
  content: `New`,
  events: {
    click: (e) => console.log(e, "new")
    // mouseover: () => console.log("Copy Button Mouseover")
    // You can use any event listener from here
  }
},
  {
    content: `Delete`,
    divider: "top" // top, bottom, top-bottom
  }
];

const light = new ContextMenu({
target: ".target",
mode: "light", // default: "dark"
menuItems
});

light.init();
</script>
</body>
</html>
