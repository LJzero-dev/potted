package dao;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;

public class MemberDao {
	private JdbcTemplate jdbc;	
	public MemberDao(DataSource dataSource) {
		this.jdbc = new JdbcTemplate(dataSource);
	}		
}