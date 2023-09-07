package ctrl;

import java.io.*;
import javax.servlet.http.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

import config.CtrlConfig.LoginRequired;
import svc.*;
import vo.*;

@Controller
@RequestMapping("/login")
public class LoginCtrl {
	private LoginSvc loginSvc;

	public void setLoginSvc(LoginSvc loginSvc) {
		this.loginSvc = loginSvc;
	}
	@GetMapping	// ��û(loginSpr)�� get������� �޾��� ���
	public String loginForm() {
		return "loginForm";
	}
	
	@PostMapping
	public String loginProc(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String uid = request.getParameter("uid").trim().toLowerCase();
		String pwd = request.getParameter("pwd").trim();
		MemberInfo loginInfo = loginSvc.getLoginInfo(uid, pwd);

		if (loginInfo == null) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('���̵�� ��ȣ�� Ȯ���ϼ���.')");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		} else {
			HttpSession session = request.getSession();
			session.setAttribute("loginInfo", loginInfo);
		}
		
		
		return "redirect:/";
	}

}
