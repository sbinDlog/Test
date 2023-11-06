package kr.or.ddit.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.vo.DDITBoardVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface IDDITBoardService {

	public void insertBoard(DDITBoardVO boardVO);

	public DDITBoardVO selectBoard(int boNo);

	public int selectBoardCount(PaginationInfoVO<DDITBoardVO> pagingVO);

	public List<DDITBoardVO> selectBoardList(PaginationInfoVO<DDITBoardVO> pagingVO);

	public void deleteBoard(int boNo);

	public void modify(DDITBoardVO boardVO);

	
	
	

}
