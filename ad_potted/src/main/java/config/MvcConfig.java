package config;

import org.springframework.context.annotation.*;
import org.springframework.web.servlet.config.annotation.*;

@Configuration
@EnableWebMvc
public class MvcConfig implements WebMvcConfigurer {
	public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
		configurer.enable();
	}
	
	public void configureViewResolvers(ViewResolverRegistry registry) {
		registry.jsp("/WEB-INF/view/", ".jsp");	// jsp�� �̰��� �⺻ ��Ʈ�� ����ϰڴٴ� �ǹ�
		// view ���ϵ��� �⺻ ��ġ�� Ȯ���ڸ� ����
	}
}
