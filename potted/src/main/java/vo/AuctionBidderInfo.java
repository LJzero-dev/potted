package vo;

public class AuctionBidderInfo {
	private int abi_idx, abi_price;
	private String pi_id, mi_id, pai_date;	
	public AuctionBidderInfo(int abi_idx, int abi_price, String pi_id, String mi_id, String pai_date) {
		this.abi_idx = abi_idx;
		this.abi_price = abi_price;
		this.pi_id = pi_id;
		this.mi_id = mi_id;
		this.pai_date = pai_date;
	}
	public int getAbi_idx() {
		return abi_idx;
	}
	public void setAbi_idx(int abi_idx) {
		this.abi_idx = abi_idx;
	}
	public int getAbi_price() {
		return abi_price;
	}
	public void setAbi_price(int abi_price) {
		this.abi_price = abi_price;
	}
	public String getPi_id() {
		return pi_id;
	}
	public void setPi_id(String pi_id) {
		this.pi_id = pi_id;
	}
	public String getMi_id() {
		return mi_id;
	}
	public void setMi_id(String mi_id) {
		this.mi_id = mi_id;
	}
	public String getPai_date() {
		return pai_date;
	}
	public void setPai_date(String pai_date) {
		this.pai_date = pai_date;
	}
	
}
