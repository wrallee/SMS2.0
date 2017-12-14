package department;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DepartmentDB {
	private static DepartmentDB instance = new DepartmentDB() ;
	
	public static DepartmentDB getInstance() {
		return instance ;
	}
	
	private DepartmentDB() {}
	
	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext() ;
		Context envCtx = (Context) initCtx.lookup( "java:comp/env" ) ;
		DataSource ds = (DataSource) envCtx.lookup( "jdbc/OracleDB" ) ;
		return ds.getConnection() ;
	}
	
	public ArrayList<DepartmentBean> getDeptlist() {
		Connection conn = null ;
		PreparedStatement pstmt = null ;
		ResultSet rs = null ;
		DepartmentBean dept = null ;
		ArrayList<DepartmentBean> deptList = null ;
		
		try {
			conn = getConnection() ;
			
			pstmt = conn.prepareStatement( "SELECT * FROM department " ) ;
			rs = pstmt.executeQuery() ;
			
			if( rs.next() ) {
				deptList = new ArrayList<DepartmentBean>() ;
				
				do {
					dept = new DepartmentBean() ;
					dept.setDno( rs.getString( "dno" ) ) ;
					dept.setDname( rs.getString( "dname" ) ) ;
					deptList.add( dept ) ;
				} while ( rs.next() ) ;
			}
		} catch ( Exception ex ) {
			ex.printStackTrace() ;
		} finally {
			if( rs != null ) try { rs.close() ; } catch ( SQLException ex ) {} 
			if( pstmt != null ) try { pstmt.close() ; } catch ( SQLException ex ) {} 
			if( conn != null ) try { conn.close() ; } catch ( SQLException ex ) {} 
		}
		return deptList ;
	}
}
