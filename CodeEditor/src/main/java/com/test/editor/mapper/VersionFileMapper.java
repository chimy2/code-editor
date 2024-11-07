package com.test.editor.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.test.editor.model.VersionFileDTO;

@Mapper
public interface VersionFileMapper {

    VersionFileDTO getVersionFileById(@Param("seq") Integer seq);

    List<VersionFileDTO> getAllVersionFiles();

    void insertVersionFile(VersionFileDTO versionFile);
}
