package ctrl;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import svc.*;
import vo.*;


@Controller
public class ServiceCtrl {
	private NoticeListSvc noticeListSvc;

	public void setNoticeListSvc(NoticeListSvc noticeListSvc) {
		this.noticeListSvc = noticeListSvc;
	}
	@GetMapping("/service")
	public String noticeList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		List<NoticeList> noticeList = noticeListSvc.getNoticeList();
		request.setAttribute("noticeList", noticeList);
		return "service/noticeList";
	}
}
