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

	public int cartDel(int ocidx, String miid) {
		int result = cartDao.cartDel(ocidx, miid);
		return result;
	}

	public int cartUp(int ocidx, String miid, int cnt, String num, int stock) {
		int result = cartDao.cartUp(ocidx, miid, cnt, num, stock);
		return result;
	}




}
