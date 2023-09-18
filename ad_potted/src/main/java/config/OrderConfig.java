package config;

import org.springframework.context.annotation.*;

import dao.*;
import svc.*;

@Configuration
public class OrderConfig {
	@Bean
	public OrderDao orderDao() {
		return new OrderDao(DbConfig.dataSource());
	}
	
	@Bean
	public OrderSvc orderSvc() {
		OrderSvc orderSvc = new OrderSvc();
		orderSvc.setOrderDao(orderDao());
		return orderSvc;
	}
}
