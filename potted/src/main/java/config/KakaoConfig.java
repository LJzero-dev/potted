package config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import dao.*;
import svc.*;

@Configuration
public class KakaoConfig {

	@Bean
	public KakaoDao kakaoDao() {
		return new KakaoDao(DbConfig.dataSource());
	}
	
	@Bean
	public KakaoSvc kakaoSvc() {
		KakaoSvc kakaoSvc = new KakaoSvc();
		kakaoSvc.setKakaoDao(kakaoDao()); 
		return kakaoSvc;
	}
}
