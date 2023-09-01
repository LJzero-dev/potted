package config;

import org.springframework.context.annotation.*;
import dao.*;
import svc.*;

@Configuration
public class MapConfig {
	
	@Bean
	public MapSvc mapSvc() {
		MapSvc mapSvc = new MapSvc();
		mapSvc.setMapDao(mapDao()); 
		return mapSvc;
	}
	
	@Bean
	public MapDao mapDao() {
		return new MapDao(DbConfig.dataSource());
	}

}
