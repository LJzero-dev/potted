package svc;

import java.util.*;
import dao.*;
import vo.*;

public class NoticeSvc {
	private NoticeDao noticeDao;
	
	public void setNoticeListDao(NoticeDao noticeDao) {
		this.noticeDao = noticeDao;
	}
	
	public int getNoticeListCount(String where) {
		int rcnt = noticeDao.getNoticeListCount(where);
		return rcnt;
	}
	
	public List<NoticeList> getNoticeList(String where, int cpage, int psize) {
		List<NoticeList> noticeList = noticeDao.getNoticeList(where, cpage, psize);
		return noticeList;
	}

	public NoticeList getNoticeInfo(int nlidx) {
		NoticeList nl = noticeDao.getNoticeInfo(nlidx);
		return nl;
	}

}
