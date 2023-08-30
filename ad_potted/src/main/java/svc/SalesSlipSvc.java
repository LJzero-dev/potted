package svc;

import java.util.List;

import dao.*;
import vo.MemberInfo;

public class SalesSlipSvc {
	private SalesSlipDao salesSlipDao;
	
	public void setSalesSlipDao(SalesSlipDao salesSlipDao) {
		this.salesSlipDao = salesSlipDao;	
	}
	
	public List<MemberInfo> getMemberInfo(int y, int m) {
		List<MemberInfo> memberInfo = salesSlipDao.getMemberInfo(y, m);
		return memberInfo;
	}
}
