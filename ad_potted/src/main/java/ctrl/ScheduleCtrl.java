package ctrl;

import java.io.PrintWriter;
import java.time.*;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

import svc.*;
import vo.*;

@Controller
public class ScheduleCtrl {
	private ScheduleSvc scheduleSvc;

	public void setScheduleSvc(ScheduleSvc scheduleSvc) {
		this.scheduleSvc = scheduleSvc;
	}
	
	@GetMapping("/schedule")
	public String schedule(HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");

		int curYear, curMonth, curDay, schYear, schMonth, schDay, schLast;
		LocalDate today = LocalDate.now();	// 오늘 날짜를 가진 인스턴스 생성
		curYear = today.getYear();
		curMonth = today.getMonthValue();
		curDay = today.getDayOfMonth();

		if (request.getParameter("schYear") == null) {
		// 검색한 년월이 없을 경우 오늘 날짜의 달력으로 검색
			schYear = curYear;	schMonth = curMonth;	schDay = curDay;
		} else {
			schYear = Integer.parseInt(request.getParameter("schYear"));
			schMonth = Integer.parseInt(request.getParameter("schMonth"));
			schDay = 1;
		}

		CalendarInfo ci = new CalendarInfo();
		ci.setCurYear(curYear);	ci.setCurMonth(curMonth);	ci.setCurDay(curDay);
		ci.setSchYear(schYear);	ci.setSchMonth(schMonth);	ci.setSchDay(schDay);

		LocalDate edate = LocalDate.of(schYear, schMonth, 1);
		ci.setSchLast(edate.lengthOfMonth());	// 말일
		ci.setsWeek(edate.getDayOfWeek().getValue());	// 1일의 요일번호

		HttpSession session = request.getSession();
		AdminInfo ai = (AdminInfo)session.getAttribute("loginInfo");
		List<ScheduleInfo> scheduleList = scheduleSvc.getScheduleList(ai.getAi_id(), schYear, schMonth);

		request.setAttribute("ci", ci);
		request.setAttribute("scheduleList", scheduleList);

		return "schedule/schedule";
	}
	
	@GetMapping("/scheduleInForm")
	public String scheduleInForm(HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");
		int y = Integer.parseInt(request.getParameter("y"));
		int m = Integer.parseInt(request.getParameter("m"));
		int d = Integer.parseInt(request.getParameter("d"));

		CalendarInfo ci = new CalendarInfo();
		ci.setSchYear(y);	ci.setSchMonth(m);	ci.setSchDay(d);
		LocalDate schDate = LocalDate.of(y, m, d);
		ci.setSchLast(schDate.lengthOfMonth());
		LocalDate today = LocalDate.now();
		ci.setCurYear(today.getYear());

		request.setAttribute("ci", ci);

		return "schedule/scheduleInForm";
	}

	@PostMapping("/scheduleInProc")
	public String scheduleInProc(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String si_date = request.getParameter("si_date");
		String si_time = request.getParameter("si_time");
		String title = request.getParameter("title");
		String content = request.getParameter("content").trim();

		HttpSession session = request.getSession();
		AdminInfo loginInfo = (AdminInfo)session.getAttribute("loginInfo");
		ScheduleInfo si = new ScheduleInfo(0, loginInfo.getAi_id(), si_date, si_time, title, content, null);

		int result = scheduleSvc.scheduleInsert(si);
		if (result != 1) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('일정 등록에 실패했습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}

		String args = "?schYear=" + si_date.substring(0, 4) + "&schMonth=" + si_date.substring(5, 7);
		return "redirect:/schedule" + args;
	}
	
	@GetMapping("/scheduleDel")
	public String scheduleDel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		int idx = Integer.parseInt(request.getParameter("idx"));
		
		int result = scheduleSvc.scheduleUpdate(idx);
		if (result != 1) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('일정 삭제에 실패했습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		
		return "redirect:/schedule";
		
	}
}
