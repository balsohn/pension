package kr.co.pension.dao;

import java.util.ArrayList;

import kr.co.pension.dto.NoticeDTO;

public interface NoticeDAO {
	public ArrayList<NoticeDTO> list();
	public void writeOk(NoticeDTO ndto);
	public void readnum(String id);
	public NoticeDTO content(String id);
	public void delete(String id);
	public void updateOk(NoticeDTO ndto);
}
