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
	/*
	public int replyIn() {
		int result = freeDao.replyIn();
		return result;
	}*/
	
	
	public int replyDel(int fridx, int flidx) {
		int result = freeDao.replyDel(fridx, flidx);
		return result;
	}

	public int freeInsert(FreeList fl) {
		int result = freeDao.freeInsert(fl);
		return result;
	}

	public int replyInsert(String miid, String fr_content, int flidx) {
		int result = freeDao.replyInsert(miid, fr_content, flidx);
		return result;
	}
	
	public int flDel(int idx) {
		int result = freeDao.flDel(idx);
		return result;
	}
	
}
