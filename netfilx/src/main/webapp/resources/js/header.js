function profile(row){
	var path=row+"/profile/user/json";
	var result="";
	$.ajax({
		url : path,
		type : "get",
		dataType:"json",
		success : function(data){
			$.each(data.profileList,function(index, item){
				result+="<li class='profile_row'>" +
						"<a data-toggle='modal' data-target='#myModal' class='modalProfileNum' data-profile_num="+item.profile_num+">";
				result+="<img src='"+item.pimg_src+"' width='30'>"+item.nickname+"</a></li>";
			});
			$(".profile_row").remove();
			$("#profile_row").prepend(result);
			jQuery(function($){
				$(".modalProfileNum").click(function(){
					var num = $(this).data("profile_num");
					$("#profile_num").val(num);
				});
			});
		}
	});
}
jQuery(function($){
	$(".modalProfileNum").click(function(){
		var num = $(this).data("profile_num");
		$("#profile_num").val(num);
	});
});
function alarm_view(row){
	var path=row+"/alarm/list";
	var result="";
	$.ajax({
		url : path,
		type : "get",
		dataType:"json",
		success : function(data){
			$.each(data.alarm_list,function(index, item){
				if(item.alarm_state=='1'){
				result+="<li class='alarm_list'>";
				result+="<a href='"+row+"/content/contentPlay?content_num="+item.content_num+"'>"+item.alarm_content+"보러가기</a></li>";
				}else{
					result+="<li class='alarm_list alarm'>";	
					result+="<a href='"+row+"/alarm/content?content_num="+item.content_num+"&au_num="+item.au_num+"'>"+item.alarm_content+"보러가기</a></li>";
				}
			});
			$(".alarm_row").remove();
			$("#alarm_row").prepend(result);
		}
	});
}
