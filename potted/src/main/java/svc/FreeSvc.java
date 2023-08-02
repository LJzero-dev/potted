package svc;

import java.util.*;
import dao.*;
import vo.*;

public class FreeSvc {
	private FreeDao freeDao;

	public void setFreeDao(FreeDao freeDao) {
		this.freeDao = freeDao;
	}

	public int getFreeListCount(String where) {
		int rcnt = freeDao.getFreeListCount(where);
		return rcnt;
	}

	public List<FreeList> getFreeList(String where, int cpage, int psize) {
		List<FreeList> freeList = freeDao.getFreeList(where, cpage, psize);
		return freeList;
	}


	public FreeList getFreeInfo(int flidx) {
		FreeList fl = freeDao.getFreeInfo(flidx);
		return fl;
		
	}

	public List<ReplyList> getReplyList(int flidx) {
		List<ReplyList> replyList= freeDao.getReplyList(flidx);
		return replyList;
	}
	
}
