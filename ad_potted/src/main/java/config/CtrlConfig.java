package config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.*;
import ctrl.*;
import svc.*;

@Configuration
public class CtrlConfig {
// ������ ���� ��Ʈ�ѷ����� ������ ������ ��Ͻ�Ű�� Ŭ����
	@Autowired // �ʿ��� �� �˾Ƽ� ���� ��
	private ProductInSvc productInSvc;
	@Autowired
	private LoginSvc loginSvc;
	@Bean
	public ProductCtrl productCtrl() {
		ProductCtrl productCtrl = new ProductCtrl();
		productCtrl.setProductInSvc(productInSvc);
		return productCtrl; 
	}
	@Bean
	public LoginCtrl loginCtrl() {
		LoginCtrl loginCtrl = new LoginCtrl();
		loginCtrl.setLoginSvc(loginSvc);
		return loginCtrl; 
	}
}
