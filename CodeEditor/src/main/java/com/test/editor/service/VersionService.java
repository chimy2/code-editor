package com.test.editor.service;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.test.editor.model.VersionFileDTO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class VersionService {
	
	
	private final VersionInfoService versionInfoService;
	
	private final VersionFileService versionFileService;
	
	
	public List<VersionFileDTO> getLastVersionFiles(String projectSeq) {
		Integer lastVersionSeq = versionInfoService.getLastVersionSeq(projectSeq);
		
		if(lastVersionSeq == null) {
			return null;
		}
		return versionFileService.getAllVersionFiles(lastVersionSeq); 
	}
	
	public Map<String, List<VersionFileDTO>> groupByParentSeq(List<VersionFileDTO> files) {

        Map<String, List<VersionFileDTO>> fileMap = files.stream()
            .collect(Collectors.groupingBy(file -> file.getParentSeq() == null ? "0" : file.getParentSeq()));

        return fileMap;
	}
}
