package config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import ctrl.AuctionCtrl;
import ctrl.IndexCtrl;
import ctrl.MyPlantCtrl;
import test.TestCtrl;


@Configuration
public class CtrlConfig {	
	@Bean
	public IndexCtrl indexCtrl() {
		return new IndexCtrl();
	}
<<<<<<< HEAD
	@Bean
	public MyPlantCtrl myPlantCtrl() {
		return new MyPlantCtrl();
	}
	@Bean
	public AuctionCtrl auctionCtrl() {
		return new AuctionCtrl();
	}
	@Bean
	public TestCtrl test() {
		return test();
=======
	
	@Bean
	public ProductListCtrl productListCtrl() {
		return new ProductListCtrl();
>>>>>>> origin/main
	}
}
