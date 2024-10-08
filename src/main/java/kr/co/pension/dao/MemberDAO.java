package kr.co.pension.dao;

import java.util.ArrayList;

import kr.co.pension.dto.InquiryDTO;
import kr.co.pension.dto.MemberDTO;
import kr.co.pension.dto.ReserveDTO;

public interface MemberDAO {
	public String useridChk(String userid);
	public void memberOk(MemberDTO mdto);
	public int loginOk(MemberDTO mdto);
	public String usSearch(MemberDTO mdto);
	public int pwdSearch(MemberDTO mdto);
	public void pwdchg(MemberDTO mdto);
	public MemberDTO memberView(String userid);
	public void emailEdit(String email,String userid);
	public void phoneEdit(String phone,String userid);
	public MemberDTO pwdchk(String userid);
	public ArrayList<InquiryDTO> getInquirys(String userid);
	public ArrayList<ReserveDTO> reserveList(String userid);
}
