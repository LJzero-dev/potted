package config;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import dao.LoginDao;
import svc.LoginSvc;


@Configuration
public class AdminConfig {
// 회원 관련 작업 설정 클래스 
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
	public LoginDao loginDao() {
		return new LoginDao(dataSource());
	}	
	@Bean
	public LoginSvc loginSvc() {
		LoginSvc loginSvc = new LoginSvc();
		loginSvc.setLoginDao(loginDao());
		return loginSvc;
	}
}