package config;

import org.apache.tomcat.jdbc.pool.*;
import org.springframework.context.annotation.*;
import dao.*;
import svc.MyPlantSvc;
import svc.ProductListSvc;

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
	public MyPlantDao myPlantDao() {
		return new MyPlantDao(dataSource());
	}
	
	@Bean
	public MyPlantSvc myPlantSvc() {
		MyPlantSvc myPlantSvc = new MyPlantSvc();
		myPlantSvc.setMyPlantDao(myPlantDao());
		return myPlantSvc;
	}
}
