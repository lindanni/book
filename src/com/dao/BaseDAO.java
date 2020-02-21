package com.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.util.ZqDBUtil;


public class BaseDAO {

	public static final String url="jdbc:mysql://localhost:3306/book?user=root&password=123&useUnicode=true&characterEncoding=utf8";
	//查询单条记录
	public Map<String,String> getOneByWhere(String field,String table,String where){
		Map<String,String> record=null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con= DriverManager.getConnection(url);
			Statement stmt = con.createStatement();
			ResultSet rs=stmt.executeQuery("select "+field+" from "+table+" where "+where);
            List<Map<String,String>> data=ZqDBUtil.getHashMap(rs);
			if(data.size()>0){
				record=data.get(0);
			}
			con.close();
			rs.close();
			stmt.close();	
		} catch (Exception e) {
			e.printStackTrace();
		}
		return record;
	}
	//添加记录
	public boolean addOne(String table,String fields){
		    boolean flag=false;
			try {
				Class.forName("com.mysql.jdbc.Driver");
				Connection con= DriverManager.getConnection(url);
				Statement stmt = con.createStatement();
				int count=stmt.executeUpdate("insert into "+table+" set "+fields);
	            if(count>0){
	            	flag=true;
	            }
				con.close();
				stmt.close();	
			} catch (Exception e) {
				e.printStackTrace();
			}
			return flag;
	 }
	
	//查询多条记录
	public Map<String,Object> getAll(String field,String table,String where,String orderby,int startIndex,int pageSize){
		
		Map<String,Object> data=new HashMap<String,Object>();
		
		List<Map<String,String>> records=new ArrayList<Map<String,String>>();
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con= DriverManager.getConnection(url);
			Statement stmt = con.createStatement();
			String sql="select "+field+" from "+table+" where 1=1"+where+" order by "+orderby+" limit "+startIndex+","+pageSize;
			ResultSet rs=stmt.executeQuery(sql);
            records=ZqDBUtil.getHashMap(rs);
            
            System.out.println("sql:"+sql);
            
            String sqlcount="select count(*) totalCount from "+table+" where 1=1"+where;
            ResultSet rs2=stmt.executeQuery(sqlcount);
            rs2.next();
            int totalCount=rs2.getInt("totalCount");
            
            
            System.out.println("sqlcount:"+sqlcount);
            
            //记录列表
            data.put("records", records);
            //记录总数
            data.put("totalCount", totalCount);
            
            
			con.close();
			rs.close();
			stmt.close();	
		} catch (Exception e) {
			e.printStackTrace();
		}
		return data;
	}
	//修改记录
	public boolean updateOne(String table,String fields){
		    boolean flag=false;
			try {
				Class.forName("com.mysql.jdbc.Driver");
				Connection con= DriverManager.getConnection(url);
				Statement stmt = con.createStatement();
				int count=stmt.executeUpdate("update "+table+" set "+fields);
	            if(count>0){
	            	flag=true;
	            }
				con.close();
				stmt.close();	
			} catch (Exception e) {
				e.printStackTrace();
			}
			return flag;
	 }
	
	//删除记录
	public boolean deleteOne(String table,String id){
		    boolean flag=false;
			try {
				Class.forName("com.mysql.jdbc.Driver");
				Connection con= DriverManager.getConnection(url);
				Statement stmt = con.createStatement();
				int count=stmt.executeUpdate("delete from "+table+" where "+table+"id="+id);
	            if(count>0){
	            	flag=true;
	            }
				con.close();
				stmt.close();	
			} catch (Exception e) {
				e.printStackTrace();
			}
			return flag;
	 }

//通用的查询信息
public List<Map<String,String>> commonlist(String sql){
	List<Map<String,String>> data=null;
	try{
	//加载驱动
			Class.forName("com.mysql.jdbc.Driver");
	//建立连接
			String url="jdbc:mysql://localhost:3306/management?user=root&password=123&useUnicode=true&characterEncoding=utf8";
			Connection con=DriverManager.getConnection(url);
	//创建Statement
			Statement stmt=con.createStatement();
	//执行SQL语句
			ResultSet rs=stmt.executeQuery(sql);
			data=ZqDBUtil.getHashMap(rs);
	//关闭连接
			con.close();
			stmt.close();
			rs.close();
	}catch(Exception e){
		e.printStackTrace();
	}
	return data;
}
//修改状态
		public boolean update(String sql){
			    boolean flag=false;
				try {
					Class.forName("com.mysql.jdbc.Driver");
					Connection con= DriverManager.getConnection(url);
					Statement stmt = con.createStatement();
					int count=stmt.executeUpdate(sql);
		            if(count>0){
		            	flag=true;
		            }
					con.close();
					stmt.close();	
				} catch (Exception e) {
					e.printStackTrace();
				}
				return flag;
		 }
}

