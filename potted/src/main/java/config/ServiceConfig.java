package config;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.context.annotation.*;
import dao.*;
import vo.*;
import svc.*;

@Configuration
public class ServiceConfig {
	
		@Bean
		public NoticeSvc noticeSvc() {
			NoticeSvc noticeSvc = new NoticeSvc();
			noticeSvc.setNoticeListDao(noticeDao()); 
			return noticeSvc;
		}
		
		@Bean
		public NoticeDao noticeDao() {
			return new NoticeDao(DbConfig.dataSource());
		}
	}

