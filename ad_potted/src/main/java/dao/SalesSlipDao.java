package dao;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;

public class SalesSlipDao {
	private JdbcTemplate jdbc;
	
	public SalesSlipDao(DataSource dataSource) {
		this.jdbc = new JdbcTemplate(dataSource);
	}	
}
