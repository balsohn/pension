package kr.co.pension.util;

import java.sql.*;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.text.DecimalFormat;
import java.time.LocalDate;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;

import kr.co.pension.dto.RoomDTO;

public class Utils {

	public static String comma(int val) {
		DecimalFormat df=new DecimalFormat("#,###");
		RoomDTO rdto=new RoomDTO();		
		
		return df.format(val);
	}
	
	public static LocalDate getDate(String date, int day) {
		String[] ymd=date.split("-");
		int y=Integer.parseInt(ymd[0]);
		int m=Integer.parseInt(ymd[1]);
		int d=Integer.parseInt(ymd[2]);
		
		LocalDate xday=LocalDate.of(y, m, d);
		LocalDate dday=xday.plusDays(day);
		
		return dday;
	}
	
	public static String dateToString() {
		LocalDate today=LocalDate.now();
		return today.toString().replace("-", "");
	}
	
	// 방의 예약여부를 체크
		public static boolean isCheck(String date,int rid) throws Exception
		{
			// DB연결
			Class.forName("com.mysql.jdbc.Driver"); // 라이브러리를 찾아라
			String db="jdbc:mysql://localhost:3306/pension";
			Connection conn=(Connection) DriverManager.getConnection(db,"root","1234");
			
			String sql="select count(*) as cnt from reserve where inday <= ?  and outday > ? and rid=?";
			PreparedStatement pstmt=(PreparedStatement) conn.prepareStatement(sql);
			pstmt.setString(1, date);
			pstmt.setString(2, date);
			pstmt.setInt(3, rid);
			
			ResultSet rs=pstmt.executeQuery();
			rs.next();
			int cnt=rs.getInt("cnt");
					
			rs.close();
			pstmt.close();
			conn.close();
			
			if(cnt==0)
				return false; // 예약 가능
			else
				return true;  // 예약 불가능
		}
		
		public static boolean dayBefore(String date) // YYYY-MM-DD
		{
			// 요청된날짜
			String[] imsi=date.split("-");
			int y=Integer.parseInt(imsi[0]);
			int m=Integer.parseInt(imsi[1]);
			int d=Integer.parseInt(imsi[2]);
			LocalDate xday=LocalDate.of(y, m, d);
			xday=xday.plusDays(1);
			// 오늘날짜
			LocalDate today=LocalDate.now();
			if(today.isBefore(xday))
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
		public static boolean dayBefore2(String date) // YYYY-MM-DD
		{
			// 요청된날짜
			String[] imsi=date.split("-");
			int y=Integer.parseInt(imsi[0]);
			int m=Integer.parseInt(imsi[1]);
			int d=Integer.parseInt(imsi[2]);
			LocalDate xday=LocalDate.of(y, m, d);
			
			// 오늘날짜
			LocalDate today=LocalDate.now();
			
			if( today.isBefore(xday) )
			{
				return true;
			}
			else
			{
				return false;
			}
		}
	
}
