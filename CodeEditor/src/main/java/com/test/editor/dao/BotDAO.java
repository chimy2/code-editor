package com.test.editor.dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.editor.mapper.BotMapper;
import com.test.editor.model.BotStatsDTO;

/**
 * BotDAO 클래스
 * 
 * 챗봇 관련 데이터베이스 작업을 처리하는 DAO(Data Access Object) 클래스입니다.
 * BotMapper를 사용하여 데이터 삽입, 조회, 삭제 작업을 수행합니다.
 */
@Repository
public class BotDAO {
	
	@Autowired
	private BotMapper mapper;

	/**
     * 챗봇 대화 데이터 삭제
     * 
     * 특정 `seq` 값을 기준으로 대화 데이터를 삭제합니다.
     * 
     * @param seq 삭제할 대화 데이터의 고유 식별자
     * @return 삭제 성공 시 1, 실패 시 0
     */
	public int delbot(int seq) {
		
		return mapper.botdel(seq);
	}
	
	/**
     * 월별 통계 데이터 조회
     * 
     * 특정 사용자의 고유 식별자를 기준으로 월별 통계 데이터를 조회합니다.
     * 
     * @param seq 사용자 고유 식별자
     * @return 조회된 월별 통계 데이터를 포함한 `BotStatsDTO` 객체 리스트
     * @author JGChoi
     */
	public List<BotStatsDTO> stats(int seq) {
		
        return mapper.stats(seq);
    }

	/**
     * 통계 요약 데이터 조회
     * 
     * 특정 사용자의 고유 식별자를 기준으로 요약 통계 데이터를 조회합니다.
     * 
     * @param seq 사용자 고유 식별자
     * @return 조회된 요약 통계 데이터를 포함한 `BotStatsDTO` 객체 리스트
     * @author JGChoi
     */
	public List<BotStatsDTO> summary(int seq) {
		
		return mapper.summary(seq);
	}

}
