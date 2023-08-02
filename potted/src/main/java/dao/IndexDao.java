package dao;

import java.sql.ResultSet;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;

import vo.*;

public class IndexDao {
	private JdbcTemplate jdbc;

	public IndexDao(DataSource dataSource) {
		this.jdbc = new JdbcTemplate(dataSource);
	}
	
	public List<ProductInfo> getProductLista() {
		String sql = "select * from t_product_info a, t_product_ctgr_big b, t_product_ctgr_small c where a.pcs_id = c.pcs_id and b.pcb_id = c.pcb_id group by a.pi_id order by a.pi_date desc limit 0, 4";
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
	
	public List<ProductInfo> getProductListb() {
		String sql = "select * from t_product_info a, t_product_ctgr_big b, t_product_ctgr_small c where a.pcs_id = c.pcs_id and b.pcb_id = c.pcb_id group by a.pi_id order by a.pi_sale desc limit 0, 4";
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

	public List<FreeList> getFreeList() {
		String sql = "select fl_idx, fl_title, fl_reply, fl_writer, fl_read, if(curdate() = date(fl_date), mid(fl_date, 12, 5), mid(fl_date, 3, 8)) wdate from t_free_list " + 
				" where date(fl_date) >= date(subdate(now(), interval 30 day)) and date(fl_date) <= date(now()) order by fl_read desc limit 0, 5";
		List<FreeList> freeList = jdbc.query(sql, (ResultSet rs, int rowNum) -> {
			FreeList fl = new FreeList();
			fl.setFl_idx(rs.getInt("fl_idx"));		fl.setFl_writer(rs.getString("fl_writer"));
			fl.setFl_read(rs.getInt("fl_read"));	fl.setFl_date(rs.getString("wdate").replace("-", "."));
			
			
			String title = "";	int cnt = 22;
			if(rs.getInt("fl_reply") > 0) {
				title = " [" + rs.getInt("fl_reply") + "]";
				cnt -= 3;
			}
			if(rs.getString("fl_title").length() > cnt)
				title = rs.getString("fl_title").substring(0, cnt - 3) + "..." + title;
			else
				title = rs.getString("fl_title") + title;
			
			fl.setFl_title(title);
			
				return fl;
 			
		});
		
		return freeList;
	}

}
