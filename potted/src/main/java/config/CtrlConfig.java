package config;

import org.springframework.context.annotation.*;

import index.*;


@Configuration
public class CtrlConfig {	
	@Bean
	public IndexCtrl indexCtrl() {
		return new IndexCtrl();
	}
}
