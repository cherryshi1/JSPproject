package dao;

import common.JDBConnect;
import dto.ImgDTO;
import jakarta.servlet.ServletContext;

public class ImgDAO extends JDBConnect {
	
	public ImgDAO(ServletContext application) {
		super(application);

	}
	
	
	public ImgDTO viewImg(String movie) {
		ImgDTO dto = new ImgDTO();
		String query = "SELECT * FROM movieimg where movie=?";

		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, movie);
			rs = pstmt.executeQuery();

			while (rs.next()) {

				dto.setMovie(rs.getString("movie"));
				dto.setDirector(rs.getString("director"));
				dto.setImg1(rs.getString("img1"));
				dto.setImg2(rs.getString("img2"));
				dto.setImg3(rs.getString("img3"));
				dto.setImg4(rs.getString("img4"));
				dto.setImg5(rs.getString("img5"));
				dto.setImg6(rs.getString("img6"));
				dto.setImg7(rs.getString("img7"));
			
			}

		} catch (Exception e) {
			System.out.println("사진 가져오는중 예외 발생...");
			e.printStackTrace();
		}

		return dto;
	}
}
