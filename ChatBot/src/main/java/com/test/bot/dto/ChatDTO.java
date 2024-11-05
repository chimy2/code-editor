package com.test.bot.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ChatDTO {
	private String seq;
	private String memberseq;
	private String botmsg;
	private String membermsg;
	private String chatdate;
}
