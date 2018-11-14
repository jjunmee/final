function profile(row){
	var path=row+"/profile/user/json";
	alert(path);
	$.ajax({
		url : path,
		type : "get",
		dataType:"json",
		success : function(data){
			$.each(data,function(index, item){
				alert(data.profile_num);
			});
		}
	});
}

$("#test").on("click",function(row){
		alert("asdasdasdasd");
});