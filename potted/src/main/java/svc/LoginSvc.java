package svc;

import dao.*;
import vo.*;

public class LoginSvc {
	private LoginDao loginDao;

	public void setLoginDao(LoginDao loginDao) {
		this.loginDao = loginDao;
	}
	
	public MemberInfo getLoginInfo(String uid, String pwd) {
		MemberInfo mi = loginDao.getLoginInfo(uid, pwd);
		return mi;
	}
}
