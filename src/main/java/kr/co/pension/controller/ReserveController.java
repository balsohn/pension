package kr.co.pension.controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.datetime.joda.LocalDateParser;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.pension.dao.ReserveDAO;
import kr.co.pension.dto.ReserveDTO;
import kr.co.pension.dto.RoomDTO;
import kr.co.pension.util.Utils;

@Controller
public class ReserveController {

	@Autowired
	private SqlSession sql;
	
	@RequestMapping("/reserve/roomView")
	public String roomView(HttpServletRequest request,Model model) {
		String inday=request.getParameter("inday");
		String outday=request.getParameter("outday");
		ReserveDAO rdao=sql.getMapper(ReserveDAO.class);
		ArrayList<RoomDTO> rlist=rdao.roomView(inday, outday);
		for(int i=0;i<rlist.size();i++) {
			String[] imgs=rlist.get(i).getRoomimg().split("/");
			rlist.get(i).setRoomimg(imgs[0]);
		}
		model.addAttribute("outday",outday);
		model.addAttribute("rlist",rlist);
		model.addAttribute("inday",inday);
		return "/reserve/roomView";
	}

	
	@RequestMapping("/reserve/reserve")
	public String reserve(Model model,HttpServletRequest request) {
		LocalDate today=LocalDate.now();
		int year=request.getParameter("year")==null?today.getYear():Integer.parseInt(request.getParameter("year"));
		int month=request.getParameter("month")==null?today.getMonthValue():Integer.parseInt(request.getParameter("month"));
		int day=request.getParameter("day")==null?today.getDayOfMonth():Integer.parseInt(request.getParameter("day"));
		LocalDate xday=LocalDate.of(year, month, 1);
		int firstday=xday.getDayOfWeek().getValue()==7?0:xday.getDayOfWeek().getValue();
		int chong=xday.lengthOfMonth();
		String inday=request.getParameter("inday");
		String outday=request.getParameter("outday");
		
		System.out.println(year+" "+month+" "+day+" ");
		System.out.println(xday+" "+firstday+" "+chong);
	    
		model.addAttribute("outday",outday);
		model.addAttribute("inday",inday);
		model.addAttribute("chong",chong);
	    model.addAttribute("year",year);
	    model.addAttribute("month",month);
	    model.addAttribute("day",day);
	    model.addAttribute("firstday",firstday);
		return "/reserve/reserve";
	}
	
	@RequestMapping("/reserve/reserveNext")
	public String reserveNext(HttpServletRequest request,Model model,HttpSession session,
			HttpServletResponse response) {
		
		if(session.getAttribute("userid")==null) {
			String originalURL = request.getRequestURL().toString() + "?" + request.getQueryString();
			Cookie cookie=new Cookie("url", originalURL);
			cookie.setMaxAge(600);
			cookie.setPath("/");
			response.addCookie(cookie);
			
			return "redirect:/member/login";
		} else {

		String[] inday=request.getParameter("inday").split("-");
		
		int year=Integer.parseInt(inday[0]);
		int month=Integer.parseInt(inday[1]);
		int day=Integer.parseInt(inday[2]);
		
		String[] outday=request.getParameter("outday").split("-");
		int year1=Integer.parseInt(outday[0]);
		int month1=Integer.parseInt(outday[1]);
		int day1=Integer.parseInt(outday[2]);
		int id=Integer.parseInt(request.getParameter("id"));
				
		String date = String.format("%04d-%02d-%02d", year, month, day);

		model.addAttribute("date",date);
		
		ReserveDAO rdao=sql.getMapper(ReserveDAO.class);
		RoomDTO rdto=rdao.getRoom(id);
		
		rdto.setContent(rdto.getContent().replace("\r\n", "<br>"));
		String[] imgs=rdto.getRoomimg().split("/");
		
		rdto.setPrice2(Utils.comma(rdto.getPrice()));
		
		model.addAttribute("outday",String.format("%04d-%02d-%02d", year1,month1,day1));
		model.addAttribute("imgs",imgs);
		model.addAttribute("rdto", rdto);

		int suk=0;
 	    LocalDate xday=LocalDate.of(year, month, day);
 	    for(int i=1;i<=6;i++)
 	    {
 	    	// 8월 11일이 가능한지
 	    	if(rdao.isCheck(xday.toString(),id))
 	    	{
 	    		break;
 	    	}
 	    	else // 예약 가능
 	    	{
 	    		suk++;
 	    	}
 	    	// 날짜를 하루 증가시킨다.
 	    	
 	    	xday=xday.plusDays(1);
 	    	
 	    }
 	    model.addAttribute("suk",suk);
 	    
 	    
		model.addAttribute("rdto",rdto);
		model.addAttribute("date",date);
		
		return "/reserve/reserveNext";
		}
	}
	
	@RequestMapping("/reserve/reserveOk")
	public String reserveOk(ReserveDTO rdto,HttpSession session) {
		LocalDate dday=Utils.getDate(rdto.getInday(), rdto.getSuk());
		rdto.setOutday(dday.toString());
		
		// jumuncode를 생성해서 dto에 넣기
		String jumuncode="j"+Utils.dateToString();
		ReserveDAO rdao=sql.getMapper(ReserveDAO.class);
		int a=rdao.getNumber(jumuncode)+1;
		String b=String.format("%03d", a);
		jumuncode=jumuncode+b;
		rdto.setJumuncode(jumuncode);
		
		String userid=session.getAttribute("userid").toString();
		rdto.setUserid(userid);
		
		
		rdao.reserveOk(rdto);
		// 오늘날짜 기준으로 가장 높은 오른쪽에서 3자리 값을 가져오기
		
		return "redirect:/reserve/reserveView?jumuncode="+jumuncode;
	}
	
	@RequestMapping("/reserve/reserveView")
	public String reserveView(HttpServletRequest request, Model model) {
		String jumuncode=request.getParameter("jumuncode");
		ReserveDAO rdao=sql.getMapper(ReserveDAO.class);
		ReserveDTO rdto=rdao.reserveView(jumuncode);
		RoomDTO rdto2=rdao.getRoom(rdto.getRid());
		String price2=Utils.comma(rdto.getChgprice());
		
		model.addAttribute("price",price2);
		model.addAttribute("title",rdto2.getTitle());
		model.addAttribute("rdto",rdto);
		return "/reserve/reserveView";
	}
} 
