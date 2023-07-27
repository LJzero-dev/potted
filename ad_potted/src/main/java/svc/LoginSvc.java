package svc;

import dao.*;
import vo.*;

public class LoginSvc {
	private LoginDao loginDao;

	public void setLoginDao(LoginDao loginDao) {
		this.loginDao = loginDao;
	}
	
	public AdminInfo getLoginInfo(String uid, String pwd) {
		AdminInfo ai = loginDao.getLoginInfo(uid, pwd);
		return ai;
	}
}
