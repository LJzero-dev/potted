package config;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.context.annotation.Bean;

import dao.AuctionDao;
import svc.AuctionSvc;

public class AuctionConfig {
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
	public AuctionDao auctionDao() {
		return new AuctionDao(dataSource());
	}
	
	@Bean
	public AuctionSvc auctionSvc() {
		AuctionSvc auctionSvc = new AuctionSvc();
		auctionSvc.setAuctionDao(auctionDao());
		return auctionSvc;
	}
}
