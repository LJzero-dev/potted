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
	
	public List<ProductInfo> getProductList() {	// 검색조건 들어갈 곳
		// 지정한 제품들의 목록을 List<ProductInfo>로 리턴하는 메소드
		String sql = "select * from t_product_info where pi_isview = 'y' and pi_status = 'a'";
		List<ProductInfo> productList = jdbc.query(sql, 
			(ResultSet rs, int rowNum) -> {
			ProductInfo pi = new ProductInfo(rs.getString("pi_id"), rs.getString("pcb_id"), rs.getString("pcs_id"), 
			rs.getString("pi_name"), rs.getString("pi_status"), rs.getString("pi_img1"), rs.getString("pi_img2"), 
			rs.getString("pi_img3"), rs.getString("pi_desc"), rs.getString("pi_special"), rs.getString("pi_isview"), 
			rs.getString("pi_date"), rs.getString("pi_last"), rs.getInt("pi_price"), rs.getInt("pi_cost"), rs.getInt("pi_read"), 
			rs.getInt("pi_review"), rs.getInt("pi_sale"), rs.getInt("ai_idx"), rs.getInt("pi_admin"), rs.getDouble("pi_dc"));
			return pi;
		});
		
		return productList;
	}

}
