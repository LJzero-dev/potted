package dao;

import java.sql.ResultSet;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;

import vo.*;

public class ReviewDao {
	private JdbcTemplate jdbc;
	
	public ReviewDao(DataSource dataSource) {
		this.jdbc = new JdbcTemplate(dataSource);
	}

}
