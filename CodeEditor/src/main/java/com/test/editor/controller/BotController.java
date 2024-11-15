package com.test.editor.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.websocket.Session;

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

/**
 * BotController 클래스
 * 
 * 챗봇 관련 통계 및 관리 기능을 처리하는 컨트롤러 클래스입니다.
 * 데이터 삭제, 통계 데이터 조회, 통계 요약 데이터 제공 등을 담당합니다.
 * @author JGChoi
 */
@Controller
@RequiredArgsConstructor
public class BotController {
	
	private final BotDAO dao;
	
	/**
     * 챗봇 대화 데이터 삭제
     * 
     * 특정 `chatseq`를 기준으로 대화 데이터를 삭제합니다.
     * 
     * @param chatseq 삭제할 대화 데이터의 고유 식별자
     * @return 삭제 성공 시 HTTP 200 OK, 실패 시 HTTP 500 Internal Server Error
     * @author JGChoi
     */
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
	
	/**
     * 월별 통계 데이터 조회 (내부 메서드)
     * 
     * 주어진 사용자의 고유 식별자를 기준으로 월별 통계 데이터를 조회합니다.
     * 
     * @param seq 사용자 고유 식별자
     * @return BotStatsDTO 객체 리스트
     * @author JGChoi
     */
	private List<BotStatsDTO> getMonthlyStats(int seq) {
		
        return dao.stats(seq);
    }
	
	/**
     * 통계 페이지 이동
     * 
     * 세션에 사용자 고유 식별자를 저장하고 통계 페이지로 이동합니다.
     * 
     * @param member_seq 사용자 고유 식별자
     * @param model Spring의 Model 객체
     * @param session HTTP 세션 객체
     * @return 통계 페이지 이름
     * @author JGChoi
     */
	@GetMapping("/stats/${sessionScope.member.seq}")
	public String stats(@PathVariable("member_seq") String member_seq, Model model, HttpSession session) {
		
	    System.out.println(member_seq);
	    session.setAttribute("member_seq", member_seq);
	    return "stats";
	}
	
	/**
     * 통계 데이터 API
     * 
     * 주어진 사용자 고유 식별자를 기준으로 통계 데이터를 JSON 형식으로 반환합니다.
     * 
     * @param seq 사용자 고유 식별자
     * @return 통계 데이터를 포함한 Map 객체
     * @author JGChoi
     */
	@GetMapping(value = "/statsData", produces = "application/json")
	@ResponseBody
	public Map<String, Object> getStatsData(@RequestParam("seq") String seq) {
	    List<BotStatsDTO> statsData = dao.stats(Integer.parseInt(seq));

	    Map<String, Object> response = new HashMap<>();
	    response.put("statsData", statsData);
	    return response;
	}
	
	/**
     * 통계 요약 데이터 API
     * 
     * 주어진 사용자 고유 식별자를 기준으로 요약 통계 데이터를 JSON 형식으로 반환합니다.
     * 
     * @param seq 사용자 고유 식별자
     * @return 요약 통계 데이터를 포함한 Map 객체
     * @author JGChoi
     */
	@GetMapping(value = "/statsSummary", produces = "application/json")
	@ResponseBody
	public Map<String, Object> getStatesSummary(@RequestParam("seq") String seq) {
		List<BotStatsDTO> statsSummary = dao.summary(Integer.parseInt(seq));
		
		Map<String, Object> summary = new HashMap<>();
		summary.put("statsSummary", statsSummary);
		return summary;
	}

}
