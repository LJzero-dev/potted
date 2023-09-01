package config;

import org.springframework.context.annotation.Bean;

import svc.KakaoSvc;

public class KakaoConfig {
	@Bean
	public KakaoSvc kakaoSvc() {
		KakaoSvc kakaoSvc = new KakaoSvc();
		return kakaoSvc;
	}

}
