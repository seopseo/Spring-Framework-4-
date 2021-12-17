package co.micol.potal.board.web;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import co.micol.potal.board.service.BoardService;
import co.micol.potal.board.service.BoardVO;


@Controller
public class BoardController {
   
   @Autowired
   BoardService boardDao;
   
   // 이하 Mapper 메소드를 만들어준다.
   @RequestMapping("/noticeList.do")
   public String noticeList(Model model) {
      model.addAttribute("boards", boardDao.boardSelectList());      // 게시글 전체 리스트 가져오기
      return "board/noticeList";
      
   }

   @PostMapping("/boardRead.do")
   public String boardRead(BoardVO vo, Model model) {
	   vo = boardDao.boardSelect(vo);
	   if(vo != null) {
		   model.addAttribute("board", vo); // 글담고
		   boardDao.boardHit(vo.getNo()); // 조히수 증가
		   
	   }else {
		   model.addAttribute("message", "게시글이 존재하지 않습니다.");
	   }
	   		return "board/boardRead";
	   }
   
	@PostMapping("/ajaxBoardSearch.do")
	@ResponseBody
	public List<BoardVO> ajaxBoardSearch(@RequestParam("key") String key, @RequestParam("val") String val) {
		   return boardDao.boardSearchList(key, val);
	}
	
	@RequestMapping("/boardForm.do")
	public String boardForm() {
		return "board/boardForm";
	}
	
	@PostMapping("/boardInsert.do")
	public String boardInsert(BoardVO vo, Model model, HttpSession session) {
		vo.setWriter((String) session.getAttribute("id"));
		
		int result = boardDao.boardInsert(vo);
		
		if(result != 0) {
			model.addAttribute("message","정상적으로 등록되었습니다.");
		}else {
			model.addAttribute("message","등록에 실패하였습니다.<br>다시 등록 해주세요.");
		}

		return "board/boardResult";
	}	
	
	@PostMapping("/boardDelete.do")
	public String boardDelete(BoardVO vo) {
		int n = boardDao.boardDelete(vo);
		if(n != 0) {
			boardDao.boardNoUpdate(vo.getNo());
		}
		return "redirect:noticeList.do";
	}
	
	@PostMapping("/boardUpdateForm.do")
	public String boardUpdateForm(BoardVO vo, Model model, HttpSession session) {
	   vo = boardDao.boardSelect(vo);
	   if(vo != null) {
		   if(vo.getWriter().equals((String) session.getAttribute("id"))) {
			   model.addAttribute("board", vo); // 글담고
		   }else {
			   model.addAttribute("message", "본인이 작성한 글만 수정가능합니다.");
		   }
	   }else {
		   model.addAttribute("message", "게시글이 존재하지 않습니다.");
	   }
	   return "board/boardUpdateForm";
	}
	
	@PostMapping("/boardUpdate.do")
	public String boardUpdate(BoardVO vo) {
		boardDao.boardUpdate(vo);
		return "redirect:noticeList.do";
	}	
}