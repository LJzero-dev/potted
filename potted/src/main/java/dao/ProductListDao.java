package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import vo.AuctionBidderInfo;
import vo.PageInfo;
import vo.ProductAuctionInfo;
import vo.ProductInfo;
import vo.ProductOptionBig;
import vo.ProductOptionStock;

public class ProductListDao {
	private JdbcTemplate jdbc;
	
	public ProductListDao(DataSource dataSource) {
		this.jdbc = new JdbcTemplate(dataSource);
	}
	
	public List<ProductInfo> getProductList(PageInfo pageInfo) {	// �˻����� �� ��
		// ������ ��ǰ���� ����� List<ProductInfo>�� �����ϴ� �޼ҵ�
		String sql = "select * from t_product_info a, t_product_ctgr_big b, t_product_ctgr_small c " + pageInfo.getWhere() + " and a.pcs_id = c.pcs_id and b.pcb_id = c.pcb_id group by a.pi_id " + pageInfo.getOrderby() + " limit " + ((pageInfo.getCpage() - 1) * pageInfo.getPsize()) + ", " + pageInfo.getPsize();
		System.out.println(sql);
		List<ProductInfo> productList = jdbc.query(sql, 
			(ResultSet rs, int rowNum) -> {
			ProductInfo pi = new ProductInfo(rs.getString("pi_id"), rs.getString("pcb_id"), rs.getString("pcs_id"), rs.getString("pi_name"), 
			rs.getString("pi_status"), rs.getString("pi_img1"), rs.getString("pi_img2"), rs.getString("pi_img3"), rs.getString("pi_desc"), 
			rs.getString("pi_special"), rs.getString("pi_isview"), rs.getString("pi_date"), rs.getString("pi_last"), rs.getInt("pi_price"), 
			rs.getInt("pi_cost"), rs.getInt("pi_read"), rs.getInt("pi_review"), rs.getInt("pi_sale"), rs.getInt("ai_idx"), rs.getInt("pi_admin"), 
			rs.getDouble("pi_dc"), rs.getString("pcb_name"), rs.getString("pcs_name"), rs.getInt("pi_stock"));
			if (rs.getString("pi_auction").equals("y")) {
				List<ProductAuctionInfo> productAuctionInfo = jdbc.query("select pai_idx, pai_bidder, pai_price, pi_id, pai_runtime, pai_start,  date_add(date_add(date_add(pai_start, interval left(pai_runtime,2) day), interval mid(pai_runtime,4,2) hour), interval right(pai_runtime,2) minute) end, pai_id from t_product_auction_info where pi_id = '" + rs.getString("pi_id") + "'", 
						(ResultSet rs2, int rowNum2) -> {
							ProductAuctionInfo pai = new ProductAuctionInfo(rs2.getInt("pai_idx"), rs2.getInt("pai_bidder"), rs2.getInt("pai_price"), rs2.getString("pi_id"), rs2.getString("pai_runtime"), rs2.getString("pai_start"), rs2.getString("end"), rs2.getString("pai_id"));
							return pai;
						});
				pi.setProductAuctionInfo(productAuctionInfo.size() != 0 ? productAuctionInfo.get(0) : null);
			}
			
			return pi;
		});		
		return productList;
	}

	public int getProductCount(String where) {
		String sql = "select count(*) from t_product_info a " + where;
		int rcnt = jdbc.queryForObject(sql, Integer.class);
		return rcnt;
	}
	

	public int readUpdate(String piid) {
		String sql = "update t_product_info set pi_read = pi_read + 1 where pi_id = '" + piid + "' ";
		int result = jdbc.update(sql);
		return result;
	}

