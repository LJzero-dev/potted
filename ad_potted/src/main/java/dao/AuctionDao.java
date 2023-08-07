package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import vo.PageInfo;
import vo.ProductCtgrBig;
import vo.ProductCtgrSmall;
import vo.ProductInfo;
import vo.ProductOptionInfo;

public class AuctionDao {
	private JdbcTemplate jdbc;
	
	public AuctionDao(DataSource dataSource) {
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
	    int randomValue = random.nextInt(1000); // 0 �̻� 999 ������ ������ ���� ����

	    System.out.println("1");
	    String sql = "insert into t_product_info (pi_id, pcb_id, pcs_id, pi_name, pi_price, pi_cost, pi_dc, pi_status, pi_img1, pi_img2, pi_img3, pi_desc, pi_stock, pi_isview, ai_idx) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'y', 1)";
	    int result = jdbc.update(sql, pi.getPcs_id() + String.format("%03d", randomValue), pi.getPcb_id(), pi.getPcs_id(), pi.getPi_name(), pi.getPi_price(), pi.getPi_cost(), pi.getPi_dc(), pi.getPi_status(), pi.getPi_img1(), pi.getPi_img2(), pi.getPi_img3(), pi.getPi_desc(), pi.getPi_stock());
	    
	    if (result == 1) {
	    	String piIdQuery = "select pi_id from t_product_info where pi_id = ?";
	        String piId = jdbc.queryForObject(piIdQuery, String.class, pi.getPcs_id() + String.format("%03d", randomValue));
	        
			sql = "insert into t_product_option_stock (pos_id, pob_id, pi_id, pos_price, pos_isview) values (?, ?, ?, ?, 'y')";
			result += jdbc.update(sql, po.getPos_id(), po.getPob_id(), piId, po.getPos_price());
	    }
		
		return result;
	}


	public int getProductCount(String where) {
		String sql = "select count(*) from t_product_info where pi_isview = 'y'" + where;
		int rcnt = jdbc.queryForObject(sql, Integer.class);
		return rcnt;
	}


	public List<ProductInfo> getProductList(PageInfo pageInfo) {
		String sql = "select * from t_product_info where pi_isview = 'y' and pi_auction = 'y' " + pageInfo.getWhere() + " group by pi_id " + pageInfo.getOrderby() + " limit " + ((pageInfo.getCpage() - 1) * pageInfo.getPsize()) + ", " + pageInfo.getPsize();
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
			if (rs.getString("pi_status").equals("a"))		pistatus = "�Ǹ� ��";
			else											pistatus = "�Ǹ� ����";
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
		String sql = "select * from t_product_info where pi_isview = 'y' and pi_id = '" + piid + "' ";
		ProductInfo pi = jdbc.queryForObject(sql,
			new RowMapper<ProductInfo>() {
				@Override
				public ProductInfo mapRow(ResultSet rs, int rowNum) throws SQLException {
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
					return pi;
				}
			}
		);
		return pi;
	}
	
	public List<ProductOptionInfo> getProductOptionInfo(String piid) {
        String sql = "select * from t_product_option_stock where pos_isview = 'y' and pi_id = '" + piid + "' ";
         List<ProductOptionInfo> poList = jdbc.query(sql,
            new RowMapper<ProductOptionInfo>() {
                @Override
                public ProductOptionInfo mapRow(ResultSet rs, int rowNum) throws SQLException {
                    ProductOptionInfo po = new ProductOptionInfo();
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

}