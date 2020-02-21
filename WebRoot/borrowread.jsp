<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
    <head>
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <style>
		#main{
		width:100%;
		background: #444;
		height:400px;
		margin:10px auto;
		background-size:100% 100%;
		border:1px solid #fff;
		border-radius:10px;
		}
				form{
			font-family:"楷体";
			text-align:center;
			margin-top:20px;
			margin-left:100px;
			border-style:none none;
		}
		form th,form td{border-style:none none;}
		input{
		width:150px;
		height:20px;
		margin-left:20px;
		border:1px solid #fff;
		border-radius:10px;
		}
		#table1{
			width:60%;
			margin-top:20px;
			margin-left:100px;
			color:#fff;
			border-radius:10px;
			border-style:solid;
			font-family:"楷体";
			font-size:14px;
			text-align:center;
			position:absolute;
	}
	td,th{
		
		color:#fff;
		border:1px solid #fff;
		border-style:solid none;
	}
	th{
		font-family:bold;
	}
	#wenjian{
		margin-top:100;
		margin-left:100px;
	}
	a{
		color:#fff;
		text-decoration:none;
	}
	#but{
		width:500px;
		height:30px;
		position:relative;
		top:270px;
		left:140px;
		color:#fff;
	}
        </style>
        <script src="jquery-1.11.3.min.js"></script>
		<script type="text/javascript">
		$(function(){
		   $("#msgSearchBtn").bind("click",function(){  
		   $.ajax({
				 type: 'post',
				 url: 'myreceivemsgServlet' ,
				 data: $('#msg').serialize(),
				 success: function(data) {
					  //将“添加新闻”页面的内容插入到页面的“主区域”
					  $("#buttom").html(data);
				 }
				});
			});
		});
			function toPage2(page,url){
			$.ajax({
					 type: 'POST',
					 url: url+"?curpage="+page ,
					 data: $('#wenjian').serialize(),
					 success: function(data) {
						  $("#buttom").html(data);
					 }
			});
		
		}
	function guihuan(url,bookid,statusid,method){	
	if(confirm('你确认要归还吗？')){
		$.ajax({
			 type: method,
			 url: url+"?bookid="+bookid+"&statusid="+statusid ,
			 success: function(data) {
				  var msg="归还失败";
				  //data代表服务端返回的数据
				  if($.trim(data)=="1"){//删除成功
					 msg='归还成功';
				  }
				  alert(msg);
				  success();
				  
			 }
	    });
	}
}
function success(){
	$.ajax({
			 type: 'post',
			 url: 'borrowreadServlet' ,
			 data:{
			 	readerid:$("#readerid").val(),
			 },
			 success: function(data) {
				  $("#buttom").html(data);
			 }
		 });	
}
        function fanhui(url,method){
		$.ajax({
					 type: method,
					 url: url ,
					 success: function(data) {
						  $("#buttom").html(data);
					 }
			});
		}
		 function fanhui(url,method){
		$.ajax({
					 type: method,
					 url: url ,
					 success: function(data) {
						  $("#buttom").html(data);
					 }
			});
		}
		</script>	
    </head>
    <body>
	   <div id="main">
	   <div id="duzhe" style="color:#fff;font-family:'楷体';margin-left:30px;margin-top:20px">读者：${record.readername}</div>
	   <form  id="msg" method="post" action="">
	   <table border="0" cellpadding="0"  cellspacing="0">	
           <tr>
			 <td>书名</td>
			 <td width="150" height="30">
			 	<input type="text" name="bookname" id="bookname" value="${bookname}"></td> 
			 <td width="100" height="30"> 
			 <td>编号</td>
			 <td width="150" height="30">
			 	<input type="text" name="booknumber" id="booknumber" value="${booknumber}"></td> 
			 <td width="100" height="30">   
			  	<input type="hidden" name="curpage" value="" />
			   	<a href="javascript:void(0);" id="msgSearchBtn">搜&nbsp;索</a>&nbsp;&nbsp;
			   	<a style="background:#fff;color:#444;text-align:center" href="javascript:fanhui('lookreaderServlet?readerid','post')">返回</a>
			 </td>                   
           </tr>                  
	   </table>
	   </form>
       <table   id="table1" border="0.5" cellpadding="0" cellspacing="0">	
	              <tr>
	              	<th width="100" height="40">书名</th>
					<th width="150" height="30">编号</th>
					 <th width="100" height="30">类别</th>
					<th width="100" height="30">作者</th>
	                <th width="150" height="30">状态</th>
	                 <th width="100" height="30">出版社</th>
	                 <th width="100" height="30">价格</th>
	                <th width="100" height="30">操作</th>
	              </tr>
	              <c:forEach var="r" items= "${records}">
				  <tr>
					<td width="100" height="30">${r.bookname}</td>
					<td width="150" height="30">${r.booknumber}</td>
					<td width="100" height="30">${r.classname}</td>
					<td width="150" height="30">${r.author}</td>
					<td width="150" height="30">${r.bookstatus}</td>
					<td width="150" height="30">${r.press}</td>
					<td width="150" height="30">${r.price}</td>
					<td width="100" height="30" style="text-align:left">
					<input type="hidden" id="readerid" name="readerid" value="${r.readerid}"/>
					<a href="javascript:guihuan('updateStatusServlet','${r.bookid}','1','post')">归还</a>
    				</td>
	              </tr>
				 </c:forEach>
		</table>
		<div align="center" id="but" style="font-size:14px">
		  
		  
		  共找到${totalCount}条记录，当前第${curpage}页，共有${totalPage}页，每页${pageSize}条记录
		  
		  &nbsp;&nbsp;
		  <c:if test="${curpage=='1'}">
		     首页
		  </c:if>
		  <c:if test="${curpage!='1'}">
		     <a href="javascript:toPage2('1','myreceivemsgServlet')">首页</a>
		  </c:if>   
		  <c:if test="${curpage=='1'}">
		     上一页 
		  </c:if>
		  <c:if test="${curpage!='1'}">
		     <a href="javascript:toPage2('${curpage-1}','myreceivemsgServlet')">上一页</a> 
		  </c:if> 
		  <c:if test="${curpage==totalPage}">
		     下一页 
		  </c:if>
		  <c:if test="${curpage!=totalPage}">
		     <a href="javascript:toPage2('${curpage+1}','myreceivemsgServlet')">下一页</a> 
		  </c:if>
		     
		  <c:if test="${curpage==totalPage}">
		     尾页
		  </c:if>
		  <c:if test="${curpage!=totalPage}">
		     <a href="javascript:toPage2('${totalPage}','myreceivemsgServlet')">尾页</a>
		  </c:if>   
		</div>
		</div>			
    </body>
</html>
