package svc;

import java.util.List;

import dao.*;
import vo.*;

public class OrderSvc {
	private OrderDao orderDao;

	public void setOrderDao(OrderDao orderDao) {
		this.orderDao = orderDao;
	}

	public List<OrderInfo> getOrderList(int cpage, int psize) {
		List<OrderInfo> OrderList = orderDao.getOrderList(cpage, psize);
		return OrderList;
	}

	public int getOrderListCount() {
		int result = orderDao.getOrderListCount();
		return result;
	}

	public OrderInfo getOrderInfo(String oiid) {
		OrderInfo orderInfo = orderDao.getOrderInfo(oiid);
		return orderInfo;
	}

	public int getOrderState(String oi_status, String oiid) {
		int result = orderDao.getOrderStatus(oi_status, oiid);
		return result;
	}

}
