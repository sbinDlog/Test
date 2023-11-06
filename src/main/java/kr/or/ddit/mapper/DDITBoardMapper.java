package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.vo.DDITBoardVO;
import kr.or.ddit.vo.DDITTagVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface DDITBoardMapper {

	public void insertBoard(DDITBoardVO boardVO);

	public void insertTag(DDITTagVO dditTagVO);

	//조회수
	public void incrementHit(int boNo);

	public DDITBoardVO selectBoard(int boNo);

	public int selectBoardCount(PaginationInfoVO<DDITBoardVO> pagingVO);

	public List<DDITBoardVO> selectBoardList(PaginationInfoVO<DDITBoardVO> pagingVO);

	//삭제
	public void deleteTag(int boNo);
	public void deleteBoard(int boNo);

	public void modifyBoard(DDITBoardVO boardVO);


}
