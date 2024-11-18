package com.test.bot.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * WebConfig 클래스 
 * 
 * Spring MVC 설정을 커스터마이징하기 위한 구성 클래스입니다.
 * WebMvcConfigurer 인터페이스를 구현하여 뷰 리졸버 및 정적 리소스 핸들러를 설정합니다.
 * 
 * @author JGChoi
 */
@Configuration
public class WebConfig implements WebMvcConfigurer {
	
	/**
     * JSP 뷰 리졸버 설정 
     * 
     * 이 메서드는 뷰 리졸버의 접두사(prefix)와 접미사(suffix)를 설정합니다.
     * 컨트롤러에서 반환하는 뷰 이름에 기반하여 JSP 파일을 찾는 데 사용됩니다.
     * 
     * 예: 뷰 이름이 "example"일 경우 "/WEB-INF/views/example.jsp"를 찾습니다.
     * 
     * @param registry ViewResolverRegistry 객체
     * @author JGChoi
     */
    @Override
    public void configureViewResolvers(ViewResolverRegistry registry) {
        registry.jsp("/WEB-INF/views/", ".jsp");
    }
    /**
     * 정적 리소스 핸들러 설정 
     * 
     * 이 메서드는 `/resources/**`로 요청되는 정적 리소스를
     * `/resources/` 디렉토리에서 제공하도록 설정합니다.
     * 
     * 예: URL이 `/resources/css/style.css`일 경우,
     * `/resources/css/style.css` 파일을 제공하게 됩니다.
     * 
     * @param registry ResourceHandlerRegistry 객체
     * @author JGChoi
     */
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/resources/**")
                .addResourceLocations("/resources/");
    }
}