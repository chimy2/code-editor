package com.test.editor.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.test.editor.model.VersionFileDTO;
import com.test.editor.model.VersionInfoDTO;

/**
 * VersionFileMapper는 MyBatis를 사용하여 데이터베이스와 상호작용하는 매퍼 인터페이스입니다.
 * 
 * Mapper: MyBatis 매퍼 인터페이스임을 나타냅니다. Spring이 이 인터페이스를 구현체로 인식하여 사용합니다.
 */
@Mapper
public interface VersionFileMapper {

	int insertBasicFiles(@Param("versionInfo") VersionInfoDTO versionInfo);

	List<VersionFileDTO> getAllVersionFiles(String versionInfoSeq);

	int getNextSeq();

	int insertList(List<VersionFileDTO> versionFiles);

	int insert(VersionFileDTO file);

	VersionFileDTO get(String seq);

}
