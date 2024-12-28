package com.test.editor.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.test.editor.model.BasicFileDTO;

@Mapper
public interface BasicFileMapper {

	List<BasicFileDTO> getAllFiles();

}
