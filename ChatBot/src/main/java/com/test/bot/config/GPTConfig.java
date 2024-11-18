package com.test.bot.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.client.RestTemplate;

/**
 * GPTConfig 클래스 
 * 
 * 이 클래스는 GPT API와 통신하기 위한 RestTemplate을 구성합니다.
 * API 요청 시 필요한 Authorization 헤더를 자동으로 추가하여 
 * GPT API와의 통신을 간소화합니다.
 * 
 * @author JGChoi
 */
@Configuration
public class GPTConfig {
	
	/**
     * GPT API 키 
     * 
     * application.properties 또는 application.yml 파일에서 
     * gpt.api.key 값을 주입받아 사용합니다.
     * 
     * @author JGChoi
     */
	@Value("${gpt.api.key}")
	private String apiKey;
	
	/**
     * RestTemplate Bean 생성 메서드 
     * 
     * RestTemplate은 Spring에서 RESTful API 호출을 위해 사용되는 유틸리티 클래스입니다.
     * 이 메서드는 Authorization 헤더를 자동으로 추가하는 인터셉터를 포함한 
     * RestTemplate 객체를 생성하여 Bean으로 등록합니다.
     * 
     * @return Authorization 헤더를 포함한 RestTemplate 객체
     * @author JGChoi
     */
	@Bean
    public RestTemplate restTemplate(){
        RestTemplate template = new RestTemplate();
        template.getInterceptors().add((request, body, execution) -> {
            request.getHeaders().add(
                    "Authorization"
                    ,"Bearer "+apiKey);
            return execution.execute(request,body);
        });
        return template;
    }
}
