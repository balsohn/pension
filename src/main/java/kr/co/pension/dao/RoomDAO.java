package kr.co.pension.dao;

import java.util.ArrayList;

import kr.co.pension.dto.RoomDTO;

public interface RoomDAO {
	public ArrayList<RoomDTO> list();
	public RoomDTO content(String id);
	public void delete(String id);
	public String getRoomimg(String id);
	public void updateOk(RoomDTO rdto);
}
