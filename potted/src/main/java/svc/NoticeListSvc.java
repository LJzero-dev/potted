package svc;

import java.util.*;
import dao.*;
import vo.*;


public class NoticeListSvc {
	private NoticeListDao noticeListDao;
	public void setNoticeListDao(NoticeListDao noticeListDao) {
		this.noticeListDao = noticeListDao;
		}
	public List<NoticeList> getNoticeList() {
		List<NoticeList> noticeList = noticeListDao.getNoticeList();
		return noticeList;
	}
}


