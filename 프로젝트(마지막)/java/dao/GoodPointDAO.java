package dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import common.JDBConnect;
import dto.GoodPointDTO;
import jakarta.servlet.ServletContext;

public class GoodPointDAO extends JDBConnect {

	public GoodPointDAO(ServletContext application) {
		super(application);
	}

	// 현재 good point 수 출력
	public int goodPointCount(String movie_no) {
		int totalCount = 0;

		String query = "SELECT COUNT(*) FROM goodpoint where movie_no=?";

		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, movie_no);
			rs = pstmt.executeQuery(); // 쿼리 실행

			rs.next();

			totalCount = rs.getInt(1); // 쿼리 결과의 첫번째 값을 얻어옴

		} catch (Exception e) {
			System.out.println("좋아요의 수를 조회하는 중 에러 발생...");
			e.printStackTrace();
		}

		return totalCount;
	}

	// DB에 해당정보가 있는지 확인
	public boolean selectgoodPoint(String user_id, String movie_no) {

		String query = "SELECT COUNT(*) FROM goodpoint where user_id=? and movie_no=?";

		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, user_id);
			pstmt.setString(2, movie_no);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				return rs.getInt(1) > 0; // 좋아요가 있으면 true, 없으면 false 반환
			}

		} catch (Exception e) {
			System.out.println("좋아요 조회중 오류");
			e.printStackTrace();
		}

		return false;

	}

	// 좋아요를 누르면 good point 증가
	public int updateGoodPoint(GoodPointDTO dto) {
		int result = 0;

		try {
			// 쿼리문 준비

			String query = "insert into goodpoint(goodpoint_no, movie_no, user_id) values(goodpoint_seq.nextval, ?, ?)";

			// 쿼리문 완성
			pstmt = conn.prepareStatement(query);

			pstmt.setString(1, dto.getMovie_no());
			pstmt.setString(2, dto.getUser_id());

			// 쿼리문 실행
			result = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("좋아요 추가중 예외 발생...");
		}

		return result;

	}

	// 한번더 누르면 취소
	public int deleteGoodPoint(GoodPointDTO dto) {
		int result = 0;
		try {
			// 쿼리문 작성
			String query = "DELETE FROM goodpoint WHERE movie_no=? and user_id=?";

			// 쿼리문 완성
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, dto.getMovie_no());
			pstmt.setString(2, dto.getUser_id());

			// 쿼리문 실행
			result = pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("좋아요 취소 중 예외 발생...");
			e.printStackTrace();
		}

		return result;
	}

}
