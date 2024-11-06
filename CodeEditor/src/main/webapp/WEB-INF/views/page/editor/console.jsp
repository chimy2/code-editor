<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<div class="console-container">
    <section class="console-header">
        <div>
            <img src="/editor/resources/image/icon/console.svg" />
            <span>console</span>
            <button class="btn_console_close">
                <img src="/editor/resources/image/icon/settings-close.svg" />
            </button>
        </div>
    </section>
    <section class="console-content">
        <div class="console-line"></div>
        <div class="console-area">INFO : org.springframework.web.servlet.DispatcherServlet - FrameworkServlet 'appServlet': initialization started
INFO : org.springframework.web.context.support.XmlWebApplicationContext - Refreshing WebApplicationContext for namespace 'appServlet-servlet': startup date [Tue Nov 05 14:17:30 GMT+09:00 2024]; parent: Root WebApplicationContext
INFO : org.springframework.beans.factory.xml.XmlBeanDefinitionReader - Loading XML bean definitions from ServletContext resource [/WEB-INF/spring/appServlet/servlet-context.xml]
INFO : org.springframework.beans.factory.annotation.AutowiredAnnotationBeanPostProcessor - JSR-330 'javax.inject.Inject' annotation found and supported for autowiring
INFO : org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerMapping - Mapped "{[/code],methods=[GET]}" onto public java.lang.String com.test.editor.controller.EditorController.view()
INFO : org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerMapping - Mapped "{[/main],methods=[GET]}" onto public java.lang.String com.test.editor.controller.MainController.test()
INFO : org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerMapping - Mapped "{[/mypage],methods=[GET]}" onto public java.lang.String com.test.editor.controller.MainController.mypage()
INFO : org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter - Looking for @ControllerAdvice: WebApplicationContext for namespace 'appServlet-servlet': startup date [Tue Nov 05 14:17:30 GMT+09:00 2024]; parent: Root WebApplicationContext
INFO : org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter - Looking for @ControllerAdvice: WebApplicationContext for namespace 'appServlet-servlet': startup date [Tue Nov 05 14:17:30 GMT+09:00 2024]; parent: Root WebApplicationContext
INFO : org.springframework.web.servlet.handler.SimpleUrlHandlerMapping - Mapped URL path [/resources/**] onto handler 'org.springframework.web.servlet.resource.ResourceHttpRequestHandler#0'
INFO : org.apache.tiles.access.TilesAccess - Publishing TilesContext for context: org.springframework.web.servlet.view.tiles3.SpringWildcardServletTilesApplicationContext
INFO : org.springframework.web.servlet.DispatcherServlet - FrameworkServlet 'appServlet': initialization completed in 580 ms
11월 05, 2024 2:17:31 오후 org.apache.catalina.core.StandardContext reload
INFO: 이름이 [/editor]인 컨텍스트를 다시 로드하는 것을 완료했습니다.</div>
    </section>
</div>
