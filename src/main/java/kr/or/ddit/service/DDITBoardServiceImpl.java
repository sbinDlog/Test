package kr.or.ddit.service;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.mapper.AlramMapper;
import kr.or.ddit.mapper.DDITBoardMapper;
import kr.or.ddit.mapper.TestMemberMapper;
import kr.or.ddit.vo.AlramVO;
import kr.or.ddit.vo.DDITBoardVO;
import kr.or.ddit.vo.DDITTagVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.TestMemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class DDITBoardServiceImpl implements IDDITBoardService {

	@Inject
	private DDITBoardMapper boardMapper;
	
	@Inject
	private AlramMapper alarmMapper;
	
	@Inject
	private TestMemberMapper testMemberMapper;
	
	@Override
	public void insertBoard(DDITBoardVO boardVO) {
		// 1. 게시판을 등록
		boardMapper.insertBoard(boardVO);
		
		// 알람들어가라
		AlramVO alarmVO = new AlramVO();
		alarmVO.setBoNo(boardVO.getBoNo());
		log.info("boardVO.getBoNo() : "+ boardVO.getBoNo());
		log.info("alarmVO : " + alarmVO);
		alarmMapper.insertAlram(alarmVO);
		
		
		// 2. 게시판 태그 등록!!
		DDITTagVO dditTagVO = new DDITTagVO();
		dditTagVO.setBoNo(boardVO.getBoNo());
		dditTagVO.setTag(boardVO.getTag());
		
		String[] longTag =dditTagVO.getTag().split(" ");
		
			for(int i=0; i < longTag.length; i++) {
				DDITTagVO tagVO = new DDITTagVO();
				tagVO.setBoNo(boardVO.getBoNo());
				tagVO.setTag(longTag[i]);
				boardMapper.insertTag(tagVO);
		}
	}

	
	@Override
	public DDITBoardVO selectBoard(int boNo) {
		// 조회수 증가
		boardMapper.incrementHit(boNo);
		return boardMapper.selectBoard(boNo);
	}

	@Override
	public int selectBoardCount(PaginationInfoVO<DDITBoardVO> pagingVO) {
 		return boardMapper.selectBoardCount(pagingVO);
	}

	@Override
	public List<DDITBoardVO> selectBoardList(PaginationInfoVO<DDITBoardVO> pagingVO) {
 		return boardMapper.selectBoardList(pagingVO);
	}


	@Override
	public void deleteBoard(int boNo) {
		// 자식 먼저 삭제 되어야 한다!
		boardMapper.deleteTag(boNo);
 		boardMapper.deleteBoard(boNo);
	}


	@Override
	public void modify(DDITBoardVO boardVO) {
		// 게시판 수정(제목, 내용, 태그)
		boardMapper.modifyBoard(boardVO);
		
		// 게시판 번호에 해당하는 태그 삭제 
		int boNo = boardVO.getBoNo();
		boardMapper.deleteTag(boNo);
		
		// 2. 게시판 태그 등록!!
		DDITTagVO dditTagVO = new DDITTagVO();
		dditTagVO.setBoNo(boardVO.getBoNo());
		dditTagVO.setTag(boardVO.getTag());
				
		String[] longTag =dditTagVO.getTag().split(" ");
				
		for(int i=0; i < longTag.length; i++) {
			DDITTagVO tagVO = new DDITTagVO();
			tagVO.setBoNo(boardVO.getBoNo());
			tagVO.setTag(longTag[i]);
			boardMapper.insertTag(tagVO);
		}
	}


	
}
