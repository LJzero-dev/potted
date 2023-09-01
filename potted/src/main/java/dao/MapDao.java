package dao;

import java.sql.ResultSet;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;

import vo.GardenInfo;

public class MapDao {
	private JdbcTemplate jdbc;
	
	public MapDao(DataSource dataSource) {
		this.jdbc = new JdbcTemplate(dataSource);
	}

	public List<GardenInfo> getGardenList() {
		String sql = "select * from t_garden_info";
		List<GardenInfo> gardenList = jdbc.query(sql, 
		(ResultSet rs, int rowNum) -> {
			GardenInfo gi = new GardenInfo();
			gi.setGi_idx(rs.getInt("gi_idx"));
			gi.setGi_name(rs.getString("gi_name"));
			gi.setGi_location(rs.getString("gi_location"));
			gi.setGi_link(rs.getString("gi_link"));
			gi.setGi_content(rs.getString("gi_content").replaceAll("\r\n", "<br />"));
			return gi;
		});
		return gardenList;
	}

}
