package config;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.context.annotation.*;
import dao.*;
import vo.*;
import svc.*;

@Configuration
public class FreeConfig {
		
		@Bean
		public FreeSvc freeSvc() {
			FreeSvc freeSvc = new FreeSvc();
			freeSvc.setFreeDao(freeDao()); 
			return freeSvc;
		}
		
		@Bean
		public FreeDao freeDao() {
			return new FreeDao(DbConfig.dataSource());
		}
	}

