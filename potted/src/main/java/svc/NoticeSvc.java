package svc;

import java.util.*;
import dao.*;
import vo.*;

public class NoticeSvc {
	private NoticeDao noticeDao;
	
	public void setNoticeListDao(NoticeDao noticeDao) {
		this.noticeDao = noticeDao;
	}
	
	public List<NoticeList> getNoticeList(SpageInfo si) {
		List<NoticeList> noticeList = noticeDao.getNoticeList(si);
				return noticeList;
	}
	

}
