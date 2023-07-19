package config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import ctrl.AuctionCtrl;
import ctrl.FreeListCtrl;
import ctrl.IndexCtrl;
import ctrl.LoginFormCtrl;
import ctrl.MyPlantCtrl;
import ctrl.OrderFormCtrl;
import ctrl.ProductListCtrl;
import ctrl.ServiceCtrl;
import svc.ProductListSvc;

@Configuration
public class CtrlConfig {	
	@Autowired
	private ProductListSvc productListSvc;
	
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
		ProductListCtrl productListCtrl = new ProductListCtrl();
		productListCtrl.setProductListSvc(productListSvc);
		
		return productListCtrl;
	}
	
	
	@Bean
	public OrderFormCtrl orderFormCtrl() {
		return new OrderFormCtrl();
	}
	
	@Bean
	public LoginFormCtrl loginFormCtrl() {
		return new LoginFormCtrl();
	}
	
	@Bean
	public ServiceCtrl serviceCtrl() {
		return new ServiceCtrl();
	}
	
	@Bean
	public FreeListCtrl freeListCtrl() {
		return new FreeListCtrl();
	}
}
