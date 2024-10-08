package kr.co.pension.dao;

import java.util.ArrayList;

import kr.co.pension.dto.TourDTO;

public interface TourDAO {
	public ArrayList<TourDTO> tlist();
	public void writeOk(TourDTO tdto);
	public void readnum(String id);
	public TourDTO content(String id);
	public boolean userchk(String userid,String id);
}
