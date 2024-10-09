package kr.co.pension.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.co.pension.dao.TourDAO;
import kr.co.pension.dto.TourDTO;

@Controller
public class TourController {

	@Autowired
	private SqlSession sql;
	
	@RequestMapping("/tour/list")
	public String list(Model model) {
		TourDAO tdao=sql.getMapper(TourDAO.class);
		ArrayList<TourDTO> tlist=tdao.tlist();
		
		model.addAttribute("tlist",tlist);
		return "/tour/list";
	}
	
	@RequestMapping("/tour/write")
	public String write() {
		return "/tour/write";
	}
	
	@RequestMapping("/tour/writeOk")
	public String writeOk(HttpSession session,HttpServletRequest request) throws Exception {
		
		String path=request.getRealPath("/resources/tour");
		int size=1024*1024*30;
		MultipartRequest multi=new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());
		
		String title=multi.getParameter("title");
		String content=multi.getParameter("content");
		Enumeration files=multi.getFileNames();
		
		String newimg="";
		while(files.hasMoreElements()) {
			String imsi=files.nextElement().toString();
			newimg+=multi.getFilesystemName(imsi)+"/";
		}
		newimg=newimg.replace("null/", "");
		
		TourDAO tdao=sql.getMapper(TourDAO.class);
		TourDTO tdto=new TourDTO();
		tdto.setContent(content);
		tdto.setTourimg(newimg);
		tdto.setTitle(title);
		tdto.setUserid(session.getAttribute("userid").toString());
		
		tdao.writeOk(tdto);
		
		return "redirect:/tour/list";
	}
	
	@RequestMapping("/tour/readnum")
	public String readnum(HttpServletRequest request) {
		TourDAO tdao=sql.getMapper(TourDAO.class);
		String id=request.getParameter("id");
		tdao.readnum(id);
		
		return "redirect:/tour/content?id="+id;
	}
	
	@RequestMapping("/tour/content")
	public String content(HttpServletRequest request,Model model) {
		TourDAO tdao=sql.getMapper(TourDAO.class);
		String id=request.getParameter("id");
		TourDTO tdto=tdao.content(id);
		String[] imgs=tdto.getTourimg().split("/");
		
		model.addAttribute("imgs",imgs);
		model.addAttribute("tdto",tdto);
		
		return "/tour/content";
	}
	
	@RequestMapping("/tour/update")
	public String update(HttpServletRequest request,HttpSession session,Model model) {
		TourDAO tdao=sql.getMapper(TourDAO.class);
		String id=request.getParameter("id");
		
		if(session.getAttribute("userid")==null) {
			return "redirect:/tour/content?id="+id;
		} else {
			String userid=session.getAttribute("userid").toString();
			if(tdao.userchk(userid, id)) {
				TourDTO tdto=tdao.content(id);
				String[] imgs=tdto.getTourimg().split("/");
				
				model.addAttribute("imgs",imgs);
				model.addAttribute("tdto",tdto);
				
				return "/tour/update";
			} else {
				return "redirect:/tour/content?id="+id;
			}
			
		}
				
	}
	
	@RequestMapping("/tour/upload")
	public String upload() {
		return "/tour/upload";
	}
}
