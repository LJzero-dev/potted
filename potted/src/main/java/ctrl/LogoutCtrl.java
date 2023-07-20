package ctrl;

import javax.servlet.http.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;


@Controller
public class LogoutCtrl {
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		// session�� �������� �����ϴ� ���� ���������� ���������� �ο� 
		// 30���� ������ session�� �������� ���� �ƴ϶� �ٸ� ������ �ο��� -> ���ǿ� �ִ� �����͵��� ����
		return "redirect:/";
	}
}
