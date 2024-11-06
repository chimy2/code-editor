<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="popup-container new-container">
	<div class="popup-main new-main">
		<div class="popup-header new-header">
			<div>
				New
			</div>
			<div>
	            <button class="btn_popup_close">
	                <img src="/editor/resources/image/icon/settings-close.svg" />
	            </button>
			</div>
		</div>
		<div class="popup-content new-content">
			<form action="#" class="new-form">
				<table class="new-table">
					<tr>
						<th>Type</th>
						<td>
							<select name="type" class="select_file_type">
								<option value="package">Package</option>
								<option value="class">Class</option>
								<option value="interface">Interface</option>
								<option value="text">Text File</option>
								<option value="file">File</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>Name</th>
						<td><input type="text" name="name"></td>
					</tr>
				</table>
			</form>
		</div>
		<div class="popup-footer new-footer">
			<button class="btn_submit_new">
		        Finish
			</button>
		</div>
	</div>
</div>