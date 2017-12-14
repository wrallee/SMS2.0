package worker;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class WorkerDBBean {
	private static WorkerDBBean instance = new WorkerDBBean() ;
	
	public static WorkerDBBean getInstance() {
		return instance ;
	}
	
	private WorkerDBBean() {}
	
	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext() ;
		Context envCtx = (Context) initCtx.lookup( "java:comp/env" ) ;
		DataSource ds = (DataSource) envCtx.lookup( "jdbc/OracleDB" ) ;
		return ds.getConnection() ;
	}
	
	public int insertWorker( WorkerDataBean workerdata ) throws Exception {
		Connection conn = null ;
		PreparedStatement pstmt = null ;
		int result = 0 ;
		
		try {
			conn = getConnection() ;
			
			pstmt = conn.prepareStatement( "INSERT INTO worker VALUES(?, ?, ?, ?) " ) ;
			
			pstmt.setString( 1 , workerdata.getId() ) ;
			pstmt.setString( 2 , workerdata.getName() ) ;
			pstmt.setString( 3 , workerdata.getDept() ) ;
			pstmt.setString( 4 , workerdata.getAddr() ) ;
			
			result = pstmt.executeUpdate() ;
			
		} catch ( Exception ex ) {
			System.out.println( "등록 오류 : " + ex.getMessage() ) ;
		} finally {
			if( pstmt != null ) try { pstmt.close() ; } catch ( SQLException ex ) {} 
			if( conn != null ) try { conn.close() ; } catch ( SQLException ex ) {} 
		}
		
		return result ;
	}
	/*
	public int userCheck( String id , String password ) throws Exception {
		Connection conn = null ;
		PreparedStatement pstmt = null ;
		ResultSet rs = null ;
		String dbpasswd = "" ;
		
		int x = 1 ;
		
		try {
			conn = getConnection() ;
			
			pstmt= conn.prepareStatement( "SELECT * FROM MEMBER WHERE ID = ? " ) ;
			pstmt.setString( 1 , id ) ;
			rs = pstmt.executeQuery() ;
			
			if( rs.next() ) {
				dbpasswd = rs.getString( "password" ) ;
				if( dbpasswd.equals( password ) )
					x = 1 ;
				else
					x = 0 ;
			} else
				x = -1 ;
		} catch ( Exception ex ) {
			ex.printStackTrace() ;
		} finally {
			if( rs != null ) try { rs.close() ; } catch ( SQLException ex ) {} 
			if( pstmt != null ) try { pstmt.close() ; } catch ( SQLException ex ) {} 
			if( conn != null ) try { conn.close() ; } catch ( SQLException ex ) {} 
		}
		return x ;
	}
	*/
	public ArrayList<WorkerDataBean> getWorkerlist()  throws Exception {
		Connection conn = null ;
		PreparedStatement pstmt = null ;
		ResultSet rs = null ;
		WorkerDataBean workerData = null ;
		ArrayList<WorkerDataBean> workerList = null ;
		
		try {
			conn = getConnection() ;
			
			pstmt = conn.prepareStatement( "SELECT * FROM worker " ) ;
			rs = pstmt.executeQuery() ;
			
			if( rs.next() ) {
				workerList = new ArrayList<WorkerDataBean>() ;
				
				do {
					workerData = new WorkerDataBean() ;
					workerData.setId( rs.getString( "id" ) ) ;
					workerData.setName( rs.getString( "name" ) ) ;
					workerData.setDept( rs.getString( "dept" ) ) ;
					workerData.setAddr( rs.getString( "addr" ) ) ;
					
					workerList.add( workerData ) ;
				} while ( rs.next() ) ;
			}
		} catch ( Exception ex ) {
			ex.printStackTrace() ;
		} finally {
			if( rs != null ) try { rs.close() ; } catch ( SQLException ex ) {} 
			if( pstmt != null ) try { pstmt.close() ; } catch ( SQLException ex ) {} 
			if( conn != null ) try { conn.close() ; } catch ( SQLException ex ) {} 
		}
		return workerList ;
	}

	public ArrayList<WorkerDataBean> getWorkerlist2()  throws Exception {
		Connection conn = null ;
		PreparedStatement pstmt = null ;
		ResultSet rs = null ;
		WorkerDataBean workerData = null ;
		ArrayList<WorkerDataBean> workerList = null ;
		
		try {
			conn = getConnection() ;
			
			pstmt = conn.prepareStatement( "SELECT w.id id , w.name name , d.dname dept , w.addr addr " + 
					"FROM worker w " + 
					"INNER JOIN department d " + 
					"ON  w.dept = d.dno " ) ;
			rs = pstmt.executeQuery() ;
			
			if( rs.next() ) {
				workerList = new ArrayList<WorkerDataBean>() ;
				
				do {
					workerData = new WorkerDataBean() ;
					workerData.setId( rs.getString( "id" ) ) ;
					workerData.setName( rs.getString( "name" ) ) ;
					workerData.setDept( rs.getString( "dept" ) ) ;
					workerData.setAddr( rs.getString( "addr" ) ) ;
					
					workerList.add( workerData ) ;
				} while ( rs.next() ) ;
			}
		} catch ( Exception ex ) {
			ex.printStackTrace() ;
		} finally {
			if( rs != null ) try { rs.close() ; } catch ( SQLException ex ) {} 
			if( pstmt != null ) try { pstmt.close() ; } catch ( SQLException ex ) {} 
			if( conn != null ) try { conn.close() ; } catch ( SQLException ex ) {} 
		}
		return workerList ;
	}

	public WorkerDataBean getWorker( String id ) throws  Exception {
		Connection conn = null ;
		PreparedStatement pstmt = null ;
		ResultSet rs = null ;
		WorkerDataBean workerData = null ;
		
		try {
			conn = getConnection() ;
			
			pstmt = conn.prepareStatement( "SELECT * FROM worker WHERE id = ? " ) ;
			pstmt.setString( 1 , id ) ;
			rs = pstmt.executeQuery() ;
			rs.next() ;
			
			workerData = new WorkerDataBean() ;
			workerData.setId( rs.getString( "id" ) ) ;
			workerData.setName( rs.getString( "name" ) ) ;
			workerData.setDept( rs.getString( "dept" ) ) ;
			workerData.setAddr( rs.getString( "addr" ) ) ;
		} catch ( Exception ex ) {
			ex.printStackTrace() ;
		} finally {
			if( rs != null ) try { rs.close() ; } catch ( SQLException ex ) {} 
			if( pstmt != null ) try { pstmt.close() ; } catch ( SQLException ex ) {} 
			if( conn != null ) try { conn.close() ; } catch ( SQLException ex ) {} 
		}
		
		return workerData ;
	}
	
	public int deleteWorker( String id ) throws Exception{
		Connection conn = null ;
		PreparedStatement pstmt = null ;
		int result = 0 ;
		
		try {
			conn = getConnection() ;
			
			pstmt = conn.prepareStatement( "DELETE FROM worker WHERE id = ? " ) ;
			pstmt.setString( 1 , id) ;
			result = pstmt.executeUpdate() ;
		} catch ( Exception ex ) {
			ex.printStackTrace() ;
		} finally {
			if( pstmt != null ) try { pstmt.close() ; } catch ( SQLException ex ) {} 
			if( conn != null ) try { conn.close() ; } catch ( SQLException ex ) {} 
		}
		return result ;
	}
	
	public WorkerDataBean selectWorker( String id ) {
		Connection conn = null ;
		PreparedStatement pstmt = null ;
		ResultSet rs = null ;
		WorkerDataBean workerdata = null ;
		
		try {
			conn = getConnection() ;
			
			pstmt = conn.prepareStatement( "SELECT * FROM worker WHERE id = ? " ) ;
			pstmt.setString( 1 , id ) ;
			rs = pstmt.executeQuery() ;
			if( rs.next() ) {
				workerdata = new WorkerDataBean() ;
				workerdata.setId( rs.getString( "id" ) ) ;
				workerdata.setName( rs.getString( "name" ) ) ;
				workerdata.setDept( rs.getString( "dept" ) ) ;
				workerdata.setAddr( rs.getString( "addr" ) ) ;
			}else {
				workerdata = null ;
			}
		} catch ( Exception ex ) {
			ex.printStackTrace() ;
		} finally {
			if( rs != null ) try { rs.close() ; } catch ( SQLException ex ) {} 
			if( pstmt != null ) try { pstmt.close() ; } catch ( SQLException ex ) {} 
			if( conn != null ) try { conn.close() ; } catch ( SQLException ex ) {} 
		}
		
		return workerdata ;
	}
	
	public WorkerDataBean selectWorker2( String id ) {
		Connection conn = null ;
		PreparedStatement pstmt = null ;
		ResultSet rs = null ;
		WorkerDataBean workerdata = null ;
		
		try {
			conn = getConnection() ;
			
			pstmt = conn.prepareStatement( "SELECT w.id id , w.name name , d.dname dept , w.addr addr " + 
					"FROM worker w " + 
					"INNER JOIN department d " + 
					"ON  w.dept = d.dno " + 
					"WHERE id=? " ) ;
			pstmt.setString( 1 , id );
			rs = pstmt.executeQuery() ;
			if( rs.next() ) {
				workerdata = new WorkerDataBean() ;
				workerdata.setId( rs.getString( "id" ) ) ;
				workerdata.setName( rs.getString( "name" ) ) ;
				workerdata.setDept( rs.getString( "dept" ) ) ;
				workerdata.setAddr( rs.getString( "addr" ) ) ;
			}else {
				workerdata = null ;
			}
		} catch ( Exception ex ) {
			ex.printStackTrace() ;
		} finally {
			if( rs != null ) try { rs.close() ; } catch ( SQLException ex ) {} 
			if( pstmt != null ) try { pstmt.close() ; } catch ( SQLException ex ) {} 
			if( conn != null ) try { conn.close() ; } catch ( SQLException ex ) {} 
		}
		
		return workerdata ;
	}
	
	public int  updateWorker( WorkerDataBean workerdata ) throws Exception {
		Connection conn = null ;
		PreparedStatement pstmt = null ;
		int result = 0 ;
		
		try {
			conn = getConnection() ;
			
			pstmt = conn.prepareStatement( "UPDATE worker SET name=? , dept=? , addr=? WHERE id=? " ) ;
			
			pstmt.setString( 1 , workerdata.getName() ) ;
			pstmt.setString( 2 , workerdata.getDept() ) ;
			pstmt.setString( 3 , workerdata.getAddr() ) ;
			pstmt.setString( 4 , workerdata.getId() ) ;
			
			result = pstmt.executeUpdate() ;
			
		} catch ( Exception ex ) {
			System.out.println( "수정 오류 : " + ex.getMessage() ) ;
		} finally {
			if( pstmt != null ) try { pstmt.close() ; } catch ( SQLException ex ) {} 
			if( conn != null ) try { conn.close() ; } catch ( SQLException ex ) {} 
		}
		
		return result ;
	}
}
