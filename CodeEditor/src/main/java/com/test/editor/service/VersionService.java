package com.test.editor.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.editor.dao.VersionRepository;
import com.test.editor.model.VersionInfoDTO;

/**
 * 버전 관리와 관련된 비즈니스 로직을 처리하는 서비스 클래스
 */
@Service
public class VersionService {

    @Autowired
    private VersionRepository versionRepository; // 버전 관련 데이터를 처리하는 레포지토리

    /**
     * 특정 날짜의 버전을 복원합니다.
     * 
     * @param versionDate 복원하려는 버전의 날짜
     * @return 복원 성공 여부
     */
    public boolean restoreVersion(String versionDate) {
        VersionInfoDTO versionInfo = versionRepository.findByDate(versionDate); // 날짜로 버전 조회
        if (versionInfo != null) {
            // TODO: 파일 데이터 복원 로직 구현 필요
            return true; // 복원이 성공적으로 이루어진 경우
        }
        return false; // 해당 날짜의 버전 정보가 없을 경우
    }

    /**
     * 모든 버전 정보를 조회합니다.
     * 
     * @return 모든 버전 정보 리스트
     */
    public List<VersionInfoDTO> getAllVersionInfos() {
        List<VersionInfoDTO> versionInfos = new ArrayList<>(); // 버전 정보 리스트 초기화
        try {
            versionInfos = versionRepository.findAll(); // 모든 버전 정보 조회
        } catch (Exception e) {
            e.printStackTrace(); // 오류 발생 시 스택 트레이스를 출력
        }
        return versionInfos; // 조회된 버전 정보 리스트 반환
    }
}
