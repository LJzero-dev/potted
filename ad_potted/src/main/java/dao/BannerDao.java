package dao;

import java.sql.*;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import vo.BannerList;

public class BannerDao {
	private JdbcTemplate jdbc;
	
	public BannerDao(DataSource dataSource) {
		this.jdbc = new JdbcTemplate(dataSource);
	}

	public BannerList getBannerList() {
		String sql = "select bl_img1, bl_img2, bl_img3, bl_img4 from t_banner_list";
		BannerList bl = jdbc.queryForObject(sql,
			new RowMapper<BannerList>() {
				@Override
				public BannerList mapRow(ResultSet rs, int rowNum) throws SQLException {
					BannerList bl = new BannerList();
					bl.setBl_img1(rs.getString("bl_img1"));
					bl.setBl_img2(rs.getString("bl_img2"));
					bl.setBl_img3(rs.getString("bl_img3"));
					bl.setBl_img4(rs.getString("bl_img4"));
					return bl;
				}
			});
		return bl;
	}

	public int UpdateBanner(int num, String name) {
		String sql = "update t_banner_list set bl_img" + num + " = '" + name + "' where ai_idx = 1";
		int result = jdbc.update(sql);
		return result;
	}

}
