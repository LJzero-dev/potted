package ctrl;

import java.io.*;
import java.time.LocalDate;
import java.util.List;
import javax.servlet.http.*;
import org.springframework.stereotype.*;
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
	public String noticeList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		List<NoticeList> noticeList = noticeSvc.getNoticeList();
		request.setAttribute("noticeList", noticeList);
		
		return "service/noticeList";
	}

}
