function pwdCk(){
	var pwd = $("#pwd");
	var pwd1 = $("#pwd1");
	var ck = $("#profile_num1");
	var nic = $("#nickname");
	if(ck.val()!==null && ck.val()!=""){
		if(pwd.val()!="" || pwd1.val()!=""){
			if(pwd.val() != pwd1.val()){
				pwd.focus();
				return false;
			}
		}
		if(nic.val()==null){
			nic.focus();
			return false;
		}
	}else{
		if(nic.val()==""){
			nic.focus();
			return false;
		}else if(pwd.val()==""){
			pwd.focus();
			return false;
		}else if(pwd1.val()==""){
			pwd1.focus();
			return false;
		}else if(pwd.val() != pwd1.val()){
			pwd.focus();
			return false;
		}
	}
}

function change_child(row){
	var f = true;
	if(row == "false"){
		f= false;
	}
	$("#child").val(f);
}