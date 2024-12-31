package com.test.editor.service;

import java.util.List;

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
}
