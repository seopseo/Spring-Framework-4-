package co.micol.potal.member.web;

import java.io.File;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import co.micol.potal.member.service.MemberService;
import co.micol.potal.member.service.MemberVO;

@Controller
public class MemberController {
	@Autowired
	MemberService memberDao; //DAO 자동주입
	
	@Autowired
	ServletContext servletContext;
	
	@RequestMapping("/loginForm.do")
	public String loginForm() {
		return "member/loginForm"; // 폼호출
	}
	
	@PostMapping("/memberLogin.do")
	public String memberLogin(MemberVO vo, Model model, HttpSession session) {
		vo = memberDao.memberSelect(vo); //아이디 패스워드를 보내서 결과를 vo객체에 받는다.
		if(vo !=null) {
			session.setAttribute("id", vo.getId());
			session.setAttribute("name", vo.getName());
			session.setAttribute("author", vo.getAuthor());
			model.addAttribute("message","님 환영합니다.");
		}else {
			model.addAttribute("message","아이디 또는 패스워드가 틀렸습니다.");
		}
		return "member/memberLoginResult";
	}

	@RequestMapping("/memberLogout.do")
	public String memberLogout(HttpSession session, Model model) {
		String name =(String) session.getAttribute("name");//세션을 보관된 이름 가져오기
		model.addAttribute("message", name + " 님 정상적으로 로그아웃 되었습니다.");
		session.invalidate(); //session을 완전 삭제한다
	
		return "member/memberLoginResult";
	}
	
	@RequestMapping("/memberJoinForm.do")
	public String memberJoinForm() {
		return "member/memberJoinForm";
	}	
	
	@PostMapping("/idCheck.do")
	@ResponseBody
	public String idCheck(@RequestParam("id") String id) {
		boolean b = memberDao.memberIdCheck(id);
		if(b) {
			return "0"; // 존재할때
		}else {
			return "1"; // 존재하지 않을때
		}
	}
	
	@PostMapping("/memberJoin.do")
	public String memberJoin(MemberVO vo, MultipartFile file, Model model) {
		//System.out.print(vo.getId());
		String upload = servletContext.getRealPath("resources");
		upload = upload + "//fileUpload//"; //배포시 사용할 파일저장공간
		String sourceFileName = file.getOriginalFilename();
		String uuid = UUID.randomUUID().toString();
		String targetFileName = uuid + sourceFileName.substring(sourceFileName.lastIndexOf("."));
		
		if(!sourceFileName.isEmpty()) {
			try {
				file.transferTo(new File(upload, targetFileName));
				vo.setImgfile(sourceFileName);
				vo.setPimgfile(targetFileName);
				int result = memberDao.memberInsert(vo);
				if(result != 0) {
					model.addAttribute("message","축하합니다.<br>성공적으로 회원가입이 되었습니다.<br>로그인 후 이용가능 합니다.");
				}else {
					model.addAttribute("message","회원가입이 실패 하였습니다.<br>다시 가입 해주세요.");
				}
			}catch (Exception e) {
				e.printStackTrace();
			}
		}else {
			int result = memberDao.memberInsert(vo);
			if(result != 0) {
				model.addAttribute("message","축하합니다.<br>성공적으로 회원가입이 되었습니다.<br>로그인 후 이용가능 합니다.");
			}else {
				model.addAttribute("message","회원가입이 실패 하였습니다.<br>다시 가입 해주세요.");
			}
		}

		return "member/memberJoin";
	}
	
	@RequestMapping("/memberInfo.do")
	public String memberInfo(MemberVO vo, Model model, HttpSession session) {
		vo.setId((String) session.getAttribute("id"));
		model.addAttribute("member", memberDao.memberSelect(vo));
		return "member/memberInfo";
	}
	
	@RequestMapping("/ajaxMemberlist.do")
	@ResponseBody
	public List<MemberVO> ajaxMemberlist(Model model){
		return memberDao.memberSelectList();
	}
}
	