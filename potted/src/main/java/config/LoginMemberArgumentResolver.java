package config;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.core.MethodParameter;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;

import config.CtrlConfig.Login;
import lombok.extern.slf4j.Slf4j;
import vo.MemberInfo;

@Slf4j
public class LoginMemberArgumentResolver implements HandlerMethodArgumentResolver {
	
	@Override
	public boolean supportsParameter(MethodParameter parameter) {
		boolean hasLoginAnnotation = parameter.hasParameterAnnotation(Login.class);
		boolean hasMemberType = MemberInfo.class.isAssignableFrom(parameter.getParameterType());
		return hasLoginAnnotation && hasMemberType;
	}

	@Override
	public Object resolveArgument(MethodParameter parameter, ModelAndViewContainer mavContainer,NativeWebRequest webRequest, WebDataBinderFactory binderFactory) throws Exception {
		HttpServletRequest request = (HttpServletRequest) webRequest.getNativeRequest();
		HttpSession session = request.getSession();
		if (session == null) {
			return null;
		}
		return session.getAttribute("loginInfo");
	}
	
	
}
