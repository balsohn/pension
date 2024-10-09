package kr.co.pension.controller;

import java.time.LocalDate;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.pension.dao.InquiryDAO;
import kr.co.pension.dto.InquiryDTO;

@Controller
public class InquiryController {

	@Autowired
	private SqlSession sql;
	
	@RequestMapping("/inquiry/write")
	public String write() {
		return "/inquiry/write";
	}
	
	@RequestMapping("/inquiry/writeOk")
	public String writeOk(HttpSession session,InquiryDTO idto) {
		Object useridchk=session.getAttribute("userid");
		String userid="";
		InquiryDAO idao=sql.getMapper(InquiryDAO.class);
		if(useridchk==null) {
			
			String inum="m";
			LocalDate today=LocalDate.now();
			String year=String.format("%02d", today.getYear()%100);
            String month=String.format("%02d", today.getMonthValue());
            String day=String.format("%02d", today.getDayOfMonth());
            inum=inum+year+month+day;
       
			String num=String.format("%03d", idao.getNumber(inum)+1);
			
			String inqNumber=inum+num;
			idto.setUserid("guest");
			idto.setInqNumber(inqNumber);
			System.out.println(inqNumber);
			idao.writeOk(idto);
			
			return "redirect:/inquiry/nonMemberView?inqNumber="+inqNumber;
		} else {
			
			userid=useridchk.toString();
			idto.setUserid(userid);
			idao.writeOk(idto);
			return "redirect:/member/myWrite";
		}
		
	}
	
	@RequestMapping("/inquiry/nonMemberView")
	public String nonMemberView(HttpServletRequest request,Model model) {
		String inqNumber=request.getParameter("inqNumber");
		
		InquiryDAO idao=sql.getMapper(InquiryDAO.class);
		InquiryDTO idto=idao.getInquiry(inqNumber);
		
		switch( idto.getTitle() )
    	{    
    	    case 0: idto.setTitle2("펜션예약"); break;
    	    case 1: idto.setTitle2("입실퇴실"); break;
    	    case 2: idto.setTitle2("주변맛집"); break;
    	    case 3: idto.setTitle2("웹사이트"); break;
    	    case 4: idto.setTitle2("커뮤니티"); break;
    	    default: idto.setTitle2("");
    	}
        
        String content=idto.getContent().replace("\r\n", "<br>");
        idto.setContent(content);
        
        if(idto.getState()==0)
        {
        	idto.setAnswer("답변 대기중");
        }
        else
        {
            String answer=idto.getAnswer().replace("\r\n", "<br>");
            idto.setAnswer(answer);
        }
		
		
		model.addAttribute("idto",idto);
		
		return "/inquiry/nonMemberView";
		
	}
}
