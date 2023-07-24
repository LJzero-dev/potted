package config;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import javax.servlet.http.HttpSession;

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
	
	@Autowired
<<<<<<< HEAD
	private NoticeListSvc noticeListSvc;
=======
	private MyPlantSvc myPlantSvc;
>>>>>>> origin/main
	
	@Bean
	public IndexCtrl indexCtrl() {
		return new IndexCtrl();
	}
	
	@Bean
	public MyPlantCtrl myPlantCtrl() {
		MyPlantCtrl myPlantCtrl = new MyPlantCtrl();
		myPlantCtrl.setMyPlantSvc(myPlantSvc);
		return myPlantCtrl;
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
		ServiceCtrl serviceCtrl = new ServiceCtrl();
		serviceCtrl.setNoticeListSvc(noticeListSvc);
		return serviceCtrl;
	}
	
	@Bean
	public FreeListCtrl freeListCtrl() {
		return new FreeListCtrl();
	}

	
	@Retention(RetentionPolicy.RUNTIME)
	@Target(ElementType.METHOD)
	public @interface LoginRequired {
	}
	
	@Target(ElementType.PARAMETER)
	@Retention(RetentionPolicy.RUNTIME)
	public @interface Login {
	}
}
