package config;

import org.springframework.context.annotation.*;
import ctrl.*;

@Configuration
public class CtrlConfig {
// ������ ���� ��Ʈ�ѷ����� ������ ������ ��Ͻ�Ű�� Ŭ����
/*	@Bean
	public IndexCtrl indexCtrl() {
		return new IndexCtrl();
	}*/
	
	@Bean
	public ProductCtrl productProcInCtrl() {
		return new ProductCtrl();
	}
}
