package config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import svc.KakaoSvc;

@Configuration
public class KakaoConfig {
	@Bean
	public KakaoSvc kakaoSvc() {
		KakaoSvc kakaoSvc = new KakaoSvc();
		return kakaoSvc;
	}

}
