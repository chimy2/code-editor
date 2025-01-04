package com.test.editor.controller;

import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.test.editor.model.VersionFileDTO;
import com.test.editor.service.VersionFileService;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class VersionFileController {

	private final VersionFileService service;
	
	@GetMapping("/version-file/{seq}")
	public VersionFileDTO get(HttpSession session, @PathVariable("seq") String seq) {
		VersionFileDTO versionFile = service.get(seq);
		return versionFile;
	}
	
}
