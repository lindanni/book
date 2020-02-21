package com.control;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.BaseDAO;

public class OnebookServlet extends HttpServlet {
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
	    	String bookid=request.getParameter("bookid");
	    	String readerid=request.getParameter("readerid");
	    	request.setAttribute("readerid", readerid);
	        //调用DAO层
	        BaseDAO dao=new BaseDAO();
	        Map<String,String> record=dao.getOneByWhere("a.*,b.readername,c.classname,d.bookstatus","book a,reader b,classname c,bookstatus d","a.readerid=b.readerid and a.classid=c.classid and a.statusid=d.statusid and a.bookid="+bookid);
	   
	        //设置Servlet返回数据的编码为“UTF-8”
	        response.setContentType("text/html;charset=utf-8");
	        request.setAttribute("record", record);
	        request.getRequestDispatcher("lookonebook.jsp").forward(request, response);
	
	    }
	}

}
