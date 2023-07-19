package dao;

import java.util.*;
import java.sql.*;
import javax.sql.*;
import org.springframework.jdbc.core.*;
import org.springframework.jdbc.support.*;
import vo.*;

public class NoticeListDao {

		private JdbcTemplate jdbc;
		
		public NoticeListDao(DataSource dataSource) {
			this.jdbc = new JdbcTemplate(dataSource);
		}
	}
