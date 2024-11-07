package com.test.editor.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import com.test.editor.dao.BotDAO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class BotController {
	
	private final BotDAO dao;

	@GetMapping("/delbot")
	public String delbot(@RequestParam("seq") String seq, Model model) {
		
	    model.addAttribute("seq", seq);
	    return "delbot";
	}
	
	@DeleteMapping("/delbot/{chatseq}")
	public ResponseEntity<Void> delbotdo(@PathVariable("chatseq") String chatseq) {
		
		int seq = Integer.parseInt(chatseq);
		
	    int result = dao.delbot(seq);
	    
	    if (result > 0) {
	        // 삭제가 성공한 경우 200 OK 응답을 반환
	        return ResponseEntity.ok().build();
	    } else {
	        // 삭제가 실패한 경우 500 Internal Server Error 응답을 반환
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
	    }
	}
}
