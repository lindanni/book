<%@ page language="java" import="java.util.*,com.dao.*" pageEncoding="utf-8"%>
<%
  	request.setCharacterEncoding("utf-8");
//1.接收数据
	String username=request.getParameter("username");
	String password=request.getParameter("password");
	String role=request.getParameter("role");
//2.保存到数据库
	BaseDAO dao=new BaseDAO();
	Map<String,String> record=null;
	//主页面
	 if(("图书管理员").equals(role)){
		if(dao.getOneByWhere("*","admin"," username='"+username+"' and adminpwd='"+password+"'")!=null){
			record=dao.getOneByWhere("*","admin","username='"+username+"' and adminpwd='"+password+"'");
			session.setAttribute("adminname",record.get("adminname"));
			session.setAttribute("adminid",record.get("adminid"));
			session.setAttribute("adminpwd",record.get("adminpwd"));
		}
	}
	if(record!=null)
	{
		session.setAttribute("role",role);
		session.setAttribute("username",username);
		out.println("1");
	}else{
		out.println("0");
	}
 %>