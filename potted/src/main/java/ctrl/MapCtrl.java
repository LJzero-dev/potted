package ctrl;

import java.util.*;
import javax.servlet.http.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import svc.*;
import vo.*;

@Controller
public class MapCtrl {
	private MapSvc mapSvc;

	public void setMapSvc(MapSvc mapSvc) {
		this.mapSvc = mapSvc;
	}
	
	@GetMapping("/mapList")
	public String mapList(HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");
		List<GardenInfo> gardenList = mapSvc.getGardenList();
		
		request.setAttribute("gardenList", gardenList);
		
		return "service/mapList";
	}
}
