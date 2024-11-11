package com.test.editor.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BotStatsDTO {
	
	private String month;
    private int count;
    
    private String error_type;
    private String error_count;
}
