package config;

import org.springframework.context.annotation.*;

import dao.*;
import svc.*;

@Configuration
public class ScheduleConfig {
	@Bean
	public ScheduleDao scheduleDao() {
		return new ScheduleDao(DbConfig.dataSource());
	}

	@Bean
	public ScheduleSvc scheduleSvc() {
		ScheduleSvc scheduleSvc = new ScheduleSvc();
		scheduleSvc.setScheduleDao(scheduleDao());
		return scheduleSvc;
	}
}
