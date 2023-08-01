package svc;

import java.util.List;

import dao.*;
import vo.*;

public class CartSvc {
	private CartDao cartDao;
	
	public void setCartDao(CartDao cartDao) {
		this.cartDao = cartDao;	
	}

	public int cartInsert(OrderCart oc) {
		int result = cartDao.cartInsert(oc);
		return result;
	}

	public List<OrderCart> getOrderCart(String miid) {
		List<OrderCart> orderCart = cartDao.getOrderCart(miid);
		return orderCart;
	}



}
