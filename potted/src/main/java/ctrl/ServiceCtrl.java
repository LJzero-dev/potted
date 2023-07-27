package ctrl;

import java.io.*;
import java.time.LocalDate;
import java.util.List;
import javax.servlet.http.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;
import svc.*;
import vo.*;

@Controller
public class ServiceCtrl {
	private NoticeSvc noticeSvc;

	public void setNoticeSvc(NoticeSvc noticeSvc) {
		this.noticeSvc = noticeSvc;
	}
	@GetMapping("/service")
	public String noticeList(Model model,HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String schtype = request.getParameter("schtype");
		String keyword = request.getParameter("keyword");
		String args = request.getParameter("args");

		SpageInfo si = new SpageInfo(schtype, keyword, args);
		List<NoticeList> noticeList = noticeSvc.getNoticeList(si);
		request.setAttribute("noticeList", noticeList);
		model.addAttribute("si", si);

		return "service/noticeList";
	}
	
	@GetMapping("/noticeView")
	public String noticeView() {
		return "service/noticeView";
	}

}
