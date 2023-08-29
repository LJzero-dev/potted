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
	private MyPlantSvc myPlantSvc;
	
	@Autowired
	private NoticeSvc noticeSvc;
	
	@Autowired
	private FreeSvc freeSvc;
	
	@Autowired
	private CartSvc cartSvc;
	
	@Autowired
	private IndexSvc indexSvc;
	
	@Autowired
	private OrderSvc orderSvc;
	
	@Autowired
	private MemberSvc memberSvc;
	
	@Bean
	public IndexCtrl indexCtrl() {
		IndexCtrl indexCtrl = new IndexCtrl();
		indexCtrl.setIndexSvc(indexSvc);
		return indexCtrl;
	}
	
	@Bean
	public ProductListCtrl productListCtrl() {
		ProductListCtrl productListCtrl = new ProductListCtrl();
		productListCtrl.setProductListSvc(productListSvc);
		
		return productListCtrl;
	}

	@Bean
	public MyPlantCtrl myPlantCtrl() {
		MyPlantCtrl myPlantCtrl = new MyPlantCtrl();
		myPlantCtrl.setMyPlantSvc(myPlantSvc);
		return myPlantCtrl;
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
		serviceCtrl.setNoticeSvc(noticeSvc);
		
		return serviceCtrl;
	}
	
	@Bean
	public FreeCtrl freeCtrl() {
		FreeCtrl freeCtrl = new FreeCtrl();
		freeCtrl.setFreeSvc(freeSvc);
		
		return freeCtrl;
	}
	
	@Bean
	public CartCtrl cartCtrl() {
		CartCtrl cartCtrl = new CartCtrl();
		cartCtrl.setCartSvc(cartSvc);
		return cartCtrl;
	}
	
	@Bean
	public OrderFormCtrl orderFormCtrl() {
		OrderFormCtrl orderFormCtrl = new OrderFormCtrl();
		orderFormCtrl.setOrderSvc(orderSvc);
		return orderFormCtrl;
	}
	
	@Bean
	public MemberCtrl memberCtrl() {
		MemberCtrl memberCtrl = new MemberCtrl();
		memberCtrl.setMemberSvc(memberSvc);
		return memberCtrl;
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
