package config;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;

import config.CtrlConfig.LoginRequired;

public class LoginInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
    	if (handler instanceof HandlerMethod) {
             HandlerMethod handlerMethod = (HandlerMethod) handler;
             LoginRequired loginRequiredAnnotation = handlerMethod.getMethodAnnotation(LoginRequired.class);
             if (loginRequiredAnnotation != null) {
                 if (!isLoggedIn(request, response)) {
                    response.sendRedirect("/potted/login");
                    return false;
                 }
             }
         }
         return true;
     }
     private boolean isLoggedIn(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	 HttpSession session = request.getSession();
    	 if (session.getAttribute("loginInfo") != null) return true; 
    	 
     	 response.setContentType("text/html; charset=utf-8");
  		 PrintWriter out = response.getWriter();
  		 // 세션에 이동할 url 저장한뒤에 loginform에서 있는지 여부 확인하고 있으면 로그인 후 그 url으로 보냄
  //		 System.out.println(request.getRequestURL());
  		 out.println("<script>");
  		 out.println("alert('로그인 하셔야 이용하실 수 있습니다.');");
  		 out.println("location.href='/potted/login';");
  		 out.println("</script>");
  		 out.close();

         return false;
     }
 }