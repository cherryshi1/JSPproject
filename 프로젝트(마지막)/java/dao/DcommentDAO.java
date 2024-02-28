package dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import common.JDBConnect;
import dto.DcommentDTO;
import jakarta.servlet.ServletContext;

public class DcommentDAO extends JDBConnect {

	// DB 연결 작업 처리
	public DcommentDAO(ServletContext application) {
		super(application);

	}

	// 댓글수
	public int selectComment(Map<String, Object> map) {
		int totalCount = 0;
		
		String query = "SELECT COUNT(*) FROM dcomment" ;
		
		if(map.get("movie") != null) {
		query+= " WHERE movie=" + map.get("movie") ;}
		
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(query); // 쿼리 실행
			
			rs.next();
			
			totalCount = rs.getInt(1);  // 쿼리 결과의 첫번째 값을 얻어옴
			
		} catch(Exception e) {
			System.out.println("댓글 수를 조회하는 중 에러 발생...");
			e.printStackTrace();
		}
		
		return totalCount;
	}
	
	//댓글출력
	public List<DcommentDTO> viewComment(Map<String, Object> map) {
		List<DcommentDTO> cmt = new ArrayList<DcommentDTO>();
		
		String query = "SELECT * FROM dcomment ";
		
		if(map.get("movie") != null) {
			query+= " WHERE movie=" + map.get("movie") ;}

		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(query);

			while (rs.next()) {
				DcommentDTO dto = new DcommentDTO();

				dto.setDcomment(rs.getString("dcomment"));
				dto.setNickname(rs.getString("nickname"));
				dto.setContent(rs.getString("content"));
				dto.setMovie(rs.getString("movie"));
				dto.setId(rs.getString("id"));

				cmt.add(dto);
			}

		} catch (Exception e) {
			System.out.println("댓글 목록 가져오는중 예외 발생...");
			e.printStackTrace();
		}

		return cmt;

	}

	// 댓글 삽입
	public int insertComment(DcommentDTO dto) {
		int result = 0;

		try {
			
			String query = "INSERT INTO dcomment( dcomment, nickname, content, movie, id) "
					+ " VALUES (comment_seq.NEXTVAL, ?, ?, ?, ? )";

			pstmt = conn.prepareStatement(query);

			pstmt.setString(1, dto.getNickname());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getMovie());
			pstmt.setString(4, dto.getId());

			result = pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("댓글 삽입중 이상발생...");
			e.printStackTrace();
		}

		return result;
	}

	// 댓글 삭제
	public int deleteComment(DcommentDTO dto) {
		int result = 0;
		try {
			// 쿼리문 작성
			String query = "DELETE FROM dcomment WHERE dcomment=? and id=? ";

			// 쿼리문 완성
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, dto.getDcomment());
			pstmt.setString(2, dto.getId());

			// 쿼리문 실행
			result = pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("게시물 삭제 중 예외 발생...");
			e.printStackTrace();
		}

		return result;
	}
	
	//댓글 수정
	public int updateComment(DcommentDTO dto) {
		int result = 0;
		
		try {
			System.out.println("Updating comment with ID: " + dto.getId());
			// 쿼리문 준비
			String query ="UPDATE dcomment SET content=? WHERE id=? and dcomment=?";
			
			// 쿼리문 완성
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, dto.getContent());
			pstmt.setString(2, dto.getId());
			pstmt.setString(3, dto.getDcomment());
			
			// 쿼리문 실행
			result = pstmt.executeUpdate();
			 System.out.println("Update result: " + result);
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
		
	}
}
		
