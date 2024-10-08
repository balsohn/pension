package kr.co.pension.controller;

import java.text.DecimalFormat;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.pension.dao.RoomDAO;
import kr.co.pension.dto.RoomDTO;
import kr.co.pension.util.Utils;

@Controller
public class RoomController {

	@Autowired
	private SqlSession sql;
	
	@RequestMapping("/room/list")
	public String list(Model model) {
		RoomDAO rdao=sql.getMapper(RoomDAO.class);
		ArrayList<RoomDTO> list=rdao.list();
		
		model.addAttribute("list",list);
		return "/room/list";
	}
	
	@RequestMapping("/room/roomView")
	public String roomView(HttpServletRequest request,Model model) {
		RoomDAO rdao=sql.getMapper(RoomDAO.class);
		String id=request.getParameter("id");
		RoomDTO rdto=rdao.content(id);
		
		rdto.setPrice2(Utils.comma(rdto.getPrice()));
		rdto.setContent(rdto.getContent().replace("\r\n", "<br>"));
		
		String[] imgs=rdto.getRoomimg().split("/");
		String imsi="";
		for(int i=0;i<imgs.length;i++) {
			
			if(i<imgs.length-1) {
				imsi+="\""+imgs[i]+"\""+",";
			}
			else {
				imsi+="\""+imgs[i]+"\"";
			}
		}
		rdto.setRoomimg(imgs[0]);
		
		model.addAttribute("img",imgs);
		model.addAttribute("imgs",imsi);
		model.addAttribute("rdto",rdto);
		
		return "/room/roomView";
	}
}
