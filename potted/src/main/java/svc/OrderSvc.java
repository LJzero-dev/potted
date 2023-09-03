package svc;

import java.util.*;
import dao.*;
import vo.*;

public class OrderSvc {
	private OrderDao orderDao;

	public void setOrderDao(OrderDao orderDao) {
		this.orderDao = orderDao;
	}

	public List<OrderCart> getBuyList(String kind, String sql) {
		List<OrderCart> pdtList = orderDao.getBuyList(kind, sql);
		return pdtList;
	}

	public ArrayList<MemberAddr> getAddrList(String miid) {
		ArrayList<MemberAddr> addrList = orderDao.getAddrList(miid);
		return addrList;
	}

	public int orderInsert(OrderInfo oi, OrderDetail od) {
		int result = orderDao.orderInsert(oi, od);
		   return result;
	}
}
