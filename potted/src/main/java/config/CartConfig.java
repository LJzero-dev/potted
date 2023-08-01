package config;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.context.annotation.Bean;
import dao.*;
import svc.*;

public class CartConfig {

	@Bean
	public CartDao cartDao() {
		return new CartDao(DbConfig.dataSource());
	}
	
	@Bean
	public CartSvc cartSvc() {
		CartSvc cartSvc = new CartSvc();
		cartSvc.setCartDao(cartDao()); 
		return cartSvc;
	}
}
