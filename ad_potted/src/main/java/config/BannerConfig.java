package config;

import org.springframework.context.annotation.Bean;

import dao.*;
import svc.*;

public class BannerConfig {
	@Bean
	public BannerDao bannerDao() {
		return new BannerDao(DbConfig.dataSource());
	}
	
	@Bean
	public BannerSvc bannerSvc() {
		BannerSvc bannerSvc = new BannerSvc();
		bannerSvc.setBannerDao(bannerDao());
		return bannerSvc;
	}
}
