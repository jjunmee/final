function sel_group(group_no){
	var path = $("#path").val()+"/admin/profile/group-img";
	$.ajax({
		url : path,
		type : "get",
		dataType:"json",
		data : {"group_no":group_no},
		success : function(data){
			var rs ="";
			$.each(data.profile_group_img,function(index, item){
				rs += "<img src='"+item.pimg_src+"' id='"+item.pimg_num+"' >";
			});
			$("#proImg-slide").html(rs);
		}
	});
};