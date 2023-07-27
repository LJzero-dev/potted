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

	    System.out.println("1");
	    String sql = "insert into t_product_info (pi_id, pcb_id, pcs_id, pi_name, pi_price, pi_cost, pi_dc, pi_status, pi_img1, pi_img2, pi_img3, pi_desc, pi_stock, pi_isview, ai_idx) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'y', 1)";
	    int result = jdbc.update(sql, pi.getPcs_id() + String.format("%03d", randomValue), pi.getPcb_id(), pi.getPcs_id(), pi.getPi_name(), pi.getPi_price(), pi.getPi_cost(), pi.getPi_dc(), pi.getPi_status(), pi.getPi_img1(), pi.getPi_img2(), pi.getPi_img3(), pi.getPi_desc(), pi.getPi_stock());
	    
	    if (result == 1) {
	    	String piIdQuery = "select pi_id from t_product_info WHERE pi_id = ?";
	        String piId = jdbc.queryForObject(piIdQuery, String.class, pi.getPcs_id() + String.format("%03d", randomValue));
	        
			sql = "insert into t_product_option_stock (pos_id, poi_id, pi_id, pos_isview) values (?, ?, ?, 'y')";
			result += jdbc.update(sql, po.getPos_id(), po.getPoi_id(), piId);
	    }
		
		return result;
	}

}
