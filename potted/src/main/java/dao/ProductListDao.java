package dao;

import java.util.*;
import java.sql.*;
import javax.sql.*;
import org.springframework.jdbc.core.*;
import org.springframework.jdbc.support.*;
import vo.*;

public class ProductListDao {
	private JdbcTemplate jdbc;
	
	public ProductListDao(DataSource dataSource) {
		this.jdbc = new JdbcTemplate(dataSource);
	}
	
	public ProductInfo getProductList() {
		String sql = "select * from t_product_info where pi_isview = 'y' and pi_status = 'a'";
		
		List<ProductInfo> results = jdbc.query(sql, new RowMapper<ProductInfo>() {
			public ProductInfo mapRow(ResultSet rs, int rowNum) throws SQLException {
				ProductInfo pi = new ProductInfo();
	            pi.setAi_idx(rs.getInt("ai_idx"));
	            pi.setPcb_id(rs.getString("pcb_id"));
	            pi.setPcs_id(rs.getString("pcs_id"));
	            pi.setPi_admin(rs.getInt("pi_admin"));
	            pi.setPi_cost(rs.getInt("pi_cost"));
	            pi.setPi_date(rs.getString("pi_date"));
	            pi.setPi_dc(rs.getDouble("pi_dc"));
	            pi.setPi_desc(rs.getString("pi_desc"));
	            pi.setPi_id(rs.getString("pi_id"));
	            pi.setPi_img1(rs.getString("pi_img1"));
	            pi.setPi_img2(rs.getString("pi_img2"));
	            pi.setPi_img3(rs.getString("pi_img3"));
	            pi.setPi_name(rs.getString("pi_name"));
	            pi.setPi_price(rs.getInt("pi_price"));
	            pi.setPi_review(rs.getInt("pi_review"));
	            pi.setPi_special(rs.getString("pi_special"));
	            return pi;
			}
		});
		
		return results.isEmpty() ? null : results.get(0);	// 리스트가 비어 있으면 null을 가져오고 아니면 리스트 안에있는 0번 인덱스를 리턴해라
	}
	

}
