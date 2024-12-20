package com.test.editor.model;

import lombok.Data;

@Data
public class ProjectDTO {

	private String seq;
	private String projectName;
	private String projectEx;
	private String startDate;
	private String target;
	private String priority;
	private String regdate;

	public ProjectDTO getDefault() {
		
		this.projectName = "Test Project";
		this.projectEx = "기본 프로젝트입니다.";
		this.priority = "3";

		return this;
	}

}
