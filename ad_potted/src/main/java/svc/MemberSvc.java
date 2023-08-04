package svc;

import java.util.List;

import dao.MemberDao;
import vo.MemberInfo;

public class MemberSvc {
	private MemberDao memberDao;
	public void setMemberDao(MemberDao memberDao) {
		this.memberDao = memberDao;
	}
	public List<MemberInfo> getMemberList() {
		List<MemberInfo> memberList = memberDao.getMemberList();
		return memberList;
	}
	
}
