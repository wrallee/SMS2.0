package adminResult;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class AdminResultBean { 
	private static AdminResultBean instance = new AdminResultBean();
	   
	public static AdminResultBean getInstance() {
		return instance;
	}
	
	private AdminResultBean() {
	
	}
	
	// 접속 메소드
	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/OracleDB");
		return ds.getConnection();
	}
	
	public ResultSet getInfoInSurvey(String code) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql ="SELECT * FROM SURVEY WHERE CODE = ?";
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, code);
			rs = pstmt.executeQuery();
			return rs;
		} catch (Exception e) {
			System.out.println("서베이정보 로드 오류: " + e.getMessage());
			return null;
		}		
	}
	
	// 테이블의 메타데이터 얻는 메소드
	public ResultSetMetaData getTableMdata(String code) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT * FROM " + code;
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			return rs.getMetaData();
		} catch (Exception e) {
			System.out.println("테이블 메타데이터 로드 오류: " + e.getMessage());
			return null;
		}		
	}
	
	// 그룹에 따른 ResultSet 반환 메소드
	public ResultSet getResultSet(String code, String group, String person) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsMdata = null;
		
		String sql = null;
		
		if (person.equals("default"))
			group = "all"; 
			
		try {
			sql = "SELECT * FROM " + code + " ORDER BY RATER, RATEE";
			
			if (group.equals("rater"))
				sql = "SELECT * FROM " + code + " WHERE RATER = '" + person + "'" + " ORDER BY RATEE";
			else if (group.equals("ratee"))
				sql = "SELECT * FROM " + code + " WHERE RATEE = '" + person + "'" + " ORDER BY RATER";
			else if (group.equals("groupby")) {
				String columns = "";
				rsMdata = getTableMdata(code);
				int i;
				for (i = 3; i < rsMdata.getColumnCount(); i++) {
					columns += "AVG(";
					columns += rsMdata.getColumnName(i);
					columns += ") + ";
				}
				columns += "AVG(";
				columns += rsMdata.getColumnName(i);
				columns += ")";
				//System.out.println("columns:" + columns);
				
				sql = "SELECT ID, NAME, SCORE, DEPT, DNAME ";
				sql +="FROM (SELECT RANK() OVER (PARTITION BY B.DEPT ORDER BY A.SCORE DESC) AS RANK,";
				sql +=			   "A.RATEE, TRUNC(A.SCORE, 2) AS SCORE, B.ID, B.NAME, B.DEPT, B.ADDR, C.DNO, C.DNAME ";
				sql +=		"FROM (SELECT RATEE, (" + columns + ")/" + (rsMdata.getColumnCount()-2) + " AS SCORE ";
				sql +=			  "FROM " + code + " ";
				sql +=			  "GROUP BY RATEE ";
				sql +=			  "ORDER BY RATEE) A JOIN WORKER B ON (A.RATEE = B.ID) ";
				sql +=			  "JOIN DEPARTMENT C ON (B.DEPT = C.DNO)) ";
				sql +="WHERE RANK = 1 ";
				sql +="ORDER BY ID";
				
			}
			//System.out.println("sql: " + sql);
			
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			return rs;
			
		} catch (Exception e) {
			System.out.println("Group메소드 오류: " + e.getMessage());
			return null;
		}
	}
	
	public ResultSet getDistinctElement(String code, String group) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			String sql = "SELECT DISTINCT " + group + " FROM " + code + " ORDER BY " + group;
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			return rs;
		} catch (Exception e) {
			System.out.println("distinct메소드 오류: " + e.getMessage());
			return null;
		}
	}
	
	public void closeAll(Connection conn, PreparedStatement pstmt, ResultSet rs) {
		try {
			if (rs != null) rs.close();
			if (pstmt != null) pstmt.close();
			if (conn != null) conn.close();
		} catch (Exception e) {
			System.out.println("rs, pstmt, conn 닫기 오류: " + e.getMessage());
		}
	}
}
