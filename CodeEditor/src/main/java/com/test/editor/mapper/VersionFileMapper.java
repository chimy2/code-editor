package com.test.editor.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.test.editor.model.VersionFileDTO;

/**
 * VersionFileMapper는 MyBatis를 사용하여 데이터베이스와 상호작용하는 매퍼 인터페이스입니다.
 * 
 * Mapper: MyBatis 매퍼 인터페이스임을 나타냅니다. Spring이 이 인터페이스를 구현체로 인식하여 사용합니다.
 */
@Mapper
public interface VersionFileMapper {

    /**
     * 주어진 ID(seq)에 해당하는 버전 파일 정보를 조회합니다.
     * 
     * @param seq 버전 파일의 고유 식별자
     * @return VersionFileDTO - 조회된 버전 파일 정보
     * 
     * @Param("seq"): MyBatis 쿼리에서 "seq"라는 이름으로 이 매개변수를 참조할 수 있도록 지정합니다.
     */
    VersionFileDTO getVersionFileById(@Param("seq") Integer seq);

    /**
     * 모든 버전 파일 정보를 조회합니다.
     * 
     * @return List<VersionFileDTO> - 데이터베이스에서 조회된 모든 버전 파일 목록
     */
    List<VersionFileDTO> getAllVersionFiles();

    /**
     * 새로운 버전 파일을 데이터베이스에 추가합니다.
     * 
     * @param versionFile 추가할 버전 파일 정보
     */
    void insertVersionFile(VersionFileDTO versionFile);
}
