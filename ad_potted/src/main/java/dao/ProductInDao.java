package dao;


import java.util.*;
import java.sql.*;
import javax.sql.*;
import org.springframework.jdbc.core.*;
import vo.*;

public class ProductInDao {
	private JdbcTemplate jdbc;
	
	public ProductInDao(DataSource dataSource) {
		this.jdbc = new JdbcTemplate(dataSource);
	}	
	

	public ArrayList<ProductCtgrBig> getBigList() {
	    String sql = "select * from t_product_ctgr_big";
	    ArrayList<ProductCtgrBig> bigList = (ArrayList<ProductCtgrBig>) jdbc.query(sql, (ResultSet rs, int rowNum) -> {
	        ProductCtgrBig pg = new ProductCtgrBig();
	        pg.setPcb_id(rs.getString("pcb_id"));
	        pg.setPcb_name(rs.getString("pcb_name"));
	        
	        return pg;
	    });

	    return bigList;
	}

	public ArrayList<ProductCtgrSmall> getSmallList() {
		String sql = "select * from t_product_ctgr_small";
	    ArrayList<ProductCtgrSmall> smallList = (ArrayList<ProductCtgrSmall>) jdbc.query(sql, (ResultSet rs, int rowNum) -> {
	        ProductCtgrSmall ps = new ProductCtgrSmall();
	        ps.setPcb_id(rs.getString("pcb_id"));
	        ps.setPcs_id(rs.getString("pcs_id"));
	        ps.setPcs_name(rs.getString("pcs_name"));
	        
	        return ps;
	    });

	    return smallList;
	}


	public int productInsert(ProductInfo pi, ProductOptionInfo po) {
		Random random = new Random();
	    int randomValue = random.nextInt(1000); // 0 이상 999 이하의 랜덤한 정수 생성

		String sql = "insert into t_product_info values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, now(), ?)";
		int result = jdbc.update(sql, pi.getPcs_id() + String.format("%03d", randomValue), pi.getPcb_id(), pi.getPcs_id(), pi.getPi_name(), pi.getPi_price(), pi.getPi_cost(), pi.getPi_dc(), pi.getPi_status(), pi.getPi_img1(), pi.getPi_img2(), pi.getPi_img3(), pi.getPi_desc(), pi.getPi_stock(), pi.getPi_date(), pi.getAi_idx());
		
		return result;
	}

}
