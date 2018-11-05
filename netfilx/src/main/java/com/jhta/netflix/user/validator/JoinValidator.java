package com.jhta.netflix.user.validator;

import javax.servlet.http.HttpServletRequest;

import org.apache.tiles.request.ApplicationContext;
import org.apache.tiles.request.Request;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;
import org.springframework.web.bind.annotation.RequestAttribute;

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
			errors.rejectValue("id","email","이메일 형식이 아닙니다.");
		}else if(!vo.getPwd().equals(vo.getPwd2())) {
			errors.rejectValue("pwd","password","비밀번호가 일치하지 않습니다.");
		}else if(!Valid.validationPasswd(vo.getPwd())) {
			errors.rejectValue("pwd","password","숫자 특수문자 대소문자가 포함되어야 합니다");
		}else if(!Valid.isNumber(vo.getBirth())) {
			errors.rejectValue("birth","birth","숫자만입력가능합니다.");
		}else if(vo.getEmail_boolean().equals("false")) {
			errors.rejectValue("email_boolean","email_boolean","중복확인을 해주세요");
		}
		
	}

}
