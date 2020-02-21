package com.control;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.BaseDAO;

public class UpdateStatusServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {
this.doPost(request, response);
}

public void doPost(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {
HttpSession session=request.getSession();
//进行登录页验证，防止没有登录直接进入此页面
String username=(String)session.getAttribute("username");
if(username!=null && !username.equals("")){
	request.setCharacterEncoding("utf-8");
    String newbookstatus=request.getParameter("statusid");
    int newbookstatus1=0;
    try{
    	newbookstatus1=Integer.parseInt(newbookstatus);
    }catch(NumberFormatException e){e.printStackTrace();}
    String bookid=request.getParameter("bookid");
    String readerid=request.getParameter("readerid");
    String borrowtime="";
    if(newbookstatus1==1){
    	borrowtime="";
    }else if(newbookstatus1==2) {
    	 borrowtime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
    }
    //调用DAO层
    System.out.println("newbookstatus:"+newbookstatus);
    System.out.println("bookid:"+bookid);
    BaseDAO dao=new BaseDAO();
    String sql="update book set statusid="+newbookstatus+",readerid="+readerid+",borrowtime='"+borrowtime+"' where bookid="+bookid;
    System.out.println("sql"+sql);
    boolean status=dao.update(sql);

    
    
    //设置Servlet返回数据的编码为“UTF-8”
    response.setContentType("text/html;charset=utf-8");
	PrintWriter out = response.getWriter();
    if(status==true){
    	out.println("1");
    }else{
    	out.println("0");
    }
	out.flush();
	out.close();
	
}


}

	

}

