package config;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.context.annotation.*;
import dao.*;
import vo.*;
import svc.*;

@Configuration
public class ServiceConfig {
	
		@Bean(destroyMethod = "close")
		public DataSource dataSource() {
			DataSource ds = new DataSource();
			ds.setDriverClassName("com.mysql.jdbc.Driver");
			ds.setUrl("jdbc:mysql://localhost/potted?characterEncoding=utf8");
			ds.setUsername("root");
			ds.setPassword("1234");
			ds.setInitialSize(2);
			ds.setMaxActive(10);
			ds.setTestWhileIdle(true);
			ds.setMinEvictableIdleTimeMillis(60000 * 3);
			ds.setTimeBetweenEvictionRunsMillis(10 * 1000);
			return ds;
		}
		
		@Bean
		public NoticeSvc noticeSvc() {
			NoticeSvc noticeSvc = new NoticeSvc();
			noticeSvc.setNoticeListDao(noticeDao()); 
			return noticeSvc;
		}
		
		@Bean
		public NoticeDao noticeDao() {
			return new NoticeDao(dataSource());
		}
	}

