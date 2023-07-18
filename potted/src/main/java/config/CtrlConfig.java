package config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import ctrl.*;

@Configuration
public class CtrlConfig {	
	@Bean
	public IndexCtrl indexCtrl() {
		return new IndexCtrl();
	}
	
	@Bean
	public MyPlantCtrl myPlantCtrl() {
		return new MyPlantCtrl();
	}
	
	@Bean
	public AuctionCtrl auctionCtrl() {
		return new AuctionCtrl();
	}
	
	@Bean
	public ProductListCtrl productListCtrl() {
		return new ProductListCtrl();
	}
	
	@Bean
	public OrderFormCtrl orderFormCtrl() {
		return new OrderFormCtrl();
	}
	
	@Bean
	public LoginFormCtrl loginFormCtrl() {
		return new LoginFormCtrl();
	}
}
