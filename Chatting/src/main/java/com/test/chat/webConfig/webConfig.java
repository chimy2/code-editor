package com.test.chat.webConfig;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

public class webConfig {
	@Configuration
	public class WebConfig implements WebMvcConfigurer {

	    @Override
	    public void addCorsMappings(CorsRegistry registry) {
	        registry.addMapping("/chatIndex")
	                .allowedOrigins("http://localhost:8090/editor/code") // 다른 프로젝트의 주소 (codeeditor 프로젝트의 주소)
	                .allowedMethods("GET");
	        registry.addMapping("/chatScreen")
	                .allowedOrigins("http://localhost:8090/editor/code")
	                .allowedMethods("GET");
	    }
	}
}
