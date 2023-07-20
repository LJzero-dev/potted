package config;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import ctrl.*;
import svc.*;

@Configuration
public class CtrlConfig {	
	@Autowired
	private LoginSvc loginSvc;
	
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
	public LoginCtrl loginCtrl() {
		LoginCtrl loginCtrl = new LoginCtrl();
		loginCtrl.setLoginSvc(loginSvc);
		return loginCtrl;
	}
	
	@Bean
	public LogoutCtrl logoutCtrl() {
		return new LogoutCtrl();
	}
	
	@Bean
	public ServiceCtrl serviceCtrl() {
		return new ServiceCtrl();
	}
	
	@Bean
	public FreeListCtrl freeListCtrl() {
		return new FreeListCtrl();
	}
	
	@Retention(RetentionPolicy.RUNTIME)
	@Target(ElementType.METHOD)
	public @interface LoginRequired {
	}
}
