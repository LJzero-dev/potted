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
import vo.ProductAuctionInfo;
import vo.ProductCtgrBig;
import vo.ProductCtgrSmall;
import vo.ProductInfo;
import vo.ProductOptionStock;

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

	public int productInsert(ProductInfo pi, String pai_start, String pai_runtime) {
		Random random = new Random();
	    int randomValue = random.nextInt(1000); // 0 �̻� 999 ������ ������ ���� ����

	    String sql = "insert into t_product_info (pi_id, pcb_id, pcs_id, pi_name, pi_price, pi_status, pi_img1, pi_desc, pi_cost, pi_dc, pi_stock, pi_isview, ai_idx, pi_auction) " + 
	    			" values (?, ?, ?, ?, ?, ?, ?, ?, 0, 0, 1, 'y', 1, 'y')";
	    int result = jdbc.update(sql, pi.getPcs_id() + String.format("%03d", randomValue), pi.getPcb_id(), pi.getPcs_id(), pi.getPi_name(), pi.getPi_price(), pi.getPi_status(), pi.getPi_img1(), pi.getPi_desc());
	    System.out.println(sql);
	    
	    if (result == 1) {
	    	String piIdQuery = "select pi_id from t_product_info where pi_id = ?";
	        String piId = jdbc.queryForObject(piIdQuery, String.class, pi.getPcs_id() + String.format("%03d", randomValue));
			
			sql = "insert into t_product_auction_info (pi_id, pai_price, pai_runtime, pai_start, pai_bidder, pai_id) values (?, ?, ?, ?, 1, 'admin')";
			System.out.println(sql);
			result += jdbc.update(sql, piId, pi.getPi_price(), pai_runtime, pai_start);
	    }
		
		return result;
	}


	public int getProductCount(String where) {
		String sql = "select count(*) from t_product_info where pi_isview = 'y'" + where;
		int rcnt = jdbc.queryForObject(sql, Integer.class);
		return rcnt;
	}


	public List<ProductInfo> getProductList(PageInfo pageInfo) {
		System.out.println("where" + pageInfo.getWhere());
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
			if (rs.getString("pi_status").equals("a"))		pistatus = "경매중";
			else											pistatus = "경매중지";
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


}