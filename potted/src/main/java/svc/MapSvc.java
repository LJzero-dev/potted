package svc;

import java.util.List;

import dao.*;
import vo.*;

public class MapSvc {
	private MapDao mapDao;
	
	public void setMapDao(MapDao mapDao) {
		this.mapDao = mapDao;
	}

	public List<GardenInfo> getGardenList() {
		List<GardenInfo> gardenList = mapDao.getGardenList();
		return gardenList;
	}

}
