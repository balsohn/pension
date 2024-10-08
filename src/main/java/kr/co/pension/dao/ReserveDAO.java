package kr.co.pension.dao;

import java.util.ArrayList;

import kr.co.pension.dto.ReserveDTO;
import kr.co.pension.dto.RoomDTO;

public interface ReserveDAO {

	public ArrayList<RoomDTO> getRooms();
	public RoomDTO getRoom(int id);
	public int getNumber(String jumuncode);
	public void reserveOk(ReserveDTO rdto);
	public ReserveDTO reserveView(String jumuncode); 
	public boolean isCheck(String date, int id);
	public ArrayList<RoomDTO> roomView(String inday, String outday);
}
