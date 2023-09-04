package svc;

import java.util.List;

import dao.*;
import vo.MemberInfo;
import vo.SalesSlip;

public class SalesSlipSvc {
	private SalesSlipDao salesSlipDao;
	
	public void setSalesSlipDao(SalesSlipDao salesSlipDao) {
		this.salesSlipDao = salesSlipDao;	
	}
	
	public List<MemberInfo> getMemberInfo(int y, int m) {
		List<MemberInfo> memberInfo = salesSlipDao.getMemberInfo(y, m);
		return memberInfo;
	}

	public List<MemberInfo> getMemberAge() {
		List<MemberInfo> memberAge = salesSlipDao.getMemberAge();
		return memberAge;
	}

	public List<SalesSlip> getSalesSlipList(String sql) {
		List<SalesSlip> salesSlipList = salesSlipDao.getSalesSlipList(sql);
		return salesSlipList;
	}
}
