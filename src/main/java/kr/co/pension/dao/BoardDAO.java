package kr.co.pension.dao;

import java.util.ArrayList;

import kr.co.pension.dto.BoardDTO;
import kr.co.pension.dto.NoticeDTO;
import kr.co.pension.dto.TourDTO;

public interface BoardDAO {

	public ArrayList<BoardDTO> list();
	public void writeOk(BoardDTO bdto);
	public void readnum(String id);
	public BoardDTO content(String id);
	public void updateOk(BoardDTO bdto);
	public boolean delete(String id,String userid);
	public ArrayList<NoticeDTO> notice();
	public ArrayList<TourDTO> tour();
	
}
