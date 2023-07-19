package vo;

public class ProductStock {
// 일반 상품 재고 클래스
	private String pi_id, ps_isview;
	private int ps_idx, ps_stock, ps_sale;
	
	public String getPi_id() {
		return pi_id;
	}
	public void setPi_id(String pi_id) {
		this.pi_id = pi_id;
	}
	public String getPs_isview() {
		return ps_isview;
	}
	public void setPs_isview(String ps_isview) {
		this.ps_isview = ps_isview;
	}
	public int getPs_idx() {
		return ps_idx;
	}
	public void setPs_idx(int ps_idx) {
		this.ps_idx = ps_idx;
	}
	public int getPs_stock() {
		return ps_stock;
	}
	public void setPs_stock(int ps_stock) {
		this.ps_stock = ps_stock;
	}
	public int getPs_sale() {
		return ps_sale;
	}
	public void setPs_sale(int ps_sale) {
		this.ps_sale = ps_sale;
	}
	
	
}
