package ctrl;

import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

import svc.LoginSvcSpr;

@Controller
public class ServiceCtrl {
	private NoticeSvc noticeSvc;

	public void setNoticeSvc(NoticeSvc noticeSvc) {
		this.noticeSvc = noticeSvc;
	}
		@GetMapping("/service")
		public String serviceCtrl() {
			return "service/noticeList";
	}
}
