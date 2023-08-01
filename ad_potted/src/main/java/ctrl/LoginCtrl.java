package ctrl;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import svc.LoginSvc;
import vo.AdminInfo;

@Controller
public class LoginCtrl {
	private LoginSvc loginSvc;

	public void setLoginSvc(LoginSvc loginSvc) {
		this.loginSvc = loginSvc;
	}
	@GetMapping	("/")// 요청(loginSpr)을 get방식으로 받았을 경우
	public String loginForm() {
		return "loginForm";
	}
	
	@PostMapping ("/login")
	public String loginProc(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String uid = request.getParameter("uid").trim().toLowerCase();
		String pwd = request.getParameter("pwd").trim();
		AdminInfo loginInfo = loginSvc.getLoginInfo(uid, pwd);

		if (loginInfo == null) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('아이디와 암호를 확인하세요.')");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		} else {
			HttpSession session = request.getSession();
			session.setAttribute("loginInfo", loginInfo);
		}
		
		
		return "redirect:/index";
	}

}
