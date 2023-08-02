package config;

import org.springframework.context.annotation.Bean;

import dao.*;
import svc.*;

public class IndexConfig {
	@Bean
	public IndexDao indexDao() {
		return new IndexDao(DbConfig.dataSource());
	}
	
	@Bean
	public IndexSvc indexSvc() {
		IndexSvc indexSvc = new IndexSvc();
		indexSvc.setIndexDao(indexDao()); 
		return indexSvc;
	}
}
