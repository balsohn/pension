package kr.co.pension.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.pension.dao.NoticeDAO;
import kr.co.pension.dto.NoticeDTO;

@Controller

public class NoticeController {

	@Autowired
	private SqlSession sql;
	
	@RequestMapping("/notice/list")
	public String list(Model model) {
		NoticeDAO ndao=sql.getMapper(NoticeDAO.class);
		ArrayList<NoticeDTO> glist=ndao.list();
		model.addAttribute("glist",glist);
		
		return "/notice/list";
	}
	
	@RequestMapping("/notice/write")
	public String write() {
		return "/notice/write";
	}
	
	@RequestMapping("/notice/writeOk")
	public String writeOk(NoticeDTO ndto) {
		NoticeDAO ndao=sql.getMapper(NoticeDAO.class);
		ndao.writeOk(ndto);
		
		return "redirect:/notice/list";
	}
	
	@RequestMapping("/notice/readnum")
	public String readnum(HttpServletRequest request) {
		NoticeDAO ndao=sql.getMapper(NoticeDAO.class);
		String id=request.getParameter("id");
		ndao.readnum(id);
		
		return "redirect:/notice/content?id="+id;
	}
	
	@RequestMapping("/notice/content")
	public String content(HttpServletRequest request,Model model) {
		NoticeDAO ndao=sql.getMapper(NoticeDAO.class);
		String id=request.getParameter("id");
				
		NoticeDTO ndto=ndao.content(id);
		model.addAttribute("ndto",ndto);
		
		return "notice/content";
	}
	
	@RequestMapping("/notice/delete")
	public String delete(HttpServletRequest request) {
		NoticeDAO ndao=sql.getMapper(NoticeDAO.class);
		String id=request.getParameter("id");
		ndao.delete(id);
		
		return "redirect:/notice/list";
	}
	
	@RequestMapping("/notice/update")
	public String update(HttpServletRequest request,Model model) {
		String id=request.getParameter("id");
		NoticeDAO ndao=sql.getMapper(NoticeDAO.class);
		NoticeDTO ndto=ndao.content(id);
		
		model.addAttribute("ndto",ndto);
		
		return "/notice/update";
	}
	
	@RequestMapping("/notice/updateOk")
	public String updateOk(NoticeDTO ndto) {
		NoticeDAO ndao=sql.getMapper(NoticeDAO.class);
		ndao.updateOk(ndto);
		
		return "redirect:content?id="+ndto.getId();
	}
}
