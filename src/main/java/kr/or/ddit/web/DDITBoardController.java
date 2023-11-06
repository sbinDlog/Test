package kr.or.ddit.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.service.IDDITBoardService;
import kr.or.ddit.service.ITestMemberService;
import kr.or.ddit.vo.DDITBoardVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.TestMemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/board")
public class DDITBoardController {

	@Inject
	private IDDITBoardService dditBoardService;
	
	@Inject
	private ITestMemberService testMemberService;
	
	
	@RequestMapping(value="/login.do", method= RequestMethod.GET)
	public String boardLogin(Model model) {
		model.addAttribute("bodyText", "login-page");
		return "board/login";
	}

	 
	@RequestMapping(value="/loginCheck.do", method=RequestMethod.POST)
	public String loginCheck(HttpServletRequest req, TestMemberVO member, Model model) {
		String goPage="";
		Map<String, String> errors = new HashMap<String, String>();
		
		if(StringUtils.isBlank(member.getMemId())) {
			errors.put("memId", "아이디를 입력해주세요.");
		}
		if(StringUtils.isBlank(member.getMemPw())) {
			errors.put("memPw", "비밀번호를 입력해주세요.");
		}
		if(errors.size() > 0) {		//에러 발생
			model.addAttribute("errors", errors);
			model.addAttribute("member", member);
			model.addAttribute("bodyText", "login-page");
			goPage = "board/login";
		}else {
			TestMemberVO memberVO = testMemberService.loginCheck(member);
			if(memberVO != null) {	//로그인 성공
				// 로그인 성공 후, 세션 처리
				HttpSession session = req.getSession();
				session.setAttribute("SessionInfo", memberVO);
				goPage = "redirect:/board/list.do";
			}else {
				model.addAttribute("message", "서버에러, 로그인 정보를 정확하게 입력해주세요.");
				model.addAttribute("member", member);
				model.addAttribute("bodyText", "login-page");
				goPage = "board/login";
			}
		}
		return goPage;
	}
	
	
	
	@RequestMapping(value="/signup.do", method= RequestMethod.GET)
	public String noticeSignupForm(Model model) {
		model.addAttribute("bodyText", "register-page");
		return "board/signup";
	}
	
	
	@RequestMapping(value="/signup.do", method= RequestMethod.POST)
	public String singup(
			TestMemberVO memberVO, Model model, RedirectAttributes ra) {
		String goPage="";
		
		Map<String, String> errors = new HashMap<String, String>();
		if(StringUtils.isBlank(memberVO.getMemId())) {
			errors.put("memId", "아이디를 입력해주세요.");
		}
		if(StringUtils.isBlank(memberVO.getMemId())) {
			errors.put("memPw", "비밀번호를 입력해주세요.");
		}
		if(StringUtils.isBlank(memberVO.getMemId())) {
			errors.put("memName", "이름을 입력해주세요.");
		}
		
		if(errors.size() > 0 ) {	//에러가 발생
			model.addAttribute("bodyText", "register-page");
			model.addAttribute("errors", errors);
			model.addAttribute("member", memberVO);
			goPage = "board/signup";
		}else {
			ServiceResult result = testMemberService.signup(memberVO);
			
			if(result.equals(ServiceResult.OK)) {
				ra.addFlashAttribute("message", "회원가입을 완료하였습니다!");	// 일회성 메세지
				goPage = "redirect:/board/login.do";
			}else {	//회원가입 실패
				model.addAttribute("bodyText", "register-page");
				model.addAttribute("message", "서버에러, 다시 시도해주세요!");
				model.addAttribute("member", memberVO);
				goPage = "board/signup";
			}
		}
		return goPage;
	}
	
	
	
	@RequestMapping(value="/register.do", method= RequestMethod.GET)
	public String registerForm() {
		return "board/register";
	}
	
