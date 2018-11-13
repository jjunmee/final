function pwdCk(){
	var pwd = $("#pwd").val();
	var pwd1 = $("#pwd1").val();
	if(pwd != pwd1){
		return false;
	}
	
}

function change_child(row){
	var f = true;
	if(row == "false"){
		f= false;
	}
	$("#child").val(f);
}