	public ProductInfo getProductInfo(String piid) {
		int result = readUpdate(piid);
		String sql = "select * from t_product_info a, t_product_ctgr_big b, t_product_ctgr_small c where a.pcs_id = c.pcs_id and b.pcb_id = c.pcb_id and a.pi_isview = 'y' and a.pi_id = '" + piid + "' ";
		ProductInfo pi = jdbc.queryForObject(sql,
			new RowMapper<ProductInfo>() {
				@Override
				public ProductInfo mapRow(ResultSet rs, int rowNum) throws SQLException {
					ProductInfo pi = new ProductInfo(rs.getString("pi_id"), rs.getString("pcb_id"), rs.getString("pcs_id"), rs.getString("pi_name"), 
							rs.getString("pi_status"), rs.getString("pi_img1"), rs.getString("pi_img2"), rs.getString("pi_img3"), rs.getString("pi_desc"), 
							rs.getString("pi_special"), rs.getString("pi_isview"), rs.getString("pi_date"), rs.getString("pi_last"), rs.getInt("pi_price"), 
							rs.getInt("pi_cost"), rs.getInt("pi_read"), rs.getInt("pi_review"), rs.getInt("pi_sale"), rs.getInt("ai_idx"), rs.getInt("pi_admin"), 
							rs.getDouble("pi_dc"), rs.getString("pcb_name"), rs.getString("pcs_name"), rs.getInt("pi_stock"));
					if (rs.getString("pi_auction").equals("y")) {
						List<ProductAuctionInfo> productAuctionInfo = jdbc.query("select (now() > date_add(date_add(date_add(pai_start, interval left(pai_runtime,2) day), interval mid(pai_runtime,4,2) hour), interval right(pai_runtime,2) minute)) isend, pai_idx, pai_bidder, pai_price, pi_id, pai_runtime, pai_start,  date_add(date_add(date_add(pai_start, interval left(pai_runtime,2) day), interval mid(pai_runtime,4,2) hour), interval right(pai_runtime,2) minute) end, pai_id from t_product_auction_info where pi_id = '" + rs.getString("pi_id") + "'", 
								(ResultSet rs2, int rowNum2) -> {
									ProductAuctionInfo pai = new ProductAuctionInfo(rs2.getInt("pai_idx"), rs2.getInt("pai_bidder"), rs2.getInt("pai_price"), rs2.getString("pi_id"), rs2.getString("pai_runtime"), rs2.getString("pai_start"), rs2.getString("end"), rs2.getString("pai_id"));
									pai.setIsend(rs2.getInt(1));
									
									if (rs2.getInt("pai_bidder") > 0) {
										List<AuctionBidderInfo> AuctionBidderInfo = jdbc.query("select * from t_auction_bidder_info where pi_id = '" + piid + "'",
												(ResultSet rs3, int rowNum3) -> {
													AuctionBidderInfo abi = new AuctionBidderInfo(rs3.getInt(1),rs3.getInt(4),rs3.getString(2),rs3.getString(3),rs3.getString(5));													
													return abi;
												});
										pai.setAuctionBidderInfo(AuctionBidderInfo.size() != 0 ? AuctionBidderInfo : null);
									}									
									return pai;
								});
						pi.setProductAuctionInfo(productAuctionInfo.size() != 0 ? productAuctionInfo.get(0) : null);
					}
					return pi;
				}
			}
		);		
		return pi;
	}

	public List<ProductOptionStock> getProductOptionStock(String piid) {
		String sql = "select * from t_product_option_stock where pi_id = '" + piid + "' ";
		List<ProductOptionStock> productOptionStock = jdbc.query(sql, 
				(ResultSet rs, int rowNum) -> {
				ProductOptionStock pos = new ProductOptionStock(rs.getString("pos_id"), rs.getString("pob_id"), rs.getString("pi_id"), 
						rs.getString("pos_isview"), rs.getInt("pos_stock"), rs.getInt("pos_sale"), rs.getInt("pos_idx"), rs.getInt("pos_price"));
				
				return pos;
				
			});
			
		return productOptionStock;
	}

	public List<ProductOptionBig> getProductOptionBig() {
		String sql = "select * from t_product_option_big";
		List<ProductOptionBig> productOptionBig = jdbc.query(sql,
			(ResultSet rs, int rowNum) -> {
				ProductOptionBig pob = new ProductOptionBig(rs.getString("pob_id"));
					return pob;
			}
		);		
		return productOptionBig;
	}
	
	public int setbid(int bidprice,String piid, String miid) {		
		return jdbc.update("insert into t_auction_bidder_info (pi_id,mi_id,abi_price) values ('" + piid + "','" + miid + "','" + bidprice + "')") + jdbc.update("update t_product_auction_info set pai_bidder = pai_bidder + 1, pai_price = '" + bidprice + "', pai_id = '" + miid + "' where pi_id = '" + piid + "'");
	}
}