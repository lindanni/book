<%@ page language="java" import="java.util.*,com.dao.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
BaseDAO dao=new BaseDAO();
Map<String,Object> data=dao.getAll("*", "classname", "", "classid desc", 0, 999);
List<Map<String,String>> classnames=(List<Map<String,String>>)data.get("records");
request.setAttribute("classnames", classnames); 
%>

<!doctype html>
<html lang="en">
 <head>
  <meta name="Generator" content="EditPlus®">
  <meta name="Author" content="">
  <meta name="Keywords" content="">
  <meta name="Description" content="">
  <meat charset="utf-8">
  <title>添加学生信息</title>
  <style>
		body,table,input,form{
		margin:0px;
		padding:0px}
	#main{
		background-color:#444;
		width:100%;
		height:400px;
		margin:10px auto;
		border:1px solid black;
		border-radius:10px;
	}
	form{
		width:60%;
		height:300px;
		margin-top:50px;
		margin-left:200px;
		color:#fff;		
	}
	input{
		width:150px;
		height:20px;
		margin-left:20px;
		border:1px solid white;
		border-radius:5px;
		text-align:left;
		font-family:"楷体";
		border-style:none none;
		}
	select{
		margin-left:20px;
		border:1px solid white;
		border-radius:5px;
	}
	td,th{
		color:#fff;
		border:0.5px dashed #fff;
		border-style:dashed none;
	}
	a{
		width:80px;
		height:20px;
		display:block;
		background:#fff;
		margin-left:320px;
		border:1px solid white;
		text-decoration:none;
		text-align:center;
		line-height:20px;
		color:#444;
	}
	 #tipinfo{
	  width:200px;
	  height:50px;
      text-align:center;  
	  font-size:14px;
	  color:#fff;
	  margin-left:300px;
	 margin-top:5px;  
   }
  </style>
 </head>
 <body>
 <div id="main">

	<form id="from1">
		<table cellpadding="0" cellspacing="0" border="0">
			<tr>
				<th width="100" height="50">图书类别</th>
				<td>
				<select id="classid" name="classid">
					<c:forEach items="${classnames}" var="c">
					    <option value="${c.classid}" <c:if test="${c.classid==r.classid}">selected='selected'</c:if> >${c.classname}</option>
					</c:forEach>
				</select>
				</td>
			</tr>
			<tr>
				<th width="100" height="50">图书编号</th>
				<td width="350" height="50"><input type="text" name="booknumber" id="booknumber"
				value=""/></td>
			</tr>
			<tr>
				<th width="100" height="50">图书名字</th>
				<td width="350" height="50"><input type="text" name="bookname" id="bookname"
				value=""/></td>
			</tr>
			<tr>
				<th width="100" height="50">作者</th>
				<td width="450" height="50">
					<input type="text" name="author" id="author" value=""/>
				</td>
			</tr>
			<tr>
				<th width="100" height="50">出版社</th>
				<td width="350" height="50"><input type="text" name="press" id="press"
				value=""/></td>
			</tr>
			<tr>
				<th width="100" height="50">图书价格</th>
				<td width="350" height="50"><input type="text" name="price" id="price"
				value=""/></td>
			</tr>
			<tr>
				<td colspan="2" height="50">
				<input type="hidden" id="readerid" name="readerid" value=""/>
				<a id="addbookBtn" href="javascript:void(0)">保存</a>
				</td>
			</tr>
		</table>
	</form>
	<div id="tipinfo"></div>	
	</div>
		<script src="jquery-1.11.3.min.js"></script>
	  	<script type="text/javascript">
	  	$(function(){ 
		//添加新闻“保存”的单击动作
		$("#addbookBtn").bind("click",function(){  
			
		   var booknumber=$("#booknumber");
		   if($.trim(booknumber.val()).length==0){
				$("#tipinfo").html("图书编号不能为空！");
				booknumber.focus();
				return;
		   }else{
				$("#tipinfo").html("");
		   }
		  
		   var bookname=$("#bookname");
		   if($.trim(bookname.val()).length==0){
				$("#tipinfo").html("图书名字不能为空！");
				bookname.focus();
				return;
		   }else{
				$("#tipinfo").html("");
		   }
		   
		   var author=$("#author");
		   if($.trim(author.val()).length==0){
				$("#tipinfo").html("作者不能为空！");
				author.focus();
				return;
		   }else{
				$("#tipinfo").html("");
		   }
		   
		   var press=$("#press");
		   if($.trim(press.val()).length==0){
				$("#tipinfo").html("作者不能为空！");
				press.focus();
				return;
		   }else{
				$("#tipinfo").html("");
		   }
		   
		   var price=$("#price");
		   if($.trim(price.val()).length==0){
				$("#tipinfo").html("作者不能为空！");
				price.focus();
				return;
		   }else{
				$("#tipinfo").html("");
		   }
		   
		   var readerid=$("#readerid");
		   
		   var url="addBookServlet";
		   //if(readerid!=null || readerid!=""){
			//	url="updateStudentServlet";			
		   //}
		   //验证通过后，用AJAX提交请求
		   $.ajax({
				 type: 'POST',
				 url: url,
				 data: {
					booknumber:$.trim(booknumber.val()),
					bookname:$.trim(bookname.val()),
					author:$.trim(author.val()),
					press:$.trim(press.val()),
					price:$.trim(price.val()),
					classid:$("#classid").val(),
				 },
				 success: function(data) {
					  //data代表服务端返回的数据
					  if($.trim(data)=="1"){//添加成功
							//设置提示信息为绿色
							$("#tipinfo").css("color","#fff");
							if(readerid.val()==null || readerid.val()==""){
								$("#tipinfo").html("添加图书信息成功");
							}else{
								$("#tipinfo").html("修改图书信息成功");
							}
							      
							//等待3秒后，重新用AJAX加载“添加新闻”页面
							setTimeout('ajaxLoadAddbookPage()',1500);

					  }else{//添加失败s
					     if(readerid.val()==null || readerid.val()==""){
						   $("#tipinfo").html("添加图书信息失败");
						 }else{
						   $("#tipinfo").html("修改图书信息失败"); 
						 }
					  }   
				 }
			});
	});
}); 
	function ajaxLoadAddbookPage(){
		$.ajax({
			 type: 'post',
			 url: 'addbook.jsp' ,
			 success: function(data) {
				  $("#buttom").html(data);
			 }
		 });	
}
	
  </script>
 </body>
</html>

