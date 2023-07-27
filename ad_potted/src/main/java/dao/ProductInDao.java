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


	public int getProductCount(String where) {
		String sql = "select count(*) from t_product_info where pi_isview = 'y'" + where;
		int rcnt = jdbc.queryForObject(sql, Integer.class);
		return rcnt;
	}


	public List<ProductInfo> getProductList(PageInfo pageInfo) {
		String sql = "select * from t_product_info where pi_isview = 'y' and pi_auction = 'n' " + pageInfo.getWhere() + " group by pi_id " + pageInfo.getOrderby() + " limit " + ((pageInfo.getCpage() - 1) * pageInfo.getPsize()) + ", " + pageInfo.getPsize();
		System.out.println(sql);
		List<ProductInfo> productList = (List<ProductInfo>) jdbc.query(sql, (ResultSet rs, int rowNum) -> {
			ProductInfo pi = new ProductInfo();
			pi.setPi_id(rs.getString("pi_id"));
			pi.setPcb_id(rs.getString("pcb_id"));
			pi.setPcs_id(rs.getString("pcs_id"));
			pi.setPi_name(rs.getString("pi_name"));
			pi.setPi_price(rs.getInt("pi_price"));
			pi.setPi_cost(rs.getInt("pi_cost"));
			pi.setPi_dc (rs.getInt("pi_dc"));
			pi.setPi_status(rs.getString("pi_status"));
			pi.setPi_img1(rs.getString("pi_img1"));
			pi.setPi_img2(rs.getString("pi_img2"));
			pi.setPi_img3(rs.getString("pi_img3"));
			pi.setPi_stock(rs.getInt("pi_stock"));
			pi.setPi_desc(rs.getString("pi_desc"));
			pi.setPi_date(rs.getString("pi_date"));
			pi.setAi_idx(1);
	        
	        return pi;
	    });
		
		return productList;
	}

}
