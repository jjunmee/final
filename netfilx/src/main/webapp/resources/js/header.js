function profile(row){
	var path=row+"/profile/user/json";
	var result="";
	$.ajax({
		url : path,
		type : "get",
		dataType:"json",
		success : function(data){
			$.each(data.profileList,function(index, item){
				result+="<li class='profile_row'><a href='"+row+"/profile/user/getInfo?profile_num="+item.profile_num+"'>";
				result+="<img src='"+item.pimg_src+"' width='3'>"+item.nickname+"</a></li>";
			});
			$(".profile_row").remove();
			$("#profile_row").prepend(result);
		}
	});
}