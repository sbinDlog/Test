package kr.or.ddit.service;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.mapper.TestMemberMapper;
import kr.or.ddit.vo.TestMemberVO;


@Service
public class TestMemberServiceImpl implements ITestMemberService{

	@Inject
	private TestMemberMapper testMemberMapper;
	
	@Override
	public ServiceResult signup(TestMemberVO memberVO) {
 		ServiceResult result = null;
 		
 		int status = testMemberMapper.signup(memberVO);
 		
 		if(status > 0) {
 			result = ServiceResult.OK;
 		}else {
 			result = ServiceResult.FAILED;
 		}
		return result;
	}

	@Override
	public TestMemberVO loginCheck(TestMemberVO member) {
 		return testMemberMapper.loginCheck(member);
	}
	
}
