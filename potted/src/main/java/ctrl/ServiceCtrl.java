package ctrl;

import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import svc.*;


@Controller
public class ServiceCtrl {
	private NoticeListSvc noticeListSvc;

	public void setNoticeSvc(NoticeListSvc noticeListSvc) {
		this.noticeListSvc = noticeListSvc;
	}
	@GetMapping("/service")
	public String noticeList() {
		return "service/noticeList";
	}
}
