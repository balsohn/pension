package kr.co.pension.controller;

import java.util.ArrayList;
import java.util.Random;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.WebUtils;

import kr.co.pension.dao.MemberDAO;
import kr.co.pension.dao.ReserveDAO;
import kr.co.pension.dto.InquiryDTO;
import kr.co.pension.dto.MemberDTO;
import kr.co.pension.dto.ReserveDTO;
import kr.co.pension.util.MailSend;
import kr.co.pension.util.Utils;

@Controller
public class MemberController {

	@Autowired
	private SqlSession sql;
	
	// 아래의 두개의 매핑은 독립시켜서 다른 컨트롤러에 담아도 된다.
	@RequestMapping("/")
	public String home() {
		return "redirect:/main/index";
	}
	
	@RequestMapping("/main/index")
	public String index() {
		return "/main/index";
	}
	
	
	@RequestMapping("/member/member")
	public String member() {
		return "/member/member";
	}
	
	@RequestMapping("/member/useridChk")
	public @ResponseBody String useridChk(HttpServletRequest request) {
		MemberDAO mdao=sql.getMapper(MemberDAO.class);
		String userid=request.getParameter("userid");
		
		return mdao.useridChk(userid);
	}
	
	@RequestMapping("/member/memberOk")
	public String memberOk(MemberDTO mdto) {
		MemberDAO mdao=sql.getMapper(MemberDAO.class);
		mdao.memberOk(mdto);
		
		return "redirect:/member/login";
	}
	
	@RequestMapping("member/loginOk")
	public String loginOk(MemberDTO mdto,HttpSession session,HttpServletRequest request,HttpServletResponse response) {
		MemberDAO mdao=sql.getMapper(MemberDAO.class);
		
		if(mdao.loginOk(mdto)==1) {
			session.setAttribute("userid", mdto.getUserid());
			
			Cookie cookie=WebUtils.getCookie(request, "url");
			if (cookie == null) {
	            return "redirect:/main/index";
	        } else {
	            // 원래 URL로 리디렉션 후 쿠키 삭제
	            String originalURL = cookie.getValue();
	            cookie=new Cookie("url","");
	            cookie.setMaxAge(0);
	            cookie.setPath("/");
	            response.addCookie(cookie);
	            return "redirect:"+originalURL;  // 상대 경로 사용하지 않고 절대 경로로 리디렉션
	        }
			
			
		} else {
			return "redirect:/member/login?err=1";
		}	
	}
	
	@RequestMapping("/member/login")
	public String login(HttpServletRequest request,Model model) {
		String err=request.getParameter("err");
		model.addAttribute("err",err);
		return "/member/login";
	}
	
	@RequestMapping("/member/logout")
	public String logout(HttpSession session) {
		session.invalidate();		
		return "redirect:/main/index";
	}
	
	@RequestMapping("/member/usForm")
	public String usForm() {
		return "/member/usForm";
	}
	
	@RequestMapping("/member/useridSearch")
	public String useridSearch(MemberDTO mdto,Model model) {
		MemberDAO mdao=sql.getMapper(MemberDAO.class);
		String userid=mdao.usSearch(mdto);
		
		model.addAttribute("userid",userid);
		
		return "/member/useridSearch";
	}
	
	@RequestMapping("/member/psForm")
	public String psForm() {
		return "/member/psForm";
	}
	
	@RequestMapping("/member/asdf")
	public String asdf(MemberDTO mdto,Model model,HttpServletResponse response) throws Exception {
		Cookie cookie=new Cookie("userid",mdto.getUserid());
		cookie.setMaxAge(300);
		response.addCookie(cookie);
		
		cookie=new Cookie("name",mdto.getName());
		cookie.setMaxAge(300);
		response.addCookie(cookie);
		
		cookie=new Cookie("email",mdto.getEmail());
		cookie.setMaxAge(300);
		response.addCookie(cookie);
		MemberDAO mdao=sql.getMapper(MemberDAO.class);
		int chk=mdao.pwdSearch(mdto);
		if(chk==1) {
			MailSend mail=MailSend.getInstance();
			
			String len = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
			int length=10;
			String imsipwd="";
			for(int i=0;i<length;i++) {
				int index=(int)(Math.random()*len.length());
				String a=len.substring(index,index+1);
				imsipwd+=a;
			}
			System.out.println(imsipwd);
			cookie=new Cookie("imsi", imsipwd);
			cookie.setMaxAge(300);
			response.addCookie(cookie);
			
		//	System.out.println(imsipwd);
			mail.setEmail("balsohn@gmail.com", "비밀번호 변경을 위한 인증번호", "인증번호 : "+imsipwd);
			return "redirect:/member/psForm1";			
		} else {
			return "redirect:/member/psForm?err=1";
		}
	}
	
	@RequestMapping("/member/psForm1")
	public String psForm1() {
		return "/member/psForm1";
	}
	
	@RequestMapping("/member/reserveList")
    public String reserveList(HttpSession session,
    		Model model)
    {
    	String userid=session.getAttribute("userid").toString();
    	
    	MemberDAO mdao=sql.getMapper(MemberDAO.class);
    	ArrayList<ReserveDTO> rlist=mdao.reserveList(userid);
    	
    	for(int i=0;i<rlist.size();i++)
    	{
    		boolean chk=Utils.dayBefore2(rlist.get(i).getOutday()); // 퇴실일
    		rlist.get(i).setChk(chk);
    	}
    	
    	
    	model.addAttribute("rlist" , rlist);
    	
    	return "/member/reserveList";
    	    	
    }
	
	
	@RequestMapping("/member/psForm2chk")
	public String psForm2chk(HttpServletRequest request,HttpServletResponse response) {
		Cookie cookie=WebUtils.getCookie(request, "imsi");
		String imsi=cookie.getValue();
		String imsi2=request.getParameter("confirm");
		if(imsi.equals(imsi2)) {
			cookie=new Cookie("test","1");
			cookie.setMaxAge(300);
			response.addCookie(cookie);
			return "redirect:/member/psForm2";
		} else {
			return "redirect:/member/psForm1?err=1";
		}
	}
	
