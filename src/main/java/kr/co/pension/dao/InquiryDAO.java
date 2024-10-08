package kr.co.pension.dao;

import kr.co.pension.dto.InquiryDTO;

public interface InquiryDAO {
	public int getNumber(String inum);
	public void writeOk(InquiryDTO idto);
	public InquiryDTO getInquiry(String inqNumber);
}
