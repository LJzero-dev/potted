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

	public int chkDupId(String uid) {
		int result = memberDao.chkDupId(uid);
		return result;
	}

	public List<OrderInfo> getAuctionOrderList(String miid, int cpage, int psize) {
		List<OrderInfo> auctionOrderList = memberDao.getAuctionOrderList(miid, cpage, psize);
		return auctionOrderList;
	}

	public int getAuctionOrderListCount(String miid) {
		int result = memberDao.getAuctionOrderListCount(miid);
		return result;
	}

	public int memberInsert(MemberInfo mi, MemberAddr ma) {
		int result = memberDao.memberInsert(mi, ma);
		return result;
	}

	public List<MemberAddr> getMemberAddrList(String miid) {
		List<MemberAddr> memberAddrList = memberDao.getMemberAddrList(miid);
		return memberAddrList;
	}

	public MemberAddr getMemberAddr(String miid, int maidx) {
		MemberAddr ma = memberDao.getMemberAddr(miid, maidx);
		return ma;
	}

	public int addrInsert(MemberAddr ma, int idx) {
		int result = memberDao.addrInsert(ma, idx);
		return result;
	}

	public int addrUpdate(MemberAddr ma) {
		int result = memberDao.addrUpdate(ma);
		return result;
	}

	public int memberOut(String miid) {
		int result = memberDao.memberOut(miid);
		return result;
	}


}
