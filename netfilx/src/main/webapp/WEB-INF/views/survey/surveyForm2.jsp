<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<script type="text/javascript">
	
	var cloneCnt=-1;
	var opNum=-1;	
	var choiceType=0;
	var exist=0;
	
	$(document).ready(function(){
		$("#videoCheck").click(function(){
			if(this.checked==true){
				$("#file").append("<input type='file' name='file1'>");				
			}else{
				$("#file").empty();								
			}
		});
		$("#surveyEnd").datepicker({
			dateFormat: "yy/mm/dd", //날짜 포맷형식
			showOn:"button",
			buttonText:"달력펼치기",
			changeMonth: true,
			changeYear:true		
		});
		$("#choice1").click(function(){
			choiceType=1;	
			
			var leftBox=document.createElement("div");
			leftBox.setAttribute("id","leftBox");
			leftBox.setAttribute("class","leftBox");
			var rightBox=document.createElement("div");
			rightBox.setAttribute("id","rightBox");
			rightBox.setAttribute("class","rightBox");
			
			var rowBox=document.createElement("div");
			rowBox.setAttribute("id","rowBox");
			rowBox.innerHTML="질문";
			rowBox.appendChild(document.createElement("br"));

			var colBox=document.createElement("div");
			colBox.setAttribute("id","colBox");
			colBox.innerHTML="옵션";
			colBox.appendChild(document.createElement("br"));
			
			$("#mainSurvey1").append(leftBox);
			$("#leftBox").append(rowBox);
			$("#mainSurvey1").append(rightBox);
			$("#rightBox").append(colBox);
			
			$("#submitBtn2").show();
			$("#typeChoice").hide();			
			$("#mainSurvey1").show();
			
			appendBtnBox();
			appendRow();
			appendCol();
		});
		$("#choice2").click(function(){
			choiceType=2;
			$("#submitBtn2").show();
			$("#typeChoice").hide();			
			$("#mainSurvey2").show();
			appendDiv(0);			
		});
		
		function appendBtnBox(){
			var rowPlusBox=$("<div id='rowPlusBox' style='display:none'><input type='button' id='rowPlus' value='질문추가'></div>");
			$("#rowBox").after(rowPlusBox);
			var colPlusBox=$("<div id='colPlusBox' style='display:none'><input type='button' id='colPlus' value='옵션추가'></div>");
			$("#colBox").after(colPlusBox);
			$("#rowPlusBox").css("display","block");
			$("#colPlusBox").css("display","block");
			
			$("#rowPlus").click(function(){
				$("#rowBox").append(document.createElement("br"));
				appendRow();
			});
			$("#colPlus").click(function(){
				$("#colBox").append(document.createElement("br"));
				appendCol();
			});			
		}
			
			
		function appendRow(){			
			var sqTitle=document.createElement("input");
			sqTitle.setAttribute("type","text");
			sqTitle.setAttribute("name","qlist["+(++cloneCnt)+"].sqTitle");
			sqTitle.setAttribute("placeholder","질문내용을 입력하세요");					
			$("#rowBox").append(sqTitle);		
			var sqType=document.createElement("input");
			sqType.setAttribute("type","hidden");
			sqType.setAttribute("name","qlist["+cloneCnt+"].sqType");
			sqType.setAttribute("value","0");					
			$("#rowBox").append(sqType);		
		}
		
		
		function appendCol(){			
			var op=document.createElement("input");
			op.setAttribute("type","text");
			op.setAttribute("name","salist["+(++opNum)+"].alist");
			op.setAttribute("placeholder","옵션을 입력하세요");					
			$("#colBox").append(op);			
		}
		
		
		function appendDiv(n){
			exist++;
			var qBox=document.createElement("div");			
			qBox.setAttribute("id","box"+ (++cloneCnt));
			qBox.setAttribute("name","box"+cloneCnt);		
			
			var sqBox=document.createElement("div");
			sqBox.setAttribute("id","sqBox"+cloneCnt);
			var sqTitle=document.createElement("input");
			sqTitle.setAttribute("type","text");
			sqTitle.setAttribute("name","qlist["+cloneCnt+"].sqTitle");
			sqTitle.setAttribute("placeholder","질문내용을 입력하세요");	
			sqBox.append(sqTitle);
			qBox.append(sqBox);
			
			var delBtn=document.createElement("input");
			delBtn.setAttribute("type","button");
			delBtn.setAttribute("id","delBtn");
			delBtn.setAttribute("onclick","delDiv("+cloneCnt+")");
			delBtn.setAttribute("value","X");
			sqBox.append(delBtn);
			
			var opBox=document.createElement("div");
			opBox.setAttribute("id","opBox"+cloneCnt);
			qBox.append(opBox);		
			
			
			$("#mainSurvey2").append(qBox);				
			
			if(n==0){
				$("#opDiv").css("display","block");
			}else if(n==1){
				checktype1();
			}else if(n==2){
				checktype2();
			}else if(n==3){
				checktype3();
			}else if(n==4){
				checktype4();
			}
			
		}
		

		$("#qPlus1").click(function(){
			if(opNum!=4){
				$("#opPlusBox").show();				
			}
			$("#qPlusBox").css("display","none");
			for(var i=0;i<=cloneCnt;i++){
				var box1=document.getElementById("opBox"+i);
				var box2=document.getElementById("opPlusBox"+i);
				box1.setAttribute("style","display:none");
				box2.setAttribute("style","display:none");
			}
			appendDiv(0);
		});
		$("#qPlus2").click(function(){
			if(opNum!=4){
				$("#opPlusBox").show();				
			}
			$("#qPlusBox").css("display","none");
			for(var i=0;i<=cloneCnt;i++){
				var box1=document.getElementById("opBox"+i);
				var box2=document.getElementById("opPlusBox"+i);
				box1.setAttribute("style","display:none");
				box2.setAttribute("style","display:none");
			}
			appendDiv(opNum);
		});
		/*
		$("#submitBtn").click(function(){
			var choiceBox=document.createElement("input");
			choiceBox.setAttribute("type","hidden");
			choiceBox.setAttribute("name","choiceType");
			choiceBox.setAttribute("value",choiceType);
			$("#things").append(choiceBox);			
			
			var frm=document.frm;
			frm.action="<c:url value='/survey/surveyInsert2'/>";
			frm.submit();			
		});
		*/
		 
	});
	
	
	
	function delDiv(cloneCnt){
		var mainSurvey=document.getElementById("mainSurvey"+choiceType);
		var delBox=document.getElementById("box"+cloneCnt);
		var qBox=document.getElementById("box"+cloneCnt);
		if(exist!=1){
			mainSurvey.removeChild(delBox);
			exist--;			
		}
		
		$("#qPlusBox").show();
		
		
	}
	
	
	function submitOk(n){
		var choiceBox=document.createElement("input");
		choiceBox.setAttribute("type","hidden");
		choiceBox.setAttribute("name","choiceType");
		choiceBox.setAttribute("value",choiceType);
		$("#things").append(choiceBox);	
		
		var stateBox=document.createElement("input");
		stateBox.setAttribute("type","hidden");
		stateBox.setAttribute("name","state");
		if(n==1){
			stateBox.setAttribute("value","저장중");
		}else{
			stateBox.setAttribute("value","등록완료");
		}
		$("#things").append(stateBox);	
		
		var frm=document.frm;
		frm.submit();
		
	}
	
	function mkFunc(){
		var qBox=document.getElementById("box"+cloneCnt);
		var opPlusBox=document.getElementById("opPlusBox"+cloneCnt);
		qBox.removeChild(opPlusBox);
		
		var br=document.createElement("br");
		var option=document.createElement("input");
		option.setAttribute("type","text");
		option.setAttribute("name","salist["+cloneCnt+"].alist");
		option.setAttribute("placeholder","옵션을 입력하세요");
		var box="opBox"+cloneCnt;
		var opBox=document.getElementById(box);
		opBox.appendChild(br);							
		opBox.appendChild(option);
		makeOpBox();
	}
	
	function makeOpBox(){
		var qBox=document.getElementById("box"+cloneCnt);
		var opPlusBox=document.createElement("div");
		opPlusBox.setAttribute("id","opPlusBox"+cloneCnt);
		var opPlus=document.createElement("input");
		opPlus.setAttribute("type","button");
		opPlus.setAttribute("id","opPlus");
		opPlus.setAttribute("value","옵션추가");	
		opPlus.setAttribute("onclick","mkFunc(cloneCnt)")
		opPlusBox.append(opPlus);
		qBox.append(opPlusBox);		
		
	}
	
	function checktype1(){
		opNum=1;
		makeOpBox();
		var br=document.createElement("br");
		var sqType=document.createElement("input");
		sqType.setAttribute("type","hidden");
		sqType.setAttribute("name","qlist["+cloneCnt+"].sqType");
		sqType.setAttribute("value","1");
		$("#things").append(sqType);
		
		var op1=document.createElement("input");
		op1.setAttribute("type","text");
		op1.setAttribute("name","salist["+cloneCnt+"].alist");
		op1.setAttribute("placeholder","옵션을 입력하세요");
		$("#opDiv").css("display","none");
		var box="opBox"+cloneCnt;
		var opBox=document.getElementById(box);
		opBox.append(br);
		opBox.append(op1);	
		$("#qPlusBox").css("display","block");	
		var opPlusBox=document.getElementById("opPlusBox"+cloneCnt);
		opPlusBox.setAttribute("style","display:block");
	}
	
	function checktype2(){
		opNum=2;
		makeOpBox();
		var br=document.createElement("br");
		var sqType=document.createElement("input");
		sqType.setAttribute("type","hidden");
		sqType.setAttribute("name","qlist["+cloneCnt+"].sqType");
		sqType.setAttribute("value","2");
		$("#things").append(sqType);
		
		var op2=document.createElement("input");
		op2.setAttribute("type","text");
		op2.setAttribute("name","salist["+cloneCnt+"].alist");
		op2.setAttribute("placeholder","옵션을 입력하세요");
		$("#opDiv").css("display","none");
		var box="opBox"+cloneCnt;
		var opBox=document.getElementById(box);
		opBox.append(br);
		opBox.append(op2);	
		$("#qPlusBox").css("display","block");	
		var opPlusBox=document.getElementById("opPlusBox"+cloneCnt);
		opPlusBox.setAttribute("style","display:block");
	}
	function checktype3(){
		opNum=3;
		makeOpBox();
		var br=document.createElement("br");
		var sqType=document.createElement("input");
		sqType.setAttribute("type","hidden");
		sqType.setAttribute("name","qlist["+cloneCnt+"].sqType");
		sqType.setAttribute("value","3");
		$("#things").append(sqType);
		
		var op3=document.createElement("input");
		op3.setAttribute("type","text");
		op3.setAttribute("name","salist["+cloneCnt+"].alist");
		op3.setAttribute("placeholder","옵션을 입력하세요");
		$("#opDiv").css("display","none");
		var box="opBox"+cloneCnt;
		var opBox=document.getElementById(box);
		opBox.append(br);
		opBox.append(op3);		
		$("#qPlusBox").css("display","block");	
		var opPlusBox=document.getElementById("opPlusBox"+cloneCnt);
		opPlusBox.setAttribute("style","display:block");
	}
	function checktype4(){
		opNum=4;		
		var br=document.createElement("br");
		var sqType=document.createElement("input");
		sqType.setAttribute("type","hidden");
		sqType.setAttribute("name","qlist["+cloneCnt+"].sqType");
		sqType.setAttribute("value","4");
		$("#things").append(sqType);
		
		var op4=document.createElement("input");
		op4.setAttribute("type","text");
		op4.setAttribute("name","salist["+cloneCnt+"].alist");
		op4.setAttribute("readonly","readonly");
		op4.setAttribute("value","주관식답변입니다.");
		$("#opDiv").css("display","none");
		var box="opBox"+cloneCnt;
		var opBox=document.getElementById(box);
		opBox.append(br);
		opBox.append(op4);					
		
		$("#qPlusBox").css("display","block");
		
		
		
		
	}
	
		
	

