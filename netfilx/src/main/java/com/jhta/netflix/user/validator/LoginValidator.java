package com.jhta.netflix.user.validator;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.jhta.netflix.lib.Valid;
import com.jhta.netflix.user.vo.LoginVo;

public class LoginValidator  implements Validator{

	@Override
	public boolean supports(Class<?> clazz) {
		return LoginVo.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		LoginVo vo = (LoginVo)target;
		if(!Valid.isValidEmail(vo.getId())) {
			errors.rejectValue("id","id","아이디와 비밀번호가 다릅니다.");
		}else if(!Valid.validationPasswd(vo.getPwd())) {
			errors.rejectValue("pwd", "pwd", "아이디와 비밀번호가 다릅니다.");
		}
	}

}
