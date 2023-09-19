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


	public int productInsert(ProductInfo pi, ArrayList<ProductOptionStock> poList) {
		Random random = new Random();
	    int randomValue = random.nextInt(1000); // 0 이상 999 이하의 랜덤 값

	    double dc = pi.getPi_dc() / 100.0; // 할인률 계산
	    	
	    String sql = "insert into t_product_info (pi_id, pcb_id, pcs_id, pi_name, pi_price, pi_cost, pi_dc, pi_status, pi_img1, pi_img2, pi_img3, pi_desc, pi_stock, pi_isview, ai_idx) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'y', 1)";
	    int result = jdbc.update(sql, pi.getPcs_id() + String.format("%03d", randomValue), pi.getPcb_id(), pi.getPcs_id(), pi.getPi_name(), pi.getPi_price(), pi.getPi_cost(), dc, pi.getPi_status(), pi.getPi_img1(), pi.getPi_img2(), pi.getPi_img3(), pi.getPi_desc(), pi.getPi_stock());
	    
	    if (result == 1) {
	    	String piIdQuery = "select pi_id from t_product_info where pi_id = ?";
	        String piId = jdbc.queryForObject(piIdQuery, String.class, pi.getPcs_id() + String.format("%03d", randomValue));
	        
			sql = "insert into t_product_option_stock (pos_id, pob_id, pi_id, pos_price, pos_isview) values (?, ?, ?, ?, 'y')";
			
			
			for (ProductOptionStock po : poList) {
				
				int insertCount = jdbc.update(sql, po.getPos_id(), po.getPob_id(), piId, po.getPos_price());

		        result += insertCount;
			}
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
			String pistatus = "";
			if (rs.getString("pi_status").equals("a"))		pistatus = "판매중";
			else											pistatus = "판매중지";
			pi.setPi_status(pistatus);
			pi.setPi_img1(rs.getString("pi_img1"));
			pi.setPi_img2(rs.getString("pi_img2"));
			pi.setPi_img3(rs.getString("pi_img3"));
			pi.setPi_stock(rs.getInt("pi_stock"));
			pi.setPi_sale(rs.getInt("pi_sale"));
			pi.setPi_desc(rs.getString("pi_desc"));
			pi.setPi_date(rs.getString("pi_date"));
			pi.setPi_read(rs.getInt("pi_read"));
			pi.setAi_idx(1);
	        
	        return pi;
	    });
		
		return productList;
	}
	
	public ProductInfo getProductInfo(String piid) {
		String sql = "select a.*, b.pcb_name, c.pcs_name from t_product_info a join t_product_ctgr_big b on a.pcb_id = b.pcb_id join t_product_ctgr_small c "
				+ "on a.pcs_id = c.pcs_id where a.pi_isview = 'y' and a.pi_id = '" + piid + "' "; 
		ProductInfo pi = jdbc.queryForObject(sql,
			new RowMapper<ProductInfo>() {
				@Override
				public ProductInfo mapRow(ResultSet rs, int rowNum) throws SQLException {
					ProductInfo pi = new ProductInfo();
					pi.setPi_id(rs.getString("pi_id"));
					pi.setPcb_id(rs.getString("pcb_id"));
					pi.setPcs_id(rs.getString("pcs_id"));
					pi.setPcb_name(rs.getString("pcb_name"));
					pi.setPcs_name(rs.getString("pcs_name"));
					pi.setPi_name(rs.getString("pi_name"));
					pi.setPi_price(rs.getInt("pi_price"));
					pi.setPi_cost(rs.getInt("pi_cost"));
					double pi_dc = rs.getDouble("pi_dc") * 100;
	                int pi_dcInt = (int) Math.floor(pi_dc);
	                pi.setPi_dc(pi_dcInt);
					pi.setPi_status(rs.getString("pi_status"));
					pi.setPi_img1(rs.getString("pi_img1"));
					pi.setPi_img2(rs.getString("pi_img2"));
					pi.setPi_img3(rs.getString("pi_img3"));
					pi.setPi_stock(rs.getInt("pi_stock"));
					pi.setPi_desc(rs.getString("pi_desc"));
					pi.setPi_date(rs.getString("pi_date"));
					return pi;
				}
			}
		);
		return pi;
	}
	
	public List<ProductOptionStock> getProductOptionInfo(String piid) {
        String sql = "select * from t_product_option_stock where pos_isview = 'y' and pi_id = '" + piid + "' ";
         List<ProductOptionStock> poList = jdbc.query(sql,
            new RowMapper<ProductOptionStock>() {
                @Override
                public ProductOptionStock mapRow(ResultSet rs, int rowNum) throws SQLException {
                    ProductOptionStock po = new ProductOptionStock();
                    po.setPi_id(rs.getString("pi_id"));
                    po.setPob_id(rs.getString("pob_id"));
                    po.setPos_id(rs.getString("pos_id"));
                    po.setPos_price(rs.getInt("pos_price"));
                    po.setPos_stock(rs.getInt("pos_stock"));
    
                    return po;
                }
            }
        );
        return poList;
    }


	public int productUpdate(ProductInfo pi, ArrayList<ProductOptionStock> poList) {
	    double dc = pi.getPi_dc() / 100.0;
	    
	    String sql = "update t_product_info set pi_name = ?, pi_price = ?, pi_cost = ?, pi_dc = ?, pi_status = ?, pi_img1 = ?, pi_img2 = ?, pi_img3 = ?, pi_desc = ?, pi_stock = ? where pi_id = ?";

	    int result = jdbc.update(sql, pi.getPi_name(), pi.getPi_price(), pi.getPi_cost(), dc, pi.getPi_status(), pi.getPi_img1(), pi.getPi_img2(), pi.getPi_img3(), pi.getPi_desc(), pi.getPi_stock(), pi.getPi_id());
	    
	    if (result == 1) {
	        sql = "insert into t_product_option_stock (pob_id, pos_id, pos_price, pi_id, pos_isview) values (?, ?, ?, ?, 'y')";
	        
	        for (ProductOptionStock po : poList) {
	            // 체크하여 이미 있는 옵션이면 insert 하지 않음
	        	if (!isProductOptionStockExists(po.getPob_id(), po.getPos_id(), pi.getPi_id())) {
	        	    int updateCount = jdbc.update(sql, po.getPob_id(), po.getPos_id(), po.getPos_price(), pi.getPi_id());
	        	    result += updateCount;
	        	}
	        }
	    }

	    return result;
	}

	// ProductOptionStock 테이블에 해당 옵션이 이미 존재하는지 확인하는 메서드
	private boolean isProductOptionStockExists(String pob_id, String pos_id, String pi_id) {
	    String sql = "select count(*) from t_product_option_stock where pob_id = ? and pos_id = ? and pi_id = ?";
	    int count = jdbc.queryForObject(sql, Integer.class, pob_id, pos_id, pi_id);
	    return count > 0;
	}

}
