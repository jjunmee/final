$(document).ready(function(){
	$("#check").bind("click",function(){
		var ck_id=$("#id").val();
		ck_id.replace(/\s/gi, "");
		var path = $("#path").val()+"/email_check_k";
		if(ck_id){
			if(!email.test(ck_id)){
				$("#id").val("");
				$("#id").focus();
				$("#email_ck").html("잘못된 이메일 입니다.");
				return;
			}
			$.ajax({
				url : path,
				type : "get",
				dataType:"json",
				data : {"id":ck_id},
				success : function(data){
					if(!data.success){
						$("#email_ck").html("사용가능");
						$("#email_boolean").val("true");
					}else{
						$("#email_ck").html("사용중인 이메일 또는 잘못된 이메일 입니다.");
					}
				}
			});
		}
	});
	$("id").bind("change",function(){
		$("#email_boolean").val("false");
	});
});
	function joinFormCheck(){
		var b = $("#email_boolean").val();
		var pw1 = $("#pwd").val();
		var pw2 = $("#pwd2").val();
		var birth = $("#birth").val();
		if(!b){
			$("#id").focus();
			return false;
		}else if(!email.test($("#id").val())){
			$("#id").focus();
			return false;
		}else if(pw1==""){
			$("#pwd").focus();
			return false;
		}else if(pw2==""){
			$("#pwd2").focus();
			return false;
		}else if(pw1!=pw2){
			$("#pwd2").empty();
			$("#pwd2").focus();
			return false;
		}else if(!password.test(pw1)){
			$("#pwd").empty();
			$("#pwd2").empty();
			return false;
		}else if(birth==""){
			$("#birth").focus();
			return false;
		}else if(!number.test(birth)){
			$("#birth").focus();
			return false;
		}
	}