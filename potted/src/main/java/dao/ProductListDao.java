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
	
	public List<ProductInfo> getProductList(int cpage, int psize, String where, String orderBy) {	// 검색조건 들어갈 곳
		// 지정한 제품들의 목록을 List<ProductInfo>로 리턴하는 메소드
		String sql = "select * from t_product_info a, t_product_ctgr_big b, t_product_ctgr_small c where a.pcs_id = c.pcs_id and b.pcb_id = c.pcb_id and a.pi_isview = 'y' and a.pi_status = 'a'" + where + " group by a.pi_id " + orderBy + " limit " + ((cpage - 1) * psize) + ", " + psize;
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
		String sql = "select count(*) from t_product_info a where a.pi_isview = 'y' and a.pi_status = 'a'" + where;
		int rcnt = jdbc.queryForObject(sql, Integer.class);
		return rcnt;
	}

	public ProductInfo getProductInfo(String piid) {
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

}
