package kr.or.ddit.service;


import kr.or.ddit.ServiceResult;
import kr.or.ddit.vo.TestMemberVO;

public interface ITestMemberService {

	public ServiceResult signup(TestMemberVO memberVO);

	public TestMemberVO loginCheck(TestMemberVO member);

}
