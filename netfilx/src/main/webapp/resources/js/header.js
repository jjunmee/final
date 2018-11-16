function profile(row){
	var path=row+"/profile/user/json";
	var result="";
	$.ajax({
		url : path,
		type : "get",
		dataType:"json",
		success : function(data){
			$.each(data.profileList,function(index, item){
				//"<a href='"+row+"/profile/user/getInfo?profile_num="+item.profile_num+"'>";
				result+="<li class='profile_row'>" +
						"<a data-toggle='modal' data-target='#myModal' class='modalProfileNum' data-profile_num="+item.profile_num+" data-row='"+row+"/profile/user/getInfo'>";
				result+="<img src='"+item.pimg_src+"' width='3'>"+item.nickname+"</a></li>";
			});
			$(".profile_row").remove();
			$("#profile_row").prepend(result);
			jQuery(function($){
				$(".modalProfileNum").click(function(){
					var num = $(this).data("profile_num");
					$("#profile_num").val(num);
					var row = $(this).data("row");
					$("#modalProfile").attr("action", row);
				});
			});
		}
	});
}
jQuery(function($){
	$(".modalProfileNum").click(function(){
		var num = $(this).data("profile_num");
		$("#profile_num").val(num);
		var row = $(this).data("row");
		$("#modalProfile").attr("action", row);
	});
});
