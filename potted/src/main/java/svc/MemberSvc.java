package svc;

import java.util.List;
import dao.*;
import vo.*;

public class MemberSvc {
	private MemberDao memberDao;

	public void setMemberDao(MemberDao memberDao) {
		this.memberDao = memberDao;
	}

	public List<MemberPoint> getMemberPoint(String miid, int cpage, int psize) {
		List<MemberPoint> memberPoint = memberDao.getMemberPoint(miid, cpage, psize);
		return memberPoint;
	}

	public int getMemberPointListCount(String miid) {
		int result = memberDao.getMemberPointListCount(miid);
		return result;
	}

	public List<OrderInfo> getOrderList(String miid, int cpage, int psize) {
		List<OrderInfo> OrderList = memberDao.getOrderList(miid, cpage, psize);
		return OrderList;
	}

	public int getOrderListCount(String miid) {
		int result = memberDao.getOrderListCount(miid);
		return result;
	}

}
