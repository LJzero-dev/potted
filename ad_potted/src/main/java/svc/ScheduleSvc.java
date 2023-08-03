package svc;

import java.util.List;

import dao.ScheduleDao;
import vo.ScheduleInfo;

public class ScheduleSvc {
	private ScheduleDao scheduleDao;

	public void setScheduleDao(ScheduleDao scheduleDao) {
		this.scheduleDao = scheduleDao;
	}

	public List<ScheduleInfo> getScheduleList(String uid, int y, int m) {
		List<ScheduleInfo> schduleList = scheduleDao.getScheduleList(uid, y, m);
		return schduleList;
	}
	
	public int scheduleInsert(ScheduleInfo si) {
		int result = scheduleDao.scheduleInsert(si);
		return result;
	}

	public int scheduleUpdate(int idx) {
		int result = scheduleDao.scheduleUpdate(idx);
		return result;
	}
}
