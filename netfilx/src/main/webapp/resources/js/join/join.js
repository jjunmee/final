var filter =/([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;;
var row=/[0-9]$/;
$(document).ready(function(){
	$("#check").bind("click",function(){
		var ck_id=$("#id").val();
		ck_id.replace(/\s/gi, "");
		var path = $("#path").val()+"/email_check_k";
		if(ck_id){
			if(!filter.test(ck_id)){
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
	$("id").change(function(){
		$("#email_boolean").val("false");
	});
});
	function test(){
		var b = $("#email_boolean").val();
		var pw1 = $("#pwd").val();
		var pw2 = $("#pwd2").val();
		var birth = $("#birth").val();
		if(b){
			$("#id").focus();
		}else if(!filter.test(b)){
			$("#id").focus();
		}else if(pw1){
			$("#pwd").focus();
		}else if(pw2){
			$("#pwd2").focus();
		}else if(birth){
			$("#birth").focus();
		}else if(!row.test(birth)){
			$("#birth").focus();
		}
		return false;
	}