<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<% 
String adminpwd=(String)session.getAttribute("adminpwd");
%>
<!doctype html>
<html lang="en">
 <head>
  <meta name="Generator" content="EditPlus®">
  <meta name="Author" content="">
  <meta name="Keywords" content="">
  <meta name="Description" content="">
  <title>修改管理员密码</title>
  <style>
	body,table,input,form{
		margin:0px;
		padding:0px}
	#main{
		background-color:#444;
		width:100%;
		height:400px;
		margin:10px auto;
		border:1px solid #fff;
		border-radius:20px;
	}
	form{
		width:80%;
		height:200px;
		margin-top:50px;
		margin-left:200px;
		color:#fff;
		text-align:left;
		font-family:"楷体";
		border-style:none none;
	}
	td,th{
		color:#fff;
		border:0.5px dashed #fff;
		border-style:dashed none;
	}
	input{
		width:150px;
		height:20px;
		margin-left:20px;
		border:1px solid white;
		border-radius:5px;
		}
	select{
		margin-left:20px;
		border:1px solid white;
		border-radius:5px;
	}
	a{
		width:80px;
		height:20px;
		display:block;
		background:#fff;
		margin-left:250px;
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
	  color:red;
	  margin-top:30px;
	  margin-left:300px;
   }
  </style>
 </head>
 <body>
 <div id="main">
	<form >
		<table cellpadding="0" cellspacing="0" border="0">
			<tr>
				<th width="100" height="50">原密码</th>
				<td width="300" height="50"><input type="text" name="oldpwd" 
				id="oldpwd" value=""/></td>
			</tr>
			<tr>
				<th width="100" height="50">新密码</th>
				<td width="300" height="50"><input type="text" name="newpwd" id="newpwd"
				value=""/></td>
			</tr>
			<tr>
				<th width="100" height="50">确认新密码</th>
				<td width="300" height="50"><input type="text" name="newpwd1" id="newpwd1"
				value=""/></td>
			</tr>
			<tr>
				<td colspan="2" height="50">
				<a id="updateAdminPwdBtn" name="updateAdminPwdBtn" href="javascript:void(0)">保存</a>
				</td>
			</tr>
		</table>
	</form>
	<div id="tipinfo"></div>	
	</div>
		<script src="jquery-1.11.3.min.js"></script>
	  	<script type="text/javascript">
	  	$(function(){ 
		$("#updateAdminPwdBtn").bind("click",function(){  
			   //验证新密码
		   var oldpwd=$("#oldpwd");
		   if($.trim(oldpwd.val()).length==0){
				$("#tipinfo").html("原密码不能为空！");
				oldpwd.focus();
				return;
		   }else{
				$("#tipinfo").html("");
		   }
		   //新密码
		   var newpwd=$("#newpwd");
		   if($.trim(newpwd.val()).length==0){
				$("#tipinfo").html("新密码不能为空！");
				newpwd.focus();
				return;
		   }else{
				$("#tipinfo").html("");
		   }
		   //确认新密码
		   var newpwd1=$("#newpwd1");
		   if($.trim(newpwd1.val()).length==0){
				$("#tipinfo").html("确认新密码不能为空！");
				newpwd1.focus();
				return;
		   }else{
				$("#tipinfo").html("");
		   }
		   var adminpwd=<%=adminpwd%>;
		   if(oldpwd.val().toString()!=adminpwd){
		   		$("#tipinfo").html("原密码输入错误！");
		   		return;
		   }else{
				$("#tipinfo").html("");
		   }
		   if(newpwd.val()!=newpwd1.val()){
		   		$("#tipinfo").html("两次密码不一样！");
		   		return;
		   }else{
				$("#tipinfo").html("");
		   }
		   //验证通过后，用AJAX提交请求
		   $.ajax({
				 type: 'POST',
				 url:"updateAdPwdServlet",
				 data: {
					oldpwd:$.trim(oldpwd.val()),
					newpwd:$.trim(newpwd.val()),
				 },
				 success: function(data) {
					  //data代表服务端返回的数据
					  if($.trim(data)=="1"){//添加成功
							//设置提示信息为绿色
							$("#tipinfo").css("color","#fff");
							$("#tipinfo").html("修改密码成功");    
							setTimeout('updateAdminPwdPage()',1500);
					  }else{//添加失败	
						   $("#tipinfo").html("修改密码失败"); 
					  }   
				 }
			});
	});
}); 
	function updateAdminPwdPage(){
		window.location='login.jsp';
}
  </script>
 </body>
</html>
