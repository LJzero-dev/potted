package svc;

import dao.MemberDao;

public class MemberSvc {
	private MemberDao memberDao;
	public void setMemberDao(MemberDao memberDao) {
		this.memberDao = memberDao;
	}	
}
