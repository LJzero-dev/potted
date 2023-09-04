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
		request.setCharacterEncoding("utf-8");
		String kind = request.getParameter("kind");
		String year = request.getParameter("year");
		PageInfo pageInfo = new PageInfo();
		pageInfo.setOb(kind);
		pageInfo.setSch(year);
		String sql = "";
		
		if (kind.equals("a") || kind.equals("b")) {
			sql = "select sum(a.oi_pay) sales, mid(a.oi_date, 6, 2) smonth, mid(a.oi_date, 1, 4) syear, (sum(a.oi_pay) - sum(b.pi_cost)) realprice, mid(a.oi_date, 1, 4) pcb from t_order_info a, t_product_info b where a.pi_id = b.pi_id and oi_type = 'a' and mid(oi_date, 1, 4) = '" + year + "' group by smonth, syear order by smonth asc";
		} else if (kind.equals("c")) {
			sql = "select sum(a.oi_pay) sales, mid(a.pi_id, 1, 2) pcb, (sum(a.oi_pay) - sum(b.pi_cost)) realprice, sum(a.oi_pay) smonth from t_order_info a, t_product_info b where mid(a.pi_id, 1, 2) = mid(b.pi_id, 1, 2) and mid(a.oi_date, 1, 4) = '" + year + "' and a.oi_type = 'a' group by pcb";
		} else {
			sql = "select sum(a.oi_pay) sales, mid(a.oi_date, 6, 2) smonth, mid(a.oi_date, 1, 4) syear, (sum(a.oi_pay) - sum(b.pi_cost)) realprice, mid(a.oi_date, 1, 4) pcb from t_order_info a, t_product_info b where a.pi_id = b.pi_id and oi_type = 'b' and mid(oi_date, 1, 4) = '" + year + "' group by smonth, syear order by smonth asc";
		}
		
		
		List<SalesSlip> salesSlipList = salesSlipSvc.getSalesSlipList(sql);
		request.setAttribute("salesSlipList", salesSlipList);
		request.setAttribute("pageInfo", pageInfo);
		
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
		LocalDate today = LocalDate.now();
		curYear = today.getYear();
		curMonth = today.getMonthValue();
		curDay = today.getDayOfMonth();

		if (request.getParameter("schYear") == null) {
				schYear = curYear;	schMonth = curMonth;	schDay = curDay;
		} else {
			schYear = Integer.parseInt(request.getParameter("schYear"));
			schMonth = Integer.parseInt(request.getParameter("schMonth"));
			schDay = 1;
		}
//		System.out.println(schYear + ":::" + schMonth);

		CalendarInfo ci = new CalendarInfo();
		ci.setCurYear(curYear);	ci.setCurMonth(curMonth);	ci.setCurDay(curDay);
		ci.setSchYear(schYear);	ci.setSchMonth(schMonth);	ci.setSchDay(schDay);

		LocalDate edate = LocalDate.of(schYear, schMonth, 1);
		ci.setSchLast(edate.lengthOfMonth());	// ����
		ci.setsWeek(edate.getDayOfWeek().getValue());	// 1���� ���Ϲ�ȣ
		
		List<MemberInfo> memberInfo = salesSlipSvc.getMemberInfo(schYear, schMonth);

		request.setAttribute("ci", ci);
		request.setAttribute("memberInfo", memberInfo);
		
		// ���̺� ȸ�� ��
		List<MemberInfo> memberAge = salesSlipSvc.getMemberAge();
		request.setAttribute("memberAge", memberAge);
		
		return "sales/memberChart";
	}
}
