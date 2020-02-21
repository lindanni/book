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
		top:300px;
		left:140px;
		color:#fff;
	}
        </style>
        <script src="jquery-1.11.3.min.js"></script>
        <script>
        function fanhui(url,method){
		$.ajax({
					 type: method,
					 url: url ,
			data:{
			 	readerid:$("#readerid").val()
			 },
					 success: function(data) {
						  $("#buttom").html(data);
					 }
			});
		}
        </script>	
    </head>
    <body>
    <div id="main">
 			<table id="table1" border="0.5" cellpadding="0" cellspacing="0">	
	              <tr>
	              	<th width="100" height="40">书名</th>
	              	<td width="100" height="30">${record.bookname}</td>
					<th width="150" height="30">编号</th>
					<td width="150" height="30">${record.booknumber}</td>
					<tr>
						 <th width="100" height="30">类别</th>
						<td width="100" height="30">${record.classname}</td>
						<th width="100" height="30">作者</th>
						<td width="150" height="30">${record.author}</td>
					</tr>
					<tr>
	                <th width="150" height="30">状态</th>
	                	<td width="150" height="30">${record.bookstatus}</td>
	                 <th width="100" height="30">出版社</th>
	                 	<td width="150" height="30">${record.press}</td>
	                 </tr>
	                 <tr>
	                 	<th width="100" height="30">价格</th>
	                 		<td width="150" height="30">${record.price}</td>
	                 	<th width="100" height="30">借书者</th>
	                 		<td width="150" height="30">${record.readername}</td>
	              	</tr>
				  <tr>
				  		<th width="100" height="30">借书时间</th>
	                 		<td width="150" height="30">${record.borrowtime}</td>
	                 	<th width="100" height="30"></th>
	                 		<td width="150" height="30">
	                 			 <input type="hidden" id="readerid" name="readerid" value="${readerid}"/>
	                 			 <a style="width:60px;height:20px;background:#fff;display:block;color:#444" href="javascript:fanhui('allbookServlet','post')">返回</a>
	                 		</td>
	              </tr>
			</table>
		</div>
		</body>
	</html>