	// 회원가입 후 게시물 등록경우
	@RequestMapping(value="/register.do", method= RequestMethod.POST)
	public String boardRegister(DDITBoardVO boardVO, Model model, 
			 HttpSession session) {
		String goPage ="";
		
		Map<String, String> errors = new HashMap<String, String>();
		if(StringUtils.isBlank(boardVO.getBoTitle())) {
			errors.put("boTitle", "제목을 입력해주세요!");
		}
		if(StringUtils.isBlank(boardVO.getBoContent())) {
			errors.put("boContent", "내용을 입력해주세요!");
		}
		if(errors.size() > 0) {		//에러가 발생
			model.addAttribute("errors", errors);
			model.addAttribute("board", boardVO);
			goPage = "board/register";
		}else {
			TestMemberVO memberVO = (TestMemberVO)session.getAttribute("SessionInfo");
			if(memberVO != null) {
				// 로그인 후 등록된 세션 정보(로그인 한 회원 정보가 들어있음)
				// 회원 정보 중, id를 작성자로 셋팅
				boardVO.setBoWriter(memberVO.getMemId());
				
				//boardVO.setBoWriter("a001");		//로그인 안할 때
				dditBoardService.insertBoard(boardVO);
				model.addAttribute("board", boardVO);
				model.addAttribute("member", memberVO);
			}
			//model.addAttribute("message", "등록이 완료되었습니다!");
		}
		return "redirect:/board/detail.do?boNo="+ boardVO.getBoNo();
	}

	
	@RequestMapping(value="/list.do")
	public String boardList(
			@RequestParam(name="page", required = false, defaultValue= "1") int currentPage,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String searchWord,
			Model model) {
		PaginationInfoVO<DDITBoardVO> pagingVO = new PaginationInfoVO<DDITBoardVO>();
		
		//검색(검색 키워드가 공백이 아니면)이 이루어지면 아래가 실행이 됨.
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
		}
		
		pagingVO.setCurrentPage(currentPage);
		int totalRecord = dditBoardService.selectBoardCount(pagingVO);	//총 게시글 수
		
		pagingVO.setTotalRecord(totalRecord);
		
		List<DDITBoardVO> dataList = dditBoardService.selectBoardList(pagingVO);
		pagingVO.setDataList(dataList);
		
		model.addAttribute("pagingVO", pagingVO);		
		
		return "board/list";
	}
	
	// 상세페이지
	@RequestMapping(value="/detail.do", method= RequestMethod.GET)
	public String boardDetail(int boNo, Model model) {
		DDITBoardVO boardVO = dditBoardService.selectBoard(boNo);	
		log.info("boardVo >>>>>>  "+ boardVO);
		log.info("태그 리스트: " + boardVO.getTagList());
		log.info("태그: " + boardVO.getTag());
		
		model.addAttribute("board", boardVO);
		model.addAttribute("tagList", boardVO.getTagList());
		
		return "board/detail";
	}
	
	// 수정 폼 페이지
	@RequestMapping(value="/modify.do", method = RequestMethod.GET)
	public String boardModifyForm(int boNo, Model model) {
		DDITBoardVO boardVO = dditBoardService.selectBoard(boNo);
		
		model.addAttribute("board", boardVO);
		model.addAttribute("status", "u");
		return "board/register";
	}
	
	
	// 수정 post
	@RequestMapping(value="/modify.do", method = RequestMethod.POST)
	public String boardModify(DDITBoardVO boardVO, Model model) {
		String goPage ="";
		dditBoardService.modify(boardVO);
		model.addAttribute("board", boardVO);
		goPage ="redirect:/board/detail.do?boNo="+boardVO.getBoNo();
		return goPage;
	}
	
	//삭제
	@RequestMapping(value="/delete.do", method=RequestMethod.POST)
	public String boardDelete(int boNo, Model model) {
		String goPage ="";
		//게시물과 tag가 같이 삭제되어야 함.
		dditBoardService.deleteBoard(boNo);
		goPage = "redirect:/board/list.do";
 		return goPage;
	}
}
