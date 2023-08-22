package svc;

import java.util.*;
import dao.*;
import vo.*;

public class QnaSvc {
	private QnaDao qnaDao;
	
	public void setQnaListDao(QnaDao qnaDao) {
		this.qnaDao = qnaDao;
	}

	public int getQnaListCount(String where) {
		int rcnt = qnaDao.getQnaListCount(where);
		return rcnt;
	}

	public List<QnaList> getQnaList(String where, int cpage, int psize) {
		List<QnaList> qnaList = qnaDao.getQnaList(where, cpage, psize);
		return qnaList;
	}
}
