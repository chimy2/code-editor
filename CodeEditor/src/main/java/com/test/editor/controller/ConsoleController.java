package com.test.editor.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.test.editor.compiler.DynamicJavaExcutor;
import com.test.editor.model.ExecuteCode;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class ConsoleController {
	
	@Autowired
	ObjectMapper objectMapper;
	
	@Autowired
	DynamicJavaExcutor dynamicJavaExcutor;
	
	@PostMapping("/code/execute")
	@ResponseBody
	public String executeCode(@RequestBody ExecuteCode code) {
		System.out.println("this is execute" + code);
		String result = dynamicJavaExcutor.execute(code).replaceAll("\n", "<br>"); 
		result = "{\"result\": \"" +result + "\"}";
		System.out.println(result);
		
		return result;
	}
}
