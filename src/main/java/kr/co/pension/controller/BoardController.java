package kr.co.pension.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.pension.dao.BoardDAO;
import kr.co.pension.dto.BoardDTO;

@Controller
public class BoardController {

	@Autowired
	private SqlSession sql;
	
	@RequestMapping("/board/list")
	public String list(Model model) {
		BoardDAO bdao=sql.getMapper(BoardDAO.class);
		ArrayList<BoardDTO> blist=bdao.list();
		
		model.addAttribute("blist",blist);
		
		return "/board/list";
	}
	
	@RequestMapping("/board/write")
	public String write(HttpSession session) {
		Object userid=session.getAttribute("userid");
		if(userid==null) {
			return "redirect:/member/login";
		} else {
			return "/board/write";
		}
		
	}
	
	@RequestMapping("/board/writeOk")
	public String writeOk(BoardDTO bdto) {
		BoardDAO bdao=sql.getMapper(BoardDAO.class);
		bdao.writeOk(bdto);
		
		return "redirect:/board/list";
	}
	
	@RequestMapping("/board/readnum")
	public String readnum(HttpServletRequest request) {
		BoardDAO bdao=sql.getMapper(BoardDAO.class);
		String id=request.getParameter("id");
		bdao.readnum(id);
		
		return "redirect:content?id="+id;
	}
	
	@RequestMapping("board/content")
	public String content(HttpServletRequest request,Model model) {
		BoardDAO bdao=sql.getMapper(BoardDAO.class);
		String id=request.getParameter("id");
		BoardDTO bdto=bdao.content(id);
		bdto.setContent(bdto.getContent().replace("\r\n", "<br>"));
		model.addAttribute("bdto",bdto);
		
		return "board/content";
	}
	
	@RequestMapping("board/update")
	public String update(HttpServletRequest request,Model model,HttpSession session) {
		BoardDAO bdao=sql.getMapper(BoardDAO.class);
		String id=request.getParameter("id");
		BoardDTO bdto=bdao.content(id);
		model.addAttribute("bdto",bdto);
		String loginId=session.getAttribute("userid").toString();
		
		if(loginId.equals(bdto.getUserid())) {
			return "/board/update";			
		}
		else {
			return "redirect:/board/content?id="+id;
		}
	}
	
	@RequestMapping("board/updateOk")
	public String updateOk(BoardDTO bdto) {
		BoardDAO bdao=sql.getMapper(BoardDAO.class);		
		
		bdao.updateOk(bdto);
		
		return "redirect:content?id="+bdto.getId();
	}
	
	@RequestMapping("/board/delete")
	public String delete(HttpServletRequest request,HttpSession session) {
		BoardDAO bdao=sql.getMapper(BoardDAO.class);
		String id=request.getParameter("id");
		String userid=session.getAttribute("userid").toString();
		if(bdao.delete(id, userid)) {
			return "/board/list";
		} else {
			return "redirect:/board/content?err=1&id="+id;
		}
	}
}
