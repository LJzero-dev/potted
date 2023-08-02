package ctrl;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.*;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import svc.*;

@Controller
public class SalesSlipCtrl {
	/*@Autowired
	SalesSlipSvc salesSlipSvc;

	public void setSalesSlipSvc(SalesSlipSvc salesSlipSvc) {
		this.salesSlipSvc = salesSlipSvc;
	}*/
	
	@GetMapping("salesSlip")
	public String salesSlip(Model model, HttpServletRequest request) throws Exception {
		/*request.setCharacterEncoding("utf-8");
		String kind = request.getParameter("kind");
		String select = "", where = "", orderBy = "";
		if (kind.equals("a")) {
			select = "";
		}*/
		
		return "sales/salesSlip";
	}
}
