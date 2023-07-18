package config;

import org.springframework.context.annotation.*;

import ctrl.IndexCtrl;
import ctrl.*;


@Configuration
public class CtrlConfig {	
	@Bean
	public IndexCtrl indexCtrl() {
		return new IndexCtrl();
	}
	
	@Bean
	public ProductListCtrl productListCtrl() {
		return new ProductListCtrl();
	}
}
