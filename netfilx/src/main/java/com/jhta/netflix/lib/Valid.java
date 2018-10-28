package com.jhta.netflix.lib;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Valid {
	public static boolean isValidEmail(String email) {
		  boolean err = false;
		  String regex = "^[_a-z0-9-]+(.[_a-z0-9-]+)*@(?:\\w+\\.)+\\w+$";   
		  Pattern p = Pattern.compile(regex);
		  Matcher m = p.matcher(email);
		  if(m.matches()) {
		   err = true; 
		  }
		  return err;
	}
	
	public static boolean isNumber(String str) {
		return str.matches("^[0-9]*$");
	}
	public static boolean validationPasswd(String pw){
		boolean err = false;
		String regex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$";
	    Pattern p = Pattern.compile(regex);
	    Matcher m = p.matcher(pw);
	    if(m.matches()){
	        err = true;
	    }
	    return err;
	}
}
