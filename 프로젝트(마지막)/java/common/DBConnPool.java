package common;

import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DBConnPool {
	public Connection conn;
	public Statement stmt;
	public PreparedStatement pstmt;
	public ResultSet rs;
	// 기본 생성자
	public DBConnPool() {
		try {
			// 서버에 있는 컨텍스트 Path를 얻어오기 위해 초기화
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			// 데이터베이스 연결정보 얻어오기
			DataSource ds = (DataSource)envContext.lookup("jdbc/myoracle");
			//데이터베이스 연결
			conn = ds.getConnection();
			System.out.println("DB 커넥션 풀 연결 성공!");
		} catch(Exception e) {
			System.out.println("DB 커넥션 풀 연결 실패");
			e.printStackTrace();
			
		}
	}
	
	// DB 연결 해지
	public void close() {
		try {
			if(rs != null) rs.close();
			if(stmt != null) stmt.close();
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
			
			System.out.println("DB 커넥션 풀 연결 해지");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
}
