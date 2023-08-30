package ctrl;

import java.time.LocalDate;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.*;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import svc.*;
import vo.*;

@Controller
public class SalesSlipCtrl {
	@Autowired
	SalesSlipSvc salesSlipSvc;

	public void setSalesSlipSvc(SalesSlipSvc salesSlipSvc) {
		this.salesSlipSvc = salesSlipSvc;
	}
	
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
	
	@GetMapping("/memberChart") 
	public String memberChart(Model model, HttpServletRequest request) throws Exception {
		/*request.setCharacterEncoding("utf-8");
		String kind = request.getParameter("kind");
		String select = "", where = "", orderBy = "";
		if (kind.equals("a")) {
			select = "";
		}*/
		request.setCharacterEncoding("utf-8");
		
		int curYear, curMonth, curDay, schYear, schMonth, schDay, schLast;
		LocalDate today = LocalDate.now();	// ���� ��¥�� ���� �ν��Ͻ� ����
		curYear = today.getYear();
		curMonth = today.getMonthValue();
		curDay = today.getDayOfMonth();

		if (request.getParameter("schYear") == null) {
			// �˻��� ����� ���� ��� ���� ��¥�� �޷����� �˻�
				schYear = curYear;	schMonth = curMonth;	schDay = curDay;
		} else {
			schYear = Integer.parseInt(request.getParameter("schYear"));
			schMonth = Integer.parseInt(request.getParameter("schMonth"));
			schDay = 1;
		}
		System.out.println(schYear + ":::" + schMonth);

		CalendarInfo ci = new CalendarInfo();
		ci.setCurYear(curYear);	ci.setCurMonth(curMonth);	ci.setCurDay(curDay);
		ci.setSchYear(schYear);	ci.setSchMonth(schMonth);	ci.setSchDay(schDay);

		LocalDate edate = LocalDate.of(schYear, schMonth, 1);
		ci.setSchLast(edate.lengthOfMonth());	// ����
		ci.setsWeek(edate.getDayOfWeek().getValue());	// 1���� ���Ϲ�ȣ
		
		List<MemberInfo> memberInfo = salesSlipSvc.getMemberInfo(schYear, schMonth);


		request.setAttribute("ci", ci);
		
		request.setAttribute("memberInfo", memberInfo);
		
		return "sales/memberChart";
	}
}
