//onchange event
function sel_group(group_no){
	var path = $("#path").val()+"/admin/profile/group-img";
	$("#pro_group_no").val(group_no);
	$.ajax({
		url : path,
		type : "get",
		dataType:"json",
		data : {"group_no":group_no},
		success : function(data){
			var rs ="<ul class='vmcarousel-normal'>";
			$.each(data.profile_group_img,function(index, item){
				rs += "<li><img src='"+item.pimg_src+"' width='150' height='150' id='"+item.pimg_num+"' onclick='sel_pimg("+item.pimg_num+")'></li>";
			});
			rs+="</ul>";
			$("#proImg-slide").html(rs);
			      $('.vmcarousel-normal').vmcarousel({
			         centered: false,
			         start_item: 0,
			         autoplay: false,
			         infinite: false
			      });
		}
	});
};
//group delete
function pro_group_del(){
	var group_no = $("#pro_group_no").val();
	var path = $("#path").val()+"/admin/profile/group/del?group_no="; 
	location.href=path+group_no;
}

function pimg_del(){
	var pimg_no = $("#pimg_no").val();
	if(pimg_no==null){
		return false;
	}
	var path = $("#path").val()+"/admin/profile/img/del?pimg_no=";
	location.href=path+pimg_no;
}

function sel_pimg(no){
	$("#pimg_no").val(no);
}
function group_ck(){
	var no = $("#pro_group_no").val();
	if(no=="" || no==null){
		alert("그룹을 선택해 주세요")
		return false;
	}
}