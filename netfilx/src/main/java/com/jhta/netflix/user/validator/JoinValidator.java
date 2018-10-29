package com.jhta.netflix.user.validator;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.jhta.netflix.lib.Valid;
import com.jhta.netflix.user.vo.DefaultJoinVo;

public class JoinValidator implements Validator{

	@Override
	public boolean supports(Class<?> clazz) {
		return DefaultJoinVo.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		DefaultJoinVo vo=(DefaultJoinVo)target;
		if(!Valid.isValidEmail(vo.getId())) {
			System.out.println("1");
			errors.rejectValue("id","email","이메일 형식이 아닙니다.");
		}else if(!vo.getPwd().equals(vo.getPwd2())) {
			System.out.println("2");
			errors.rejectValue("pwd","password","비밀번호가 일치하지 않습니다.");
		}else if(!Valid.validationPasswd(vo.getPwd())) {
			System.out.println("3");
			errors.rejectValue("pwd","password","숫자 특수문자 대소문자가 포함되어야 합니다");
		}else if(!Valid.isNumber(vo.getBirth())) {
			System.out.println("4");
			errors.rejectValue("birth","birth","숫자만입력가능합니다.");
		}else if(vo.getEmail_boolean().equals("false")) {
			System.out.println("5");
			errors.rejectValue("email_boolean","email_boolean","중복확인을 해주세요");
		}
		
	}

}