</script>
<div id="surveyForm">
	<div class="survey2">
		<form name="frm" action="<c:url value='/survey/surveyInsert2'/>" method="post" enctype="multipart/form-data">
			<div id="surveyOverall">
				<div class="overall">
					<table>
						<tr>
							<th><label for="surveyName">설문제목</label></th>
							<td><input type="text" id="surveyName" name="surveyName" placeholder="설문제목을 입력하세요"></td>
						</tr>
						<tr>
							<th><label for="surveyDescription">설문내용</label></th>
							<td><textarea rows="5" cols="cols" id="surveyDescription" name="surveyDescription" placeholder="설문내용을 입력하세요"></textarea></td>
						</tr>
						<tr>
							<th><label for="videoCheck"><input type="checkbox" id="videoCheck">영상첨부</label></th>
							<td><span id="file"></span></td>
						</tr>
						<tr>
							<th>설문종료일</th>
							<td><input type="text" id="surveyEnd" name="surveyEnd" readonly="readonly"></td>
						</tr>
					</table>
				</div>	
			</div>
			<div id="typeChoice" class="typeChoice">
				<input type="button" id="choice1" value="객관식그리드">
				<input type="button" id="choice2" value="복합질문타입">
			</div>
			<div id="mainSurvey1" class="mainSurvey1" style="display: none">			
				
			</div>
			<div id="mainSurvey2" class="mainSurvey2" style="display: none">
							
			</div>	
			<div id="opDiv" class="opDiv" style="display: none">
				<input type="button" id="type1" onclick="checktype1()" value="객관식질문">
				<input type="button" id="type2" onclick="checktype2()" value="중복체크">
				<input type="button" id="type3" onclick="checktype3()" value="직선단계">
				<input type="button" id="type4" onclick="checktype4()" value="주관식질문">
			</div>
			
			<div id="qPlusBox" class="qPlusBox" style="display: none">				
				<input type="button" id="qPlus1" value="질문추가">
				<input type="button" id="qPlus2" value="같은질문추가">
			</div>
			<div id="things" class="things">
				<input type="button" id="submitBtn1" onclick="submitOk(1)" value="저장하기">
				<input type="button" id="submitBtn2" onclick="submitOk(2)" value="등록하기" style="display: none">
			</div>
		</form>
	</div>
</div>