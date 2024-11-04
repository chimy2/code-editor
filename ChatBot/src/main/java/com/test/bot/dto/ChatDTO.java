package com.test.bot.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ChatDTO {
	private String seq;
	private String userseq;
	private String botmsg;
	private String usermsg;
	private String chatdate;
}
