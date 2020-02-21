package com.control;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.BaseDAO;

public class LookreaderServlet extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request,response);
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session=request.getSession();
	    //进行登录页验证，防止没有登录直接进入此页面
	    String username=(String)session.getAttribute("username");
	    if(username!=null && !username.equals("")){ 
	    	
	    	 request.setCharacterEncoding("utf-8");	 
			 String page=request.getParameter("curpage");
			 //当前页
			 int curpage=1;
			 if(page!=null && !page.equals("")){
				 curpage=Integer.parseInt(page);
			 }
			 request.setAttribute("curpage", curpage);
			 //页大小
			 int pageSize=4;
			 int startIndex=(curpage-1)*pageSize;
			 
			 
			 String where=" and a.majorid=b.majorid";
			 
			 //读者用户名
			 String readeruser=request.getParameter("readeruser");
			 if(readeruser!=null && !readeruser.equals("")){
				 where+=" and a.readeruser like '%"+readeruser+"%'";
				 request.setAttribute("readeruser", readeruser);
			 }
			 //读者名字
			 String readername=request.getParameter("readername");
			 if(readername!=null && !readername.equals("")){
				 where+=" and a.readername like '%"+readername+"%'";
				 request.setAttribute("readername", readername);
			 } 
			 //调用DAO层
			 BaseDAO dao=new BaseDAO();
			 Map<String,Object> data=dao.getAll("a.*,b.majorname", "reader a,majorname b", where, "a.readerid desc",startIndex,pageSize);
			
			 //记录数据
			 List<Map<String,String>> records=(List<Map<String,String>>)data.get("records");
			 //记录总数
			 int totalCount=(Integer)data.get("totalCount");
			 
			 //总页数
			 int totalPage=0;
			 if(totalCount%pageSize==0){
				 totalPage=totalCount/pageSize;
			 }else if(totalCount%pageSize>0){
				 totalPage=totalCount/pageSize+1;
			 }
			 
			 
			 request.setAttribute("curpage", curpage);
			 request.setAttribute("totalPage", totalPage);
			 request.setAttribute("pageSize", pageSize);
			 request.setAttribute("totalCount", totalCount);
			  
		     //List<Map<String,String>> records=dao.getAll("*", "news", "", "newsid desc",startIndex,pageSize);
		     //返回数据给视图页面
		     request.setAttribute("records", records);
	         request.getRequestDispatcher("lookreader.jsp").forward(request, response);	 
	
	    }
	}

}

