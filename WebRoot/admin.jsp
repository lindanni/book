<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<title>顶部</title>
	<meta charset="utf-8">
	<style>
	body,div,nav,ul,li{
		margin:0;
		padding:0;
		list-style: none;
	}
	#top{
		width:75%;
		height:160px;
		margin:0px auto;
		background:url("images/deng.png") 200px -3px no-repeat;
		background-color:#444;
		background-size:60% 100%;
		border:1px solid white;
		border-radius:10px;
		position:absolate;
	}
	#nav{
		position: relative;
		width:550px;
		height:50px;
		margin:30px auto;
		background-color:#fff;
	}
	#nav:before{
		position: absolute;
		display: block;
		left:-17px;
		top:7px;
		content: '';
		width:36px;
		height:36px;
		transform:rotate(45deg);
		background-color:#444;
	}
	#nav:after{
		position: absolute;
		left:532px;
		top:7px;
		display: block;
		content: '';
		width:36px;
		height:36px;
		transform:rotate(45deg);
		background-color:#444;
	}
	#nav ul{
		position: relative;
		top:-10px;
		width:450px;
		height:60px;
		margin:0 auto;
		display: flex;
		overflow: hidden;
	}
	#nav ul li{
		position:relative;
		top:10px;
		width:100px;
		height:50px;
		text-align:center;
		line-height:50px;
		transition: .4s;
		box-shadow:0px 10px 0px -10px #444;
		cursor:pointer;
		border-radius: 5px;
		color:#444;
	}
	#nav ul li:hover{
		top:0px;
		background-color: #ff0;
	}
	#nav ul li:before{
		position:absolute;
		top:50px;
		display:block;
		content:'';
		width:10px;
		height:10px;
		background:linear-gradient(45deg,#fff 50%,#ccc 50%);
	}
	#nav ul li:after{
		position:absolute;
		right:0;
		top:50px;
		display:block;
		content:'';
		width:10px;
		height:10px;
		background:linear-gradient(-45deg,#fff 50%,#ccc 50%);
	}
	#buttom{
		width:75%;
		height:400px;
		margin:10px auto;
	}
	#admin{
		position:relative;
		left:700px;
		top:10px;
		width:60px;
		height:60px;
		background:url("images/admin.png") 0 0 no-repeat;
	}
	#admin:hover{
		cursor:pointer;
	}
	#yh{
		position:relative;
		top:70px;
		left:-12px;
		width:200px;
		height:140px;
		border:1px solid black;
		border-radius:10px;
		background-color:rgba(103,103,102,0.5);
		display:none;
	}
	#yh li{
		margin-top:10px;
		margin-left:20px;
		color:#fff;
		font-weight:bold;
	}
	</style>
</head>
<body>
	<div id="top">
		<div id="admin">
			<ul id="yh">
				<li>个人信息</li>
				<li>角色： ${role}</li>
				<li>用户名：${username}</li>
				<li>姓名： ${adminname}</li>
			</ul>
		</div>
		<div id="nav">
			<ul>
				<li id="addreader">添加读者</li>
				<li id="addbook">添加图书</li>
				<li id="borrowread">借阅管理</li>
				<li id="updatepwd">修改密码</li>
			</ul>
		</div>
	</div>
	<div id="buttom"></div>
	<div id="admin"></div>
	    <script src="jquery-1.11.3.min.js"></script>
		<script type="text/javascript">
			   $(function(){
			   $("#addbook").bind("click",function(){  
                       //用AJAX发送GET请求获取“添加新闻”页面
				       $.ajax({
						     type: 'GET',
						     url: 'addbook.jsp' ,
						     success: function(data){
						          //将“添加学生”页面的内容插入到页面的“主区域”
						          $("#buttom").html(data);
						     }
						});
			 	  });
			 	  $("#addreader").bind("click",function(){  
                       //用AJAX发送GET请求获取“添加新闻”页面
				       $.ajax({
						     type: 'GET',
						     url: 'addreader.jsp' ,
						     success: function(data){
						          //将“添加学生”页面的内容插入到页面的“主区域”
						          $("#buttom").html(data);
						     }
						});
			 	  });
		 	  $("#borrowread").bind("click",function(){  
                      //用AJAX发送GET请求获取“添加新闻”页面
			       $.ajax({
					     type: 'GET',
					     url: 'lookreaderServlet' ,
					     success: function(data){
					          //将“添加教师”页面的内容插入到页面的“主区域”
					          $("#buttom").html(data);
					     }
					});
		 	  });
		 	   $("#updatepwd").bind("click",function(){  
                      //用AJAX发送GET请求获取“添加新闻”页面
			       $.ajax({
					     type: 'GET',
					     url: 'updateAdminPwd.jsp' ,
					     success: function(data){
					          //将“添加教师”页面的内容插入到页面的“主区域”
					          $("#buttom").html(data);
					     }
					});
		 	  });
		 	   $("#admin").hover(function(){
		 	   		$("#yh").show();
		 	   		$("#yh").animate({top:'60px',left:'-12px'},700);
		 	   		$("#yh").animate({top:'70px',left:'-12px'},700);
		 	   		$("#yh").animate({top:'60px',left:'-12px'},700);
		 	   		$("#yh").animate({top:'70px',left:'-12px'},700);
		 	   },function(){
		 	   		$("#yh").hide();
		 	   });	 
 });
			   //点击“新闻列表“链接的动作  
        </script>
</body>
</html>