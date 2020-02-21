<%@ page language="java" import="java.util.*,com.dao.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
BaseDAO dao=new BaseDAO();
Map<String,Object> data=dao.getAll("*", "rolename", "", "roleid desc", 0, 999);
List<Map<String,String>> rolenames=(List<Map<String,String>>)data.get("records");
request.setAttribute("rolenames", rolenames); 
%>
<!DOCTYPE html>
<html>
<head>
	<title>登录界面</title>
	<meta charset="utf-8">
	<style type="text/css">
			div,form,ul,li,span,input{
			margin: 0;
			padding: 0;
			list-style: none;
		}
		#denglu{
			width: 90%;
			height: 400px;
			margin:100px auto;
			background: url("images/denglu.png") 0 0 no-repeat;
			background-size: 100% 100%;
		}
		form{
			width:23%;
			height:60%;
			left:70%;
			position:absolute;
			z-index: 2;
		}
		input{
			display: block;
			width:50%;
			height:20px;
			font-size:15px;
			border-radius: 5px
		}
		#username{
			margin-left:52px;
			margin-top: 18px;
		}
		#password{
			margin-top:26px;
			margin-left:52px;
		}
		#anniu{
			width:81%;
			height:45px;
			margin-top:17px;
			margin-left:17px;
			background: url("images/anniu.png") 0 0 no-repeat;
			background-size: 100% 100%;
		}
		#ww{
			clear:both;
			width: 250px;
			height: 30px;
			font-size:13px;
			margin-left:70px;
			color:#fff;
		}
		a{
			text-decoration: none;
			color:#fff;
		}
		select{
			width:80px;
			height:20px;
			border-radius:5px;
			font-size: 13px;
			display: block;
			margin-top:70px;
			margin-left:12px;
		}
		ul{
			width:400px;
			height:30px;
			font-size:13px;
			margin-top: 28px;
			margin-left: 15px;
			font-size:12px
		}
	 	ul li{
		 		float:left;
		 		height:25px;
		 		line-height:30px;
		 		border:1px solid #ccc;
		 		color:#fff;
	 	}
		#textfield{
			width:70px;
			display: inline-block;
			margin-left: 5px;
			float:left;
		}
	 	#code{
	 			display: inline-block;
	 			margin-top:3px;
	 		}
	 	#huan{
	 		width:45px;
	 		font-size: 13px;
	 		margin-left:2px;
	 		color:#fff;
	 	}
	 	#tipinfo{
	 			width:200px;
	 			height:30px;
				text-align:center;
				margin-top:20px;
				font-size:14px;
				margin-left:100px;
				color:red;
			}
			img{
				width:17px;
				height:20px;
			}
	</style>
</head>
<body onload="yz();">
	<!--<canvas class="bubble"></canvas>-->
	<div id="bj"></div>
	<div id="denglu">
		<form form="form1">
			<select id="roleid" name="roleid">
				<c:forEach items="${rolenames}" var="c">
			        <option value="${c.name}" <c:if test="${c.roleid==r.roleid}">selected='selected'</c:if> >${c.name}</option>
			    </c:forEach>
			</select>
			<input id="username" name="username" type="text" />
			<input id="password" name="password" type="password"/>
			 <ul>
			      <li><input name="textfield" type="text" id="textfield" size="10"  />&nbsp;
			      <span id="code">
			         <img src="" alt="" /><img src="" alt="" /><img src="" alt="" /><img src="" alt="" />
			      </span>
			      </li>
			       <li><a id="huan"name="huan" onclick="yz();" href="#">看不清</a></li>
			 </ul>
			<input id="anniu" name="anniu" type="button"/>
			<div id="tipinfo"></div>
			<div id="ww"><a href="#">用户注册</a> | <a href="#">忘记密码</a></div>	
		</form>
		</div>
		<script src="jquery-1.11.3.min.js"></script>
		<script type="text/javascript">
	 	    var num;
	 	    var sum;                         
			var pic="";                 
			function yz(){
				var img="";
				var arr1=new Array;
				for(var i=0;i<4;i++){       
					num=Math.floor(Math.random()*10);       
					pic="<img src='images/"+num+".jpg' />";
					img=img+pic; 
					arr1[i]=num;          
				}
				sum=arr1[0]*1000+arr1[1]*100+arr1[2]*10+arr1[3];
				var oCode=document.getElementById('code');
				oCode.innerHTML=img;
			}
		$(function(){ 
		    //“登录”的单击动作
			$("#anniu").bind("click",function(){  
			       //验证账号
			       var username=$("#username");
			       if($.trim(username.val()).length==0){
			            $("#tipinfo").html("账号不能为空！");
			            username.focus();
			            return;
			       }else{
			            $("#tipinfo").html("");
			       }
			       //验证账号
			       var password=$("#password");
			       if($.trim(password.val()).length==0){
			            $("#tipinfo").html("密码不能为空！");
			            password.focus();
			            return;
			       }else{
			            $("#tipinfo").html("");
			       }
			       var textfield=$("#textfield");
			       if($.trim(textfield.val()).length==0){
			            $("#tipinfo").html("验证码不能为空！");
			            textfield.focus();
			            return;
			       }else{
			            $("#tipinfo").html("");
			       }
			       if($.trim(textfield.val())!=sum){
    					$("#tipinfo").html("验证码错误！");
    					textfield.focus();
    					return;
    				}else{
    					 $("#tipinfo").html("");
    				}
			       //验证通过后，用AJAX提交请求
			       $.ajax({
					     type: 'POST',
					     url: 'Login_do.jsp' ,
					     data: {
					        username:$.trim(username.val()),
					        password:$.trim(password.val()),
					        role:$("#roleid").val(),
					     },
					     success: function(data) {
					          //data代表服务端返回的数据
					          if($.trim(data)=="1"){//登录成功，跳转到系统主页
					               if($("#roleid").val()=="图书管理员"){
					               		window.location.href="admin.jsp";
					               }else if($("#roleid").val()=="读者"){
					               		window.location.href="teacher.jsp";
					               }else{//登录失败
					               $("#tipinfo").html("用户名或密码错误");
					          }   
					        }
					       }
					});
			});  
		}); 
      </script>
</body>
</html>
