<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript">
	
	var cloneCnt=${fn:length(sqVoList)-1};//그냥 질문 구분하려는 용도
	var choiceType=${choiceType};//객관식그리드인지 복합질문형인지 구분하려는 용도
	var opNum=-1;//객관식그리드의 경우엔 옵션갯수세는용도,복합질문형의 경우엔 옵션타입구분하는용도
	var opCnt=${fn:length(salist[0]) };//객관식그리드 옵션갯수세기....?
	var exist=${fn:length(sqVoList)};//질문몇개인가 세려는 용도
	
	$(document).ready(function(){
		if(choiceType==1||choiceType=='1'){
			opNum=${fn:length(salist[0])-1};
			$("#mainSurvey1").show();
		}else{
			$("#mainSurvey2").show();
		}
		$("#videoCheck").click(function(){//영상
			if(this.checked==true){
				$("#file").append("<input type='file' name='file1'>");				
			}else{
				$("#file").empty();								
			}
		});
		$("#surveyEnd").datepicker({
			dateFormat: "yy-mm-dd", //날짜 포맷형식
			showOn:"button",
			showMonthAfterYear:true,
			buttonText:"달력펼치기",
			changeMonth: true,
			changeYear:true,
			yearSuffix:"년",
			monthNamesShort:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			nextText:"다음 달",
			prevText:"이전 달",
			minDate:"0",
			maxDate:"1y"
		});		
		
		
		
		$("#rowBox").sortable({
			axis: "y",
			containment: "parent",
			update: function (event, ui) {
				var order = $(this).sortable('toArray', {
					attribute: 'data-order'
				});
			}
		});
		$("#mainSurvey2").sortable({//div순서바꾸기
			axis: "y",
			containment: "parent",
			update: function (event, ui) {
				var order = $(this).sortable('toArray', {
					attribute: 'data-order'
				});
			}
		});
		$("#hideBtn").click(function(){
			if($(".tablehide").css("display")=="none"){
				$(".tablehide").show();
			}else{
				$(".tablehide").hide();
			}
		});
		$("#qPlus1").click(function(){//질문추가버튼누르면!
			if(opNum!=3 && opNum!=4){
				$("#opPlusBox").show();				
			}
			$("#qPlusBox").css("display","none");
			$("#surveyForm").find(".opBox").hide();		
			$("#surveyForm").find(".opPlusBox").hide();		
			appendDiv(0);
			
		});
		$("#qPlus2").click(function(){//같은질문추가버튼누르면!
			if(opNum!=3 && opNum!=4){
				$("#opPlusBox").show();				
			}
			$("#qPlusBox").css("display","none");
			$("#surveyForm").find(".opBox").hide();		
			$("#surveyForm").find(".opPlusBox").hide();		
			appendDiv(opNum);
			
		});	
		$(".opDelBtn").click(function(e){
			alert("opDelBtn");
			opDel(e);
		});
	});
	
	
	
	function checktype1(){//객관식답안선택시
		opNum=1;
		var existOpNum=1;
		makeOpBox(1,cloneCnt);
		var br=document.createElement("br");
		var sqType=document.createElement("input");
		sqType.setAttribute("type","hidden");
		sqType.setAttribute("name","sqlist["+cloneCnt+"].sqType");
		sqType.setAttribute("class","org");
		sqType.setAttribute("value","1");
		$("#things").append(sqType);
		
		var op1=document.createElement("input");
		op1.setAttribute("type","text");
		op1.setAttribute("name","ssalist["+cloneCnt+"].alist");
		op1.setAttribute("placeholder","옵션을 입력하세요");
		$("#opDiv").css("display","none");		
		var opDelBtn=document.createElement("input");
		opDelBtn.setAttribute("type","button");
		opDelBtn.setAttribute("style","position:absolute;left:90%;")
		opDelBtn.setAttribute("value","x");
		opDelBtn.onclick=opDel;
		
		var existOp=document.getElementById("existOp"+cloneCnt);
		existOp.setAttribute("value",existOpNum);
		
		var box="opBox"+cloneCnt;
		var opBox=document.getElementById(box);
		opBox.setAttribute("class","opBox");
		opBox.append(br);
		opBox.append(op1);
		opBox.append(opDelBtn);
		$("#qPlusBox").css("display","block");	
		var opPlusBox=document.getElementById("opPlusBox"+cloneCnt);
		opPlusBox.setAttribute("style","display:block");
		//$('.surveyList').scrollTop($('.surveyList')[0].scrollHeight);
		
	}
	
	function checktype2(){//중복선택시
		opNum=2;
		var existOpNum=1;
		makeOpBox(2,cloneCnt);
		var br=document.createElement("br");
		var sqType=document.createElement("input");
		sqType.setAttribute("type","hidden");
		sqType.setAttribute("name","sqlist["+cloneCnt+"].sqType");
		sqType.setAttribute("class","org");
		sqType.setAttribute("value","2");
		$("#things").append(sqType);
		
		var op2=document.createElement("input");
		op2.setAttribute("type","text");
		op2.setAttribute("name","ssalist["+cloneCnt+"].alist");
		op2.setAttribute("placeholder","옵션을 입력하세요");
		$("#opDiv").css("display","none");
		var opDelBtn=document.createElement("input");
		opDelBtn.setAttribute("type","button");
		opDelBtn.setAttribute("style","position:absolute;left:90%;")
		opDelBtn.setAttribute("value","x");
		opDelBtn.onclick=opDel;
		
		var existOp=document.getElementById("existOp"+cloneCnt);
		existOp.setAttribute("value",existOpNum);
		
		var box="opBox"+cloneCnt;
		var opBox=document.getElementById(box);
		opBox.setAttribute("class","opBox");
		opBox.append(br);
		opBox.append(op2);	
		opBox.append(opDelBtn);
		$("#qPlusBox").css("display","block");	
		var opPlusBox=document.getElementById("opPlusBox"+cloneCnt);
		opPlusBox.setAttribute("style","display:block");
		//$('.surveyList').scrollTop($('.surveyList')[0].scrollHeight);
		
	}
	
	function checktype3(){//직선단계선택시
		opNum=3;
		makeOpBox(3,cloneCnt);
		
		var br=document.createElement("br");
		var sqType=document.createElement("input");
		sqType.setAttribute("type","hidden");
		sqType.setAttribute("name","sqlist["+cloneCnt+"].sqType");
		sqType.setAttribute("class","org");
		sqType.setAttribute("value","3");
		$("#things").append(sqType);		
		
		var selDiv=document.createElement("div");
		selDiv.setAttribute("id","selDiv");
		var sel1box=document.createElement("select");
		sel1box.setAttribute("id","sel1box"+cloneCnt);
		sel1box.setAttribute("n",1);
		sel1box.setAttribute("cnt",cloneCnt);
		sel1box.onchange=putInf;
		var sel2box=document.createElement("select");
		sel2box.setAttribute("id","sel2box"+cloneCnt);
		sel2box.setAttribute("n",2);
		sel2box.setAttribute("cnt",cloneCnt);
		sel2box.onchange=putInf;
		
		selOpArray1=["0","1"];
		selOpArray2=["2","3","4","5","6","7","8","9","10"]; 
		for(var i=0;i<selOpArray1.length;i++){
			var option=document.createElement("option");
			option.text=selOpArray1[i];
			option.setAttribute("value",selOpArray1[i]);
			sel1box.add(option);
		}
		for(var i=0;i<selOpArray2.length;i++){
			var option=document.createElement("option");
			option.text=selOpArray2[i];
			option.setAttribute("value",selOpArray2[i]);
			sel2box.add(option);
		}
		var strSpan=document.createElement("span");
		strSpan.innerHTML=" ~ ";
		selDiv.appendChild(sel1box);
		selDiv.appendChild(strSpan);
		selDiv.appendChild(sel2box);
		$("#opDiv").css("display","none");
		
		var op3=document.createElement("div");
		var span1op=document.createElement("span");
		span1op.innerHTML=0;
		span1op.setAttribute("id","span1op"+cloneCnt);
		var input1op=document.createElement("input");
		input1op.setAttribute("type","text");
		input1op.setAttribute("style","margin-left:5px;");
		input1op.setAttribute("placeholder","옵션을 입력하세요");
		input1op.setAttribute("id","input1op"+cloneCnt);
		var hidden1Input=document.createElement("input");
		hidden1Input.setAttribute("id","hidden1Input"+cloneCnt);
		hidden1Input.setAttribute("type","hidden");
		hidden1Input.setAttribute("name","ssalist["+cloneCnt+"].alist");
		op3.appendChild(hidden1Input);
		
		var span2op=document.createElement("span");
		span2op.innerHTML=2;
		span2op.setAttribute("id","span2op"+cloneCnt);
		var input2op=document.createElement("input");
		input2op.setAttribute("type","text");
		input2op.setAttribute("placeholder","옵션을 입력하세요");
		input2op.setAttribute("style","margin-left:5px;");
		input2op.setAttribute("id","input2op"+cloneCnt);
		var hidden2Input=document.createElement("input");
		hidden2Input.setAttribute("id","hidden2Input"+cloneCnt);
		hidden2Input.setAttribute("type","hidden");
		hidden2Input.setAttribute("name","ssalist["+cloneCnt+"].alist");
		op3.appendChild(hidden2Input);
		
		op3.appendChild(span1op);
		op3.appendChild(input1op);
		op3.appendChild(document.createElement("br"));
		op3.appendChild(span2op);
		op3.appendChild(input2op);
		
		var box="opBox"+cloneCnt;
		var opBox=document.getElementById(box);
		opBox.setAttribute("class","opBox");
		opBox.append(br);
		opBox.append(selDiv);					
		opBox.append(op3);
		$("#qPlusBox").css("display","block");	
		
		//hidden1Input.setAttribute("value",document.getElementById("sel1box0").value);
		//hidden2Input.setAttribute("value", document.getElementById("sel2box0").value);
		//$('.surveyList').scrollTop($('.surveyList')[0].scrollHeight);
		
	}
	
	function putInf(){
		var n=$(this).attr("n");
		var cnt=$(this).attr("cnt");
		var span=document.getElementById("span"+n+"op"+cnt);
		span.textContent=$(this).val();	
		
		
	}
	
	function checktype4(){//주관식답안선택시
		opNum=4;
		makeOpBox(4,cloneCnt);
		var br=document.createElement("br");
		var sqType=document.createElement("input");
		sqType.setAttribute("type","hidden");
		sqType.setAttribute("name","sqlist["+cloneCnt+"].sqType");
		sqType.setAttribute("class","org");
		sqType.setAttribute("value","4");
		$("#things").append(sqType);
		
		var op4=document.createElement("input");
		op4.setAttribute("type","text");
		op4.setAttribute("name","ssalist["+cloneCnt+"].alist");
		op4.setAttribute("readonly","readonly");
		op4.setAttribute("value","주관식답변입니다.");
		$("#opDiv").css("display","none");
		var box="opBox"+cloneCnt;
		var opBox=document.getElementById(box);
		opBox.setAttribute("class","opBox");
		opBox.append(br);
		opBox.append(op4);					
		
		$("#qPlusBox").css("display","block");
		//$('.surveyList').scrollTop($('.surveyList')[0].scrollHeight);
		
	}
	
	
	function delDiv(n){//질문박스지우기	
		var delBox=document.getElementById("box"+n);
		if(exist!=1){
			if(choiceType==1){//객관식그리드에서
				var rowBox=document.getElementById("rowBox");
				rowBox.removeChild(delBox);
				exist--;
			}else{//복합질문형에서
				var mainSurvey=document.getElementById("mainSurvey"+choiceType);
				mainSurvey.removeChild(delBox);
				exist--;
				$("#opDiv").hide();
				$("#qPlusBox").show();	
			}	
		}			
	}
	
	function makeOpBox(n,cnt){
		var qBox=document.getElementById("box"+cnt);
		var opPlusBox=document.createElement("div");
		opPlusBox.setAttribute("id","opPlusBox"+cnt);
		opPlusBox.setAttribute("class","opPlusBox");
		if(n!=3 && n!=4){
			var opPlus=document.createElement("input");
			opPlus.setAttribute("type","button");
			opPlus.setAttribute("id","opPlus"+cnt);
			opPlus.setAttribute("value","옵션추가");	
			opPlus.setAttribute("onclick","mkFunc("+cnt+")");			
			opPlusBox.append(opPlus);
			
		}
		qBox.append(opPlusBox);		
		
	}
	
	function mkFunc(cnt){
		var qBox=document.getElementById("box"+cnt);
		var opPlusBox=document.getElementById("opPlusBox"+cnt);
		qBox.removeChild(opPlusBox);
		
		var existOp=document.getElementById("existOp"+cnt);
		var existOpNum=existOp.getAttribute("value");
		existOp.value=++existOpNum;
		existOp.setAttribute("value",existOpNum++);
		
		var br=document.createElement("br");
		var option=document.createElement("input");
		option.setAttribute("type","text");
		option.setAttribute("name","ssalist["+cnt+"].alist");
		option.setAttribute("placeholder","옵션을 입력하세요");
		var opDelBtn=document.createElement("input");
		opDelBtn.setAttribute("type","button");
		opDelBtn.setAttribute("style","position:absolute;left:90%;")
		opDelBtn.setAttribute("value","x");
		opDelBtn.onclick=opDel;
		var box="opBox"+cnt;
		var opBox=document.getElementById(box);
		opBox.appendChild(br);							
		opBox.appendChild(option);
		opBox.appendChild(opDelBtn);
		
		var chNum=$("#surveyForm").find('.sqType'+cnt).val();
		makeOpBox(chNum,cnt);
		
	}	
	
	function opDel(e){//옵션지우기(br지우고 옵션지우고 버튼지우기)//애초부터받아온애들
		if(choiceType==1 || choiceType=='1'){
			var existOp=document.getElementById('existOp');
			var existOpNum=existOp.getAttribute('value');
			if(existOpNum!=1 || existOpNum!='1'){
				$(e.target).parent().remove();
				existOp.value=--existOpNum;
				opCnt--;
			}
		}else{
			var parentId=this.parentNode.getAttribute("id");
			var cnt=parentId.split('opBox')[1];
			var existOp=document.getElementById("existOp"+cnt);
			existOpNum=existOp.getAttribute("value");
			if(existOpNum!=1 || existOpNum!='1'){
				$(this).prev().remove();
				$(this).remove();	
				existOp.value=--existOpNum;
			}
		}
	}
	function opDel1(){//옵션지우기(br지우고 옵션지우고 버튼지우기)//새로만든애들
		if(choiceType==1 || choiceType=='1'){
			var existOp=document.getElementById('existOp');
			var existOpNum=existOp.getAttribute('value');
			if(existOpNum!=1 || existOpNum!='1'){
				$(this).parent().remove();
				existOp.value=--existOpNum;
				opCnt--;
			}
		}else{
			var parentId=this.parentNode.getAttribute("id");
			var cnt=parentId.split('opBox')[1];
			var existOp=document.getElementById("existOp"+cnt);
			existOpNum=existOp.getAttribute("value");
			if(existOpNum!=1 || existOpNum!='1'){
				$(this).prev().remove();
				$(this).remove();	
				existOp.value=--existOpNum;
			}
		}
	}
		
	function submitOk(n){
		var choiceBox=document.createElement("input");
		choiceBox.setAttribute("type","hidden");
		choiceBox.setAttribute("name","choiceType");
		choiceBox.setAttribute("value",choiceType);
		$("#things").append(choiceBox);	
		
		//type3인 경우(직선단계) value값 정리하기
		for(var i=1;i<=2;i++){
			for(var j=0;j<=cloneCnt;j++){
				var st="box"+j;
				if(document.getElementById(st)!=null){
					if($("input[name='sqlist["+j+"].sqType']").val()=="3" || $("input[name='sqlist["+j+"].sqType']").val()==3){
						var selbox=document.getElementById("sel"+i+"box"+j);
						var inputop=document.getElementById("input"+i+"op"+j);
						var hiddenInput=document.getElementById("hidden"+i+"Input"+j);
						console.log(selbox.value);
						console.log(inputop.value);						
						hiddenInput.value=selbox.value+"!@#$"+inputop.value;
					}					
				}
			}
		}
		//일단 복합질문형은 인서트 완전잘되고 객관식그리드도 인서트 잘됨.
		var appendingBoxArr='';
		if(choiceType=="2"|| choiceType==2){
			appendingBoxArr=$("#mainSurvey2").find(".appendingBox");
		}else if(choiceType="1"||choiceType==1){
			appendingBoxArr=$("#mainSurvey1").find(".appendingBox");
		}
		for(var i=0;i<appendingBoxArr.length;i++){
			var appendingBox=appendingBoxArr.get(i);
			var qbox=appendingBox.getAttribute("id");
			var cnt=qbox.split("box")[1];
			$("input[name='sqlist["+cnt+"].sqType']").attr("class","save");
			$("input[name='sqlist["+cnt+"].sqType']").attr("name","qlist["+i+"].sqType");
			$("input[name='sqlist["+cnt+"].sqTitle']").attr("name","qlist["+i+"].sqTitle");
			if(choiceType==2){
				$("input[name='ssalist["+cnt+"].alist']").attr("name","salist["+i+"].alist");						
			}			
		}
		if(choiceType==1){
			var signNum=0;
			for(i=0;i<=opNum;i++){
				var st="opBox"+i;
				if(document.getElementById(st)!=null){
					$("input[name='ssalist["+i+"].alist']").attr("name","salist["+signNum+"].alist");
					signNum++;
				}
			}
		}
		
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
	
	function choice1Click(){		
		/*$("#choice1").click(function(){//객관식그리드 선택*/
		choiceType=1;	
		
		var leftBoxDiv=document.createElement("div");
		leftBoxDiv.setAttribute("id","leftBoxDiv");
		leftBoxDiv.setAttribute("style","margin-right:30px;")
		leftBoxDiv.setAttribute("class","boxStyle");
		var rightBoxDiv=document.createElement("div");
		rightBoxDiv.setAttribute("id","rightBoxDiv");
		rightBoxDiv.setAttribute("class","boxStyle");
		
		var rowBox=document.createElement("div");
		rowBox.setAttribute("id","rowBox");
		rowBox.innerHTML="질문";
		rowBox.appendChild(document.createElement("br"));

		var colBox=document.createElement("div");
		colBox.setAttribute("id","colBox");
		colBox.innerHTML="옵션";
		colBox.appendChild(document.createElement("br"));
	
		$("#mainSurvey1").append(leftBoxDiv);
		$("#leftBoxDiv").append(rowBox);
		$("#mainSurvey1").append(rightBoxDiv);
		$("#rightBoxDiv").append(colBox);
		
		$("#grid1").show();
		$("#grid2").show();
		$("#submitBtn2").show();
		$("#typeChoice").hide();			
		$("#mainSurvey1").show();
		
		appendBtnBox();
		appendRow();
		appendCol(0);
		
	}
	function choice2Click(){
		/*$("#choice2").click(function(){//복합질문형선택/*/
			choiceType=2;
			$("#grid1").show();
			$("#grid2").show();
			$("#submitBtn2").show();
			$("#typeChoice").hide();			
			$("#mainSurvey2").show();
			
			appendDiv(0);	
			
		}
		
	function appendBtnBox(){//객관식그리드의 추가버튼박스...?
		var rowPlusBox=$("<div id='rowPlusBox' style='display:none'><input type='button' id='rowPlus' value='질문추가'></div>");
		$("#rowBox").after(rowPlusBox);
		var colPlusBox=$("<div id='colPlusBox' style='display:none'><input type='button' id='colPlus' value='옵션추가'></div>");
		$("#colBox").after(colPlusBox);
		$("#rowPlusBox").css("display","block");
		$("#colPlusBox").css("display","block");
		
		$("#rowPlus").click(function(){
			appendRow();
		});
		$("#colPlus").click(function(){
			appendCol(1);
		});		
		
	}			
			
	function appendRow(){//객관식그리드의 질문추가	
		exist++;
		var box=document.createElement("div");
		box.setAttribute("id","box"+(++cloneCnt));
		box.setAttribute("name","box"+cloneCnt);
		box.setAttribute("class","appendingBox");
		box.setAttribute("data-order",cloneCnt);
		
		var sqTitle=document.createElement("input");
		sqTitle.setAttribute("type","text");
		sqTitle.setAttribute("name","sqlist["+cloneCnt+"].sqTitle");
		sqTitle.setAttribute("placeholder","질문내용을 입력하세요");
		box.appendChild(sqTitle);
		var delBtn=document.createElement("input");
		delBtn.setAttribute("type","button");
		delBtn.setAttribute("value","x");
		delBtn.setAttribute("onclick","delDiv("+cloneCnt+")");			
		box.appendChild(delBtn);
		$("#rowBox").append(box);
		
		var sqType=document.createElement("input");
		sqType.setAttribute("type","hidden");
		sqType.setAttribute("name","sqlist["+cloneCnt+"].sqType");
		sqType.setAttribute("class","org");
		sqType.setAttribute("value","0");					
		$("#things").append(sqType);
		//$('.surveyList').scrollTop($('.surveyList')[0].scrollHeight);
	}		
		
	function appendCol(n){//객관식그리드의 옵션추가	
		var opBox=document.createElement("div");
		opBox.setAttribute("id","opBox"+(++opNum));
		
		var op=document.createElement("input");
		op.setAttribute("type","text");
		op.setAttribute("name","ssalist["+opNum+"].alist");
		op.setAttribute("placeholder","옵션을 입력하세요");
		opBox.appendChild(op);
		
		if(n==0 || n=='0'){
			var existOpBox=document.createElement('input');
			existOpBox.setAttribute('type','hidden');
			existOpBox.setAttribute('id','existOp');
			existOpBox.setAttribute('value',opCnt);
			$("#colBox").append(existOpBox);
		}else{
			var existOpBox=document.getElementById('existOp');
			existOpBox.setAttribute('value',++opCnt);
		}
		
		var delBtn=document.createElement("input");
		delBtn.setAttribute("type","button");
		delBtn.onclick=opDel1;
		delBtn.setAttribute("value","x");
		opBox.appendChild(delBtn);
		$("#colBox").append(opBox);
		//$('.surveyList').scrollTop($('.surveyList')[0].scrollHeight);
		
	}
	

	function appendDiv(n){//복합질문형 감싸는 Div
		exist++;		
		
		var qBox=document.createElement("div");			
		qBox.setAttribute("id","box"+ (++cloneCnt));
		qBox.setAttribute("name","box"+cloneCnt);	
		qBox.setAttribute("class","appendingBox");	
		qBox.setAttribute("data-order",cloneCnt);
		qBox.onclick=showOption;
		qBox.style='margin-top:10px;position:relative;';			
		
		//옵션갯수세려는 용도
		var existOp=document.createElement("input");
		existOp.setAttribute("type","hidden");
		existOp.setAttribute("id","existOp"+cloneCnt);
		qBox.append(existOp);
		
		var sqBox=document.createElement("div");
		sqBox.setAttribute("id","sqBox"+cloneCnt);
		var sqTitle=document.createElement("input");
		sqTitle.setAttribute("type","text");
		sqTitle.setAttribute("class","sqType"+cloneCnt);
		sqTitle.setAttribute("name","sqlist["+cloneCnt+"].sqTitle");
		sqTitle.setAttribute("placeholder","질문내용을 입력하세요");	
		sqBox.append(sqTitle);
		qBox.append(sqBox);
		
		var delBtn=document.createElement("input");
		delBtn.setAttribute("type","button");
		delBtn.setAttribute("id","delBtn");
		delBtn.setAttribute("style","position:absolute;left:90%;")
		delBtn.setAttribute("onclick","delDiv("+cloneCnt+")");
		delBtn.setAttribute("value","x");
		sqBox.append(delBtn);
		
		var opBox=document.createElement("div");
		opBox.setAttribute("id","opBox"+cloneCnt);
		opBox.setAttribute("style","position:relative;");
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
	function showOption(){//질문Div눌렀을때 해당 질문의 입력했던 옵션들과 옵션추가버튼보이게!다른Div는 숨겨지고!
		$("#surveyForm").find(".opBox").hide();		
		$("#surveyForm").find(".opPlusBox").hide();		
		$(this).find('div').css("display","block");
		
	}
		
	function grid(n){
		if(n==1 || n=='1'){
			if(choiceType==1 || choiceType=='1'){
				alert('객관식 그리드 질문 형태로 이미 진행하고 있습니다.');
			}else{
				cloneCnt=-1;
				opNum=-1;
				opCnt=1;
				exist=0;
				$("#mainSurvey2").empty();
				choice1Click();
				$('.qPlusBox').hide();
			}
		}else if(n==2 || n=='2'){
			if(choiceType==2 || choiceType=='2'){
				alert('복합 질문 형태로 이미 진행하고 있습니다.');
			}else{
				cloneCnt=-1;
				opNum=-1;
				opCnt=1;
				exist=0;
				$("#mainSurvey1").empty();		
				choice2Click();
			}
		}
	}
	

</script>
<style type="text/css">
	#hideBtn{position:absolute;left:75%;}
	
	#mainSurvey1 input[type=text]{
		background-color: #2E2E2E;
	    color: #fff;
	    padding: 8px;
	    border: 1px solid #ccc;
	    border-radius: 4px;
	    width:300px;
	    margin-top:10px;
	}
	.mainSurvey1{width:80%;margin-top:30px ;float: none;display: inline-block;}
	.mainSurvey1 .boxStyle{float:left;}
	.mainSurvey2{width:80%;margin-top:30px ;float: none;}
	.mainSurvey2 input[type=text]{width:400px;}
	#things #grid1{position:fixed;left:80%;top:20%;}
	#things #grid2{position:fixed;left:80%;top:26%;}
	#things #submitBtn1{position: fixed;left:80%;top:32%; }
	#things #submitBtn2{position:fixed;left:80%;top:38%;}
	#typeChoice{width:80%;margin-top:10px;}
	#rowPlus{margin-top:10px;}
	#colPlus{margin-top:10px;}
	
	.surveyList{padding-left: 80px;padding-top: 100px;height:auto;overflow: hidden;}
	.surveyList .leftBox{width:14%;float: left;} 
	.surveyList .rightBox{width:80%;float: left;text-align: center;} 
	.overall{position:relative;}
	.overall input[type=text], textarea, input[type=date]{
	    background-color: #2E2E2E;
	    color: #fff;
	    padding: 8px;
	    border: 1px solid #ccc;
	    border-radius: 4px;
	    width:500px;
	}
	
</style>
<div id="surveyForm">
	<div class="surveyList">
		<div id="tab" class="leftBox">
			<div class="leftDivBox">
				<a href="<c:url value='/survey/list?code=1'/>">현재진행중인설문</a>
			</div>
			<div class="leftDivBox">
				<a href="<c:url value='/survey/list?code=2'/>">완료된 설문</a>
			</div>
			<div class="leftDivBox">
				<a href="<c:url value='/survey/mySurvey'/>">나의 설문지</a>
			</div>
		</div>
		<div id="box" class="rightBox">	
			<form name="frm" action="<c:url value='/survey/surveyInsert2'/>" method="post" enctype="multipart/form-data">
				<div id="surveyOverall">
					<div class="overall">
						<table style="width:80%">
							<tr class="tableshow">
								<th><label for="surveyName">설문제목</label></th>
								<td>
									<input type="text" id="surveyName" name="surveyName" value="${surveyVo.surveyName }" placeholder="설문제목을 입력하세요">
									<input type="button" id="hideBtn" value=" . . . ">
								</td>
							</tr>
							<tr class="tableshow">
								<th><label for="surveyDescription">설문내용</label></th>
								<td><textarea rows="5" cols="cols" id="surveyDescription" name="surveyDescription" placeholder="설문내용을 입력하세요">${surveyVo.surveyDescription }</textarea></td>
							</tr>
							<tr class="tablehide">
								<th><label for="videoCheck"><input type="checkbox" id="videoCheck">영상첨부</label></th>
								<td><span id="file"></span></td>
							</tr>
							<tr class="tablehide">
								<th>설문종료일</th>
								<td><input type="text" id="surveyEnd" name="surveyEnd" value="${surveyVo.surveyEnd }" readonly="readonly"></td>
							</tr>
						</table>
					</div>	
				</div>
				<div id="mainSurvey1" class="mainSurvey1" style="display: none">			
					<c:if test="${choiceType==1||choiceType=='1' }">
						<div id="leftBoxDiv" style="margin-right:30px;" class="boxStyle">
							<div id="rowBox">
								질문
								<br>
								<c:forEach var="i" begin="0" end="${fn:length(sqVoList)-1 }">
									<div id="box${i }" name="box${i }" class="appendingBox" data-order="${i }">
										<input type="text" name="sqlist[${i }].sqTitle" value="${sqVoList[i].sqTitle }" placeholder="질문내용을 입력하세요">
										<input type="button" value="x" onclick="delDiv(${i })">
									</div>
								</c:forEach>
							</div>	
							<div id="rowPlusBox" style="display:block;">
								<input type="button" id="rowPlus" onclick="appendRow()" value="질문추가">
							</div>					
						</div>
						<div id="rightBoxDiv" class="boxStyle">
							<div id="colBox">							
								옵션
								<br>
								<input type="hidden" id="existOp" value="${fn:length(salist[0]) }">
								<c:forEach var="i" begin="0" end="${fn:length(salist[0])-1 }">
									<div id="opBox${i }">
										<input type="text" name="ssalist[${i }].alist" value="${salist[0][i].saAnswer }" placeholder="옵션을 입력하세요">
										<input type="button" class="opDelBtn" value="x">
									</div>
								</c:forEach>								
							</div>		
							<div id="colPlusBox" style="display:block;">
								<input type="button" id="colPlus" onclick="appendCol(1)" value="옵션추가">
							</div>				
						</div>						
						
					</c:if>
				</div>
				<div id="mainSurvey2" class="mainSurvey2" style="display: none">
					<c:if test="${choiceType==2||choiceType=='2' }">
						<c:forEach var="i" begin="0" end="${fn:length(sqVoList)-1 }">
						
						
						</c:forEach>
					</c:if>
				</div>	
				<div id="opDiv" class="opDiv" style="display: none;margin-top: 10px;width:80%;">
					<input type="button" id="type1" onclick="checktype1()" value="객관식질문">
					<input type="button" id="type2" onclick="checktype2()" value="중복체크">
					<input type="button" id="type3" onclick="checktype3()" value="직선단계">
					<input type="button" id="type4" onclick="checktype4()" value="주관식질문">
				</div>
				
				<div id="qPlusBox" class="qPlusBox" style="display: none;margin-top:10px;width:80%;">				
					<input type="button" id="qPlus1" value="질문추가" >
					<input type="button" id="qPlus2" value="같은질문추가" >
				</div>
				<div id="things" class="things">
					<input type="hidden" name="surveyNum" value="${surveyNum }">
					<input type="button" id="grid1" onclick="grid(1)" value="객관식그리드로 만들기">
					<input type="button" id="grid2" onclick="grid(2)"	 value="복합질문형으로 만들기">
					<input type="button" id="submitBtn1" onclick="submitOk(1)" value="저장하기">
					<input type="button" id="submitBtn2" onclick="submitOk(2)" value="등록하기">
				</div>
			</form>
		</div>
	</div>
</div>