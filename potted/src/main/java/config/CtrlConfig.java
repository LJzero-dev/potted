package config;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import ctrl.CartCtrl;
import ctrl.FreeCtrl;
import ctrl.IndexCtrl;
import ctrl.LoginCtrl;
import ctrl.LogoutCtrl;
import ctrl.MemberCtrl;
import ctrl.MyPlantCtrl;
import ctrl.OrderFormCtrl;
import ctrl.PlantBookCtrl;
import ctrl.ProductListCtrl;
import ctrl.ServiceCtrl;
import svc.CartSvc;
import svc.FreeSvc;
import svc.IndexSvc;
import svc.LoginSvc;
import svc.MyPlantSvc;
import svc.NoticeSvc;
import svc.OrderSvc;
import svc.ProductListSvc;

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
	@Bean
	public PlantBookCtrl plantBookCtrl() {
		return new PlantBookCtrl();
	}
}
