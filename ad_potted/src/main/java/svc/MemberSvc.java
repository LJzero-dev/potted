package svc;

import java.util.List;

import dao.MemberDao;
import vo.MemberInfo;

public class MemberSvc {
	private MemberDao memberDao;
	public void setMemberDao(MemberDao memberDao) {
		this.memberDao = memberDao;
	}
	public List<MemberInfo> getMemberList(int cpage, int psize) {
		List<MemberInfo> memberList = memberDao.getMemberList(cpage, psize);
		return memberList;
	}
	public int getMemberCount() {
		int rcnt = memberDao.getMemberCount();
		return rcnt;
	}
	public MemberInfo getMemberInfo(String miid) {
		MemberInfo memberInfo = memberDao.getMemberInfo(miid);
		return memberInfo;
	}
	
}
