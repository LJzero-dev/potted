package svc;

import java.util.*;
import dao.*;
import vo.*;

public class NoticeSvc {
	private NoticeDao noticeDao;
	
	public void setNoticeListDao(NoticeDao noticeDao) {
		this.noticeDao = noticeDao;
	}
	
	public List<NoticeList> getNoticeList() {
		List<NoticeList> noticeList = noticeDao.getNoticeList();
				return noticeList;
	}
}
