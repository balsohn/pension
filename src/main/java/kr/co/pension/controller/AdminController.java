package kr.co.pension.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.co.pension.dao.AdminDAO;
import kr.co.pension.dao.RoomDAO;
import kr.co.pension.dto.InquiryDTO;
import kr.co.pension.dto.RoomDTO;
import kr.co.pension.util.Utils;

@Controller
public class AdminController {

	@Autowired
	private SqlSession sql;
	
	@RequestMapping("/adminRoom/list")
	public String list(Model model) {
		AdminDAO dao=sql.getMapper(AdminDAO.class);
		ArrayList<RoomDTO> rlist=dao.list();
		
		for(int i=0;i<rlist.size();i++) {
			RoomDTO rdto=rlist.get(i);
			rdto.setPrice2(Utils.comma(rdto.getPrice()));
		}
		
		model.addAttribute("rlist",rlist);
		
		
		
		return "/adminRoom/list";
	}
	
	@RequestMapping("/adminRoom/write")
	public String write() {
		return "/adminRoom/write";
	}
	
	@RequestMapping("/adminRoom/chuga1")
	public String chuga1() {
		return "/adminRoom/chuga1";
	}
	
	@RequestMapping("/adminRoom/chuga2")
	public String chuga2() {
		return "/adminRoom/chuga2";
	}
	
	@RequestMapping("/adminRoom/chuga3")
	public String chuga3() {
		return "/adminRoom/chuga3";
	}

	@RequestMapping("/adminRoom/chuga4")
	public String chuga4() {
		return "/adminRoom/chuga4";
	}
	
	@RequestMapping("/adminRoom/writeOk")
	public String writeOk(HttpServletRequest request) throws Exception {
		String path=request.getRealPath("/resources/room");
		int size=1024*1024*30;
		MultipartRequest multi=new MultipartRequest(request, path, size, "utf-8",new DefaultFileRenamePolicy());
		
		Enumeration files=multi.getFileNames();
		
		String roomimg="";
		while(files.hasMoreElements()) {
			String imsi=files.nextElement().toString();
			roomimg=roomimg+multi.getFilesystemName(imsi)+"/";
		}
		
		roomimg=roomimg.replace("null/","");
		
		String title=multi.getParameter("title");
		int min=Integer.parseInt(multi.getParameter("min"));
		int max=Integer.parseInt(multi.getParameter("max"));
		String content=multi.getParameter("content");
		int price=Integer.parseInt(multi.getParameter("price"));
		
	//	System.out.println(fname);
		
		AdminDAO adao=sql.getMapper(AdminDAO.class);
		RoomDTO rdto=new RoomDTO();
		rdto.setPrice(price);
		rdto.setRoomimg(roomimg);
		rdto.setTitle(title);
		rdto.setMin(min);
		rdto.setMax(max);
		rdto.setContent(content);
		
		adao.writeOk(rdto);
		
		return "redirect:/adminRoom/list";
	}
	
	@RequestMapping("/adminRoom/content")
	public String content(HttpServletRequest request,Model model) {
		String id=request.getParameter("id");
		RoomDAO rdao=sql.getMapper(RoomDAO.class);
		RoomDTO rdto=rdao.content(id);
		rdto.setContent(rdto.getContent().replace("\r\n", "<br>"));
		String[] imgs;
		imgs=rdto.getRoomimg().split("/");
		
		rdto.setPrice2(Utils.comma(rdto.getPrice()));

		model.addAttribute("imgs",imgs);
		model.addAttribute("rdto",rdto);
		
		return "/adminRoom/content";
	}
	
	@RequestMapping("/adminRoom/delete")
	public String delete(HttpServletRequest request) {
		String path=request.getRealPath("resources/room");
		String id=request.getParameter("id");
		RoomDAO rdao=sql.getMapper(RoomDAO.class);
		String[] imgs=rdao.getRoomimg(id).split("/");
		
		for(int i=0;i<imgs.length;i++) {
			File file=new File(path+"/"+imgs[i]);
			if(file.exists()) {
				file.delete();
			}
		}
		rdao.delete(id);
				
		return "redirect:/adminRoom/list";
	}
	
