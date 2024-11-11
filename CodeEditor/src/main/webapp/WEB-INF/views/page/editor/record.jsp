<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="popup-container record-container">
	<div class="popup-main record-main">
		<div class="popup-header record-header">
			<div>
				Record
			</div>
			<div>
	            <button class="btn_popup_close">
	                <img src="/editor/resources/image/icon/settings-close.svg" />
	            </button>
			</div>
		</div>
		<div class="popup-content record-content">
			<form action="#" class="record-form">
				<table class="record-table">
					<tr>
						<th>Message</th>
						<td><textarea name="message"></textarea></td>
					</tr>
				</table>
			</form>
		</div>
		<div class="popup-footer record-footer">
			<button class="btn_submit_record" onclick="saveRecord();">
		        Save
			</button>
		</div>
	</div>
</div>


<script>

	function saveRecord() {
		console.log("saveRecord");
	}

</script>