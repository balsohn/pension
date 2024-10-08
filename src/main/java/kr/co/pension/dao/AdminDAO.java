package kr.co.pension.dao;

import java.util.ArrayList;

import kr.co.pension.dto.InquiryDTO;
import kr.co.pension.dto.RoomDTO;

public interface AdminDAO {
	public ArrayList<RoomDTO> list();
	public void writeOk(RoomDTO rdto);
	public ArrayList<InquiryDTO> getInquirys();
	public void inquiryOk(InquiryDTO idto);
	
}
