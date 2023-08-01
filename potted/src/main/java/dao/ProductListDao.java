package dao;

import java.util.*;
import java.sql.*;
import javax.sql.*;
import org.springframework.jdbc.core.*;
import org.springframework.jdbc.support.*;
import svc.*;
import vo.*;

public class ProductListDao {
	private JdbcTemplate jdbc;
	
	public ProductListDao(DataSource dataSource) {
		this.jdbc = new JdbcTemplate(dataSource);
	}
	
	public List<ProductInfo> getProductList(PageInfo pageInfo) {	// 검색조건 들어갈 곳
		// 지정한 제품들의 목록을 List<ProductInfo>로 리턴하는 메소드
		String sql = "select * from t_product_info a, t_product_ctgr_big b, t_product_ctgr_small c " + pageInfo.getWhere() + " and a.pcs_id = c.pcs_id and b.pcb_id = c.pcb_id group by a.pi_id " + pageInfo.getOrderby() + " limit " + ((pageInfo.getCpage() - 1) * pageInfo.getPsize()) + ", " + pageInfo.getPsize();
		System.out.println(sql);
		List<ProductInfo> productList = jdbc.query(sql, 
			(ResultSet rs, int rowNum) -> {
			ProductInfo pi = new ProductInfo(rs.getString("pi_id"), rs.getString("pcb_id"), rs.getString("pcs_id"), rs.getString("pi_name"), 
			rs.getString("pi_status"), rs.getString("pi_img1"), rs.getString("pi_img2"), rs.getString("pi_img3"), rs.getString("pi_desc"), 
			rs.getString("pi_special"), rs.getString("pi_isview"), rs.getString("pi_date"), rs.getString("pi_last"), rs.getInt("pi_price"), 
			rs.getInt("pi_cost"), rs.getInt("pi_read"), rs.getInt("pi_review"), rs.getInt("pi_sale"), rs.getInt("ai_idx"), rs.getInt("pi_admin"), 
			rs.getDouble("pi_dc"), rs.getString("pcb_name"), rs.getString("pcs_name"), rs.getInt("pi_stock"));
			
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
		String sql = "select * from t_product_info a, t_product_ctgr_big b, t_product_ctgr_small c where a.pcs_id = c.pcs_id and b.pcb_id = c.pcb_id and a.pi_isview = 'y' and a.pi_status = 'a' and a.pi_id = '" + piid + "' ";
		ProductInfo pi = jdbc.queryForObject(sql,
			new RowMapper<ProductInfo>() {
				@Override
				public ProductInfo mapRow(ResultSet rs, int rowNum) throws SQLException {
					ProductInfo pi = new ProductInfo(rs.getString("pi_id"), rs.getString("pcb_id"), rs.getString("pcs_id"), rs.getString("pi_name"), 
							rs.getString("pi_status"), rs.getString("pi_img1"), rs.getString("pi_img2"), rs.getString("pi_img3"), rs.getString("pi_desc"), 
							rs.getString("pi_special"), rs.getString("pi_isview"), rs.getString("pi_date"), rs.getString("pi_last"), rs.getInt("pi_price"), 
							rs.getInt("pi_cost"), rs.getInt("pi_read"), rs.getInt("pi_review"), rs.getInt("pi_sale"), rs.getInt("ai_idx"), rs.getInt("pi_admin"), 
							rs.getDouble("pi_dc"), rs.getString("pcb_name"), rs.getString("pcs_name"), rs.getInt("pi_stock"));
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


}
