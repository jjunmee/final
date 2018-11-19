function pwdCk(){
	var pwd = $("#pwd");
	var pwd1 = $("#pwd1");
	var ck = $("#progile_num");
	var nic = $("#nickname");
	if(ck.val()!=null){
		if(pwd.val()!=null || pwd1.val()!=null){
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
		if(nic.val()==null){
			nic.focus();
			return false;
		}else if(pwd.val()==null){
			pwd.focus();
			return false;
		}else if(pwd1.val()==null){
			pwd1.focus();
			return false;
		}else if(pwd.val() != pwd1.val()){
			pwd.focus();
			return false;
		}
		alert(pwd.val());
	}
	
}

function change_child(row){
	var f = true;
	if(row == "false"){
		f= false;
	}
	$("#child").val(f);
}