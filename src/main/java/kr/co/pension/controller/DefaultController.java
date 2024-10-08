package kr.co.pension.controller;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.co.pension.dao.DefaultDAO;
import kr.co.pension.dto.RoomDTO;

@RestController
public class DefaultController {

	@Autowired
	private SqlSession sql;
	
	@RequestMapping("/getRooms")
	public ArrayList<RoomDTO> getRooms(Model model) {
		DefaultDAO dao=sql.getMapper(DefaultDAO.class);
		ArrayList<RoomDTO> rooms=dao.getRooms();
		
		return rooms;
	}
}
