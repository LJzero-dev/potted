package vo;

public class ProductOptionStock {
	private String pos_id, pob_id, pi_id, pos_isview;
	private int pos_stock, pos_sale;
	
	public ProductOptionStock(String pos_id, String pob_id, String pi_id, String pos_isview, int pos_stock, int pos_sale) {
		this.pos_id = pos_id;		this.pob_id = pob_id;		this.pi_id = pi_id;			
		this.pos_isview = pos_isview;	this.pos_stock = pos_stock;		this.pos_sale = pos_sale;
	}
	
	public String getPos_id() {
		return pos_id;
	}
	public void setPos_id(String pos_id) {
		this.pos_id = pos_id;
	}
	public String getPob_id() {
		return pob_id;
	}
	public void setPob_id(String pob_id) {
		this.pob_id = pob_id;
	}
	public String getPi_id() {
		return pi_id;
	}
	public void setPi_id(String pi_id) {
		this.pi_id = pi_id;
	}
	public String getPos_isview() {
		return pos_isview;
	}
	public void setPos_isview(String pos_isview) {
		this.pos_isview = pos_isview;
	}
	public int getPos_stock() {
		return pos_stock;
	}
	public void setPos_stock(int pos_stock) {
		this.pos_stock = pos_stock;
	}
	public int getPos_sale() {
		return pos_sale;
	}
	public void setPos_sale(int pos_sale) {
		this.pos_sale = pos_sale;
	}
	
	
	
}
