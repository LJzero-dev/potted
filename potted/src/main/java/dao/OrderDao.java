package dao;

import java.sql.*;
import java.util.*;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;

import vo.*;

public class OrderDao {
	private JdbcTemplate jdbc;
	
	public OrderDao(DataSource dataSource) {
		this.jdbc = new JdbcTemplate(dataSource);
	}

	public ArrayList<OrderCart> getBuyList(String kind, String sql) {
		ArrayList<OrderCart> pdtList = (ArrayList<OrderCart>) jdbc.query(sql, (ResultSet rs, int rowNum) -> {
			OrderCart oc = new OrderCart();
				oc.setPi_id(rs.getString("pi_id"));
				oc.setOc_option(rs.getString("op_option"));
				oc.setPi_name(rs.getString("pi_name"));
				oc.setOc_price(rs.getInt("price"));
				oc.setOc_cnt(rs.getInt("cnt"));
				return oc;
		});
		return pdtList;
	}

	public ArrayList<MemberAddr> getAddrList(String miid) {
		String sql = "select * from t_member_addr where mi_id = '" + miid + "' order by ma_basic desc";
		ArrayList<MemberAddr> addrList = (ArrayList<MemberAddr>) jdbc.query(sql, (ResultSet rs, int rowNum) -> {
				MemberAddr ma = new MemberAddr();
					ma.setMa_idx(rs.getInt("ma_idx"));
					ma.setMa_name(rs.getString("ma_name"));
					ma.setMa_rname(rs.getString("ma_rname"));
					ma.setMa_phone(rs.getString("ma_phone"));
					ma.setMa_zip(rs.getString("ma_zip"));
					ma.setMa_addr1(rs.getString("ma_addr1"));
					ma.setMa_addr2(rs.getString("ma_addr2"));
					ma.setMa_basic(rs.getString("ma_basic"));
					return ma;
			});
		return addrList;
	}
	

}
