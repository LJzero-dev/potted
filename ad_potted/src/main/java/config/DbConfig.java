package config;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import dao.MemberDao;
import svc.LoginSvc;
import svc.MemberSvc;

@Configuration
public class DbConfig {
	@Bean(destroyMethod = "close")
	public static DataSource dataSource() {
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
	public MemberDao memberDao() {
		return new MemberDao(dataSource());
	}	
	@Bean
	public MemberSvc memberSvc() {
		MemberSvc memberSvc = new MemberSvc();
		memberSvc.setMemberDao(memberDao());
		return memberSvc;
	}
	
}