	@RequestMapping("/member/psForm2")
	public String psForm2(HttpServletRequest request,HttpSession session) {
		Cookie cookie=WebUtils.getCookie(request, "test");
		Object useridchk=session.getAttribute("userid");
		System.out.println(cookie+" "+useridchk);
		if(cookie==null && useridchk==null) {
			
			return "redirect:/main/index";
		} else {
			return "/member/psForm2";
		}
	}
	
	@RequestMapping("/member/pwdchg")
	public String pwdchg(MemberDTO mdto,HttpServletRequest request,HttpSession session) {
		MemberDAO mdao=sql.getMapper(MemberDAO.class);
		Cookie cookie=WebUtils.getCookie(request, "userid");
		Object useridchk=session.getAttribute("userid");
		String userid="";
		if(useridchk!=null) {
			userid=useridchk.toString();
		} else if(cookie!=null) {
			userid=cookie.getValue();
		}
		mdto.setUserid(userid);
		cookie=WebUtils.getCookie(request, "email");
		mdto.setEmail(cookie.getValue());
		cookie=WebUtils.getCookie(request, "name");
		mdto.setName(cookie.getValue());	
		mdao.pwdchg(mdto);
		
		return "redirect:/member/login";
	}
	
	@RequestMapping("/member/memberView")
	public String memberView(HttpSession session,Model model) {
		Object useridchk=session.getAttribute("userid");
		if(useridchk==null) {
			return "redirect:/member/login";
		} else {
			String userid=useridchk.toString();
			
			MemberDAO mdao=sql.getMapper(MemberDAO.class);
			MemberDTO mdto=mdao.memberView(userid);
			
			model.addAttribute("mdto",mdto);
			
			return "/member/memberView";
		}
	}
	
	@RequestMapping("/member/emailEdit")
	public String emailEdit(HttpSession session,HttpServletRequest request) {
		Object useridchk=session.getAttribute("userid");
		if(useridchk==null) {
			return "redirect:/member/login";
		} else {
			MemberDAO mdao=sql.getMapper(MemberDAO.class);
			String email=request.getParameter("email");
			String userid=useridchk.toString();
			mdao.emailEdit(email,userid);
			
			return "redirect:/member/memberView";
		}
	}
	
	@RequestMapping("/member/phoneEdit")
	public String phoneEdit(HttpSession session,HttpServletRequest request) {
		Object useridchk=session.getAttribute("userid");
		if(useridchk==null) {
			return "redirect:/member/login";
		} else {
			MemberDAO mdao=sql.getMapper(MemberDAO.class);
			String phone=request.getParameter("phone");
			String userid=useridchk.toString();
			mdao.phoneEdit(phone,userid);
			
			return "redirect:/member/memberView";
		}
	}
	
	@RequestMapping("/member/pwdchk")
	public String pwdchk(HttpServletRequest request,HttpSession session,HttpServletResponse response) {
		String oldpwd=request.getParameter("oldpwd");
		Object useridchk=session.getAttribute("userid");
		if(useridchk==null) {
			return "redirect:/member/login";
		} else {
			String userid=useridchk.toString();
			MemberDAO mdao=sql.getMapper(MemberDAO.class);
			MemberDTO mdto=mdao.pwdchk(userid);
			if(oldpwd.equals(mdto.getPwd())) {
				Cookie cookie=new Cookie("name",mdto.getName());
				cookie.setMaxAge(300);
				response.addCookie(cookie);
				
				cookie=new Cookie("email",mdto.getEmail());
				cookie.setMaxAge(300);
				response.addCookie(cookie);
				
				return "redirect:/member/psForm2";
			} else {
				return "redirect:/member/memberView?err=1";
			}
		}
	}
	
	@RequestMapping("/member/myWrite")
	public String myWrite(HttpSession session,Model model) {
		
		if(session.getAttribute("userid")==null) {
			return "redirect:/member/login";
		} else {
			String userid=session.getAttribute("userid").toString();
			MemberDAO mdao=sql.getMapper(MemberDAO.class);
			ArrayList<InquiryDTO> inquirys=mdao.getInquirys(userid);
			
			for(int i=0;i<inquirys.size();i++) {
				InquiryDTO idto=inquirys.get(i);
				
				switch(idto.getTitle()) {
				case 0: idto.setTitle2("펜션 예약"); break;
				case 1: idto.setTitle2("입실 퇴실"); break; 
				case 2: idto.setTitle2("주변 맛집"); break;
				case 3: idto.setTitle2("웹 사이트"); break;
				case 4: idto.setTitle2("기타"); break;
				default: idto.setTitle2("");
				}
				
				if(idto.getState()==0) {
					idto.setAnswer("답변 대기중");
				} else {
					String answer=idto.getAnswer().replace("\r\n", "<br>");
					idto.setAnswer(answer);
				}

				if(idto.getContent().length()>15) {
				idto.setContent2(idto.getContent().substring(0,15)+"...");
				} else {
					idto.setContent2(idto.getContent());
				}
				
				idto.setContent(idto.getContent().replace("\r\n", "<br>"));
			}

			model.addAttribute("inqlist",inquirys);
			
			return "/member/myWrite";
		}
	}
	
	
	
}
