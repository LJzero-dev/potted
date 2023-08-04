package config;

import org.apache.tomcat.jdbc.pool.*;
import org.springframework.context.annotation.*;
import dao.*;
import svc.*;

@Configuration
public class MemberConfig {
// 회원 관련 작업 설정 클래스 
	
	@Bean
	public LoginDao loginDao() {
		return new LoginDao(DbConfig.dataSource());
	}
	
	@Bean
	public LoginSvc loginSvc() {
		LoginSvc loginSvc = new LoginSvc();
		loginSvc.setLoginDao(loginDao());
		return loginSvc;
	}
}
