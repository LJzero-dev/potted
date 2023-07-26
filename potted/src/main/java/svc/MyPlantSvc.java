package svc;

import dao.MyPlantDao;
import vo.MemberInfo;
import vo.MemberTree;

public class MyPlantSvc {
	private MyPlantDao myPlantDao;

	public void setMyPlantDao(MyPlantDao myPlantDao) {
		this.myPlantDao = myPlantDao;
	}

	public boolean getMtPlant(String mi_id) {
		return myPlantDao.getMtPlant(mi_id);
	}

	public int setMyPlant(String mi_id, String plant) {
		return myPlantDao.setMyPlant(mi_id,plant);
	}

	public MemberTree getMyPlant(String mi_id) {
		return myPlantDao.getMyPlant(mi_id);
	}

	public int wattering(String mi_id) {
		return myPlantDao.wattering(mi_id);
	}

	public int plantFinish(int grade, int addpoint, String mi_id) {
		int result = myPlantDao.plantFinish(grade, addpoint, mi_id);
		System.out.println(grade);
		if (grade > 0) myPlantDao.setMyPlant(mi_id, String.valueOf(grade));
		return result;
	}
}