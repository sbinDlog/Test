package kr.or.ddit.mapper;

import kr.or.ddit.vo.TestMemberVO;

public interface TestMemberMapper {

	public int signup(TestMemberVO memberVO);

	public TestMemberVO loginCheck(TestMemberVO member);

}
