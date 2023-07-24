package config;

import org.springframework.context.annotation.*;
import ctrl.*;

@Configuration
public class CtrlConfig {
// 구현해 놓은 컨트롤러들을 스프링 빈으로 등록시키는 클래스
/*	@Bean
	public IndexCtrl indexCtrl() {
		return new IndexCtrl();
	}*/
	
	@Bean
	public ProductCtrl productProcInCtrl() {
		return new ProductCtrl();
	}
}
