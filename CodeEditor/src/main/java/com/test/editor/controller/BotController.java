package com.test.editor.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.test.editor.dao.BotDAO;
import com.test.editor.model.BotStatsDTO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class BotController {
	
	private final BotDAO dao;
	
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
	
	private List<BotStatsDTO> getMonthlyStats(int seq) {
		
        return dao.stats(seq);
    }
	
	@GetMapping("/stats")
    public String stats(@RequestParam("seq") String seq, Model model) {
		
        model.addAttribute("seq", seq);
        
        return "stats";
    }
	
	@GetMapping(value = "/statsData", produces = "application/json")
	@ResponseBody
	public Map<String, Object> getStatsData(@RequestParam("seq") String seq) {
	    List<BotStatsDTO> statsData = dao.stats(Integer.parseInt(seq));

	    Map<String, Object> response = new HashMap<>();
	    response.put("statsData", statsData);
	    return response;
	}
	
	@GetMapping(value = "/statsSummary", produces = "application/json")
	@ResponseBody
	public Map<String, Object> getStatesSummary(@RequestParam("seq") String seq) {
		List<BotStatsDTO> statsSummary = dao.summary(Integer.parseInt(seq));
		
		Map<String, Object> summary = new HashMap<>();
		summary.put("statsSummary", statsSummary);
		return summary;
	}

}
