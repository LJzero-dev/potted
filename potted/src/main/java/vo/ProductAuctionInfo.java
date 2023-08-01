package vo;

public class ProductAuctionInfo {
	private int pai_idx, pai_bidder, pai_price;
	private String pi_id, pai_runtime, pai_start, pai_end, pai_id;
		public ProductAuctionInfo(int pai_idx, int pai_bidder, int pai_price, String pi_id, String pai_runtime,	String pai_start, String pai_end, String pai_id) {
		this.pai_idx = pai_idx;	this.pai_bidder = pai_bidder;	this.pai_price = pai_price;	this.pi_id = pi_id;	this.pai_runtime = pai_runtime;	this.pai_start = pai_start;	this.pai_end = pai_end;	this.pai_id = pai_id;
	}
	public int getPai_idx() {
		return pai_idx;
	}
	public void setPai_idx(int pai_idx) {
		this.pai_idx = pai_idx;
	}
	public int getPai_bidder() {
		return pai_bidder;
	}
	public void setPai_bidder(int pai_bidder) {
		this.pai_bidder = pai_bidder;
	}
	public int getPai_price() {
		return pai_price;
	}
	public void setPai_price(int pai_price) {
		this.pai_price = pai_price;
	}
	public String getPi_id() {
		return pi_id;
	}
	public void setPi_id(String pi_id) {
		this.pi_id = pi_id;
	}
	public String getPai_runtime() {
		return pai_runtime;
	}
	public void setPai_runtime(String pai_runtime) {
		this.pai_runtime = pai_runtime;
	}
	public String getPai_start() {
		return pai_start;
	}
	public void setPai_start(String pai_start) {
		this.pai_start = pai_start;
	}
	public String getPai_end() {
		return pai_end;
	}
	public void setPai_end(String pai_end) {
		this.pai_end = pai_end;
	}
	public String getPai_id() {
		return pai_id;
	}
	public void setPai_id(String pai_id) {
		this.pai_id = pai_id;
	}
	
	
}