	@RequestMapping("/adminRoom/update")
	public String update(Model model,HttpServletRequest request,HttpSession session) {
		Object useridchk=session.getAttribute("userid");
		if(useridchk==null) {
			return "redirect:/member/login";
		} else if(useridchk.toString().equals("admin")) {
			RoomDAO rdao=sql.getMapper(RoomDAO.class);
			String id=request.getParameter("id");
			RoomDTO rdto=rdao.content(id);
			String[] imgs=rdto.getRoomimg().split("/");
			
			model.addAttribute("imgs",imgs);
			model.addAttribute("rdto",rdto);
			
			return "/adminRoom/update";
		} else {
			return "redirect:/main/index";
		}
	}
	
/*	@RequestMapping("/adminRoom/updateOk")
	public String updateOk(HttpServletRequest request,RoomDTO rdto) throws Exception {
		String path=request.getRealPath("resources/room");
		int size=1024*1024*30;
		MultipartRequest multi=new MultipartRequest(request, path, size, "utf-8",new DefaultFileRenamePolicy());
		
		String delimg=multi.getParameter("imgnum"); // 삭제될 이미지
		String id=multi.getParameter("id");
		RoomDAO rdao=sql.getMapper(RoomDAO.class);
		String safeimg=rdao.getRoomimg(id).replace(delimg, ""); // 삭제되고 남은 이미지
		
		// 새로 등록되는 이미지
		Enumeration files=multi.getFileNames();
		String newimg="";
		while(files.hasMoreElements()) {
			String imsi=files.nextElement().toString();
			newimg+=multi.getFilesystemName(imsi)+"/";
		}
		newimg=newimg.replace("null/","");
		
		newimg=newimg+safeimg; // 남은이미지+새로등록되는 이미지
		
		String title=multi.getParameter("title");
		int min=Integer.parseInt(multi.getParameter("min"));
		int max=Integer.parseInt(multi.getParameter("max"));
		int price=Integer.parseInt(multi.getParameter("price"));
		String content=multi.getParameter("content");
		
		// 삭제되는 이미지 파일에서도 삭제
		String[] del=delimg.split("/");
		for(int i=0;i<del.length;i++) {
			File file=new File(path+"/"+del[i]);
			if(file.exists()) {
				file.delete();
			}
		}
		
		// RoomDTO에 set
		rdto.setTitle(title);
		rdto.setContent(content);
		rdto.setMin(min);
		rdto.setMax(max);
		rdto.setPrice(price);
		rdto.setRoomimg(newimg);
		rdto.setId(Integer.parseInt(id));
		
		rdao.updateOk(rdto);
		
		
		return "redirect:/adminRoom/content?id="+id;
	}
	*/
	
	@RequestMapping("/adminRoom/updateOk")
	public String updateOk(HttpServletRequest request) throws Exception {
		String path=request.getRealPath("resources/room");
		int size=1024*1024*30;
		MultipartRequest multi=new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());
		
		Enumeration files=multi.getFileNames();
		
		String newimg="";
		while(files.hasMoreElements()) {
			String imsi=files.nextElement().toString();
			newimg+=multi.getFilesystemName(imsi)+"/";
		}
		newimg=newimg.replace("null/", "");
		
		RoomDAO rdao=sql.getMapper(RoomDAO.class);
		String id=multi.getParameter("id");
		String img=rdao.getRoomimg(id);
		String delimg=multi.getParameter("imgnum");
		String safeimg=img.replace(delimg,"")+newimg;
		
		String title=multi.getParameter("title");
		int min=Integer.parseInt(multi.getParameter("min"));
		int max=Integer.parseInt(multi.getParameter("max"));
		int price=Integer.parseInt(multi.getParameter("price"));
		String content=multi.getParameter("content");
		
		String[] del=delimg.split("/");
		for(int i=0;i<del.length;i++) {
			File file=new File(path+"/"+del[i]);
			if(file.exists()) {
				file.delete();
			}
		}
		
		RoomDTO rdto=new RoomDTO();
		rdto.setTitle(title);
		rdto.setContent(content);
		rdto.setMin(min);
		rdto.setMax(max);
		rdto.setPrice(price);
		rdto.setRoomimg(safeimg);
		rdto.setId(Integer.parseInt(id));
		
		
		rdao.updateOk(rdto);
		
		
		return "redirect:/adminRoom/content?id="+id;
	}
	
	@RequestMapping("/adminRoom/inquiryList")
	public String inquiryList(HttpSession session,Model model) {
		
		if(session.getAttribute("userid")==null) {
			return "redirect:/member/login";
		} else if(session.getAttribute("userid").toString().equals("admin")) {
			AdminDAO adao=sql.getMapper(AdminDAO.class);
			ArrayList<InquiryDTO> inquirys=adao.getInquirys();
			for(int i=0;i<inquirys.size();i++) {
				InquiryDTO idto=inquirys.get(i);
				
				switch(idto.getTitle()) {
				case 0: idto.setTitle2("펜션 예약"); break;
				case 1: idto.setTitle2("입실 퇴실"); break; 
				case 2: idto.setTitle2("주변 맛집"); break;
				case 3: idto.setTitle2("웹 사이트"); break;
				case 4: idto.setTitle2("기타"); break;
				default: idto.setTitle2("");
				}
			}
			
			
			model.addAttribute("ilist",inquirys);
			
			return "/adminRoom/inquiryList";
			
		} else {
			return "redirect:/member/login";
		}
	}
	
	@RequestMapping("/adminRoom/inquiryOk")
	public String inquiryOk(InquiryDTO idto) {
		AdminDAO adao=sql.getMapper(AdminDAO.class);
		adao.inquiryOk(idto);
		
		return "redirect:/adminRoom/inquiryList";
	}
}
