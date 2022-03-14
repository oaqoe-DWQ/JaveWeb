package com.zhao.stock.dao.utils;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class JDBCMySql {
	private static final JDBCMySql JDBC=new JDBCMySql();                    //单例模式-定义常量
	private  Connection conn;
																			/**查询时关闭**/
	public  PreparedStatement ps;                                           
																		    //定义要连接的数据库地址
	private  String url="jdbc:mysql://localhost:3306/huali?rewriteBatchedStatements=true&useUnicode=true&serverTimezone=Asia/Shanghai&characterEncoding=utf8";  
	private  String user="root";											//定义要连接的MySql账号
	private  String password="Hlxy12580.";										//定义要连接的MySql密码
	
	
	private JDBCMySql() {                                                  //单例模式-私有构造方法                    
	
	}
	
	
	static {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");						 //加载驱动
			System.out.println("加载驱动");
		} catch (ClassNotFoundException e) {
			System.out.println("加载驱动失败");
			e.printStackTrace();
		}                      
	}
																			/**
																			 *  	单例模式-获取JDBC类的对象
																			 * @return 返回JDBC类对象
																			 */
	public static JDBCMySql getJDBC() {

		return JDBC;		
	}
																			/**
																			 * 	连接数据库	
																			 * @return 返回连接对象Connection
																			 */
	public  void connectDB() {
		
		try {
			if(conn==null) {                                                  				
				conn=DriverManager.getConnection(url, user, password);			 //连接数据库
				System.out.println("连接数据库成功1");
			}
			else if(conn!=null&&conn.isValid(7)==false) {		                 //如果连接失效了	
				closeDB();
				conn=DriverManager.getConnection(url, user, password);			 //连接数据库
				System.out.println("连接数据库成功2");
			}				
		} catch (SQLException e) {
			System.out.println("连接数据库失败");
		}
	}
																			/**关闭数据库**/
	public void closeDB() {
		if(conn!=null) {
			try {
				conn.close();												//关闭数据库连接
				conn=null;
				System.out.println("关闭数据库成功");
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
																			/**
																			 *  执行非查询表操作
																			 * @param sql 传入相关sql语句
																			 * @return 返回执行的条数
																			 */
	public int submitSQL(String sql) {
		int n=0;
		try {
			if(conn==null) {
				System.out.println("请先连接数据库");
			}
			else if(conn!=null&&conn.isValid(7)==false) {					//如果连接失效
				closeDB();
				conn=DriverManager.getConnection(url, user, password);	     //连接数据库
				System.out.println("连接数据库成功3");
				PreparedStatement ps=conn.prepareStatement(sql);			//预置sql语句){
				n=ps.executeUpdate();									    //提交,返回执行的条数
				ps.close();                                                 //关闭	
			}
			else {
				PreparedStatement ps=conn.prepareStatement(sql);			//预置sql语句){
				n=ps.executeUpdate();									    //提交,返回执行的条数
				ps.close();                                                 //关闭	
			}
			
		} catch (SQLException e) {
			System.out.println("执行非查询SQL语句有异常");
			e.printStackTrace();
		} 
		return n;
	}
																		   /**
																		    * 	执行查询表操作
																		    * @param sql 传入要查询的sql语句
																		    * @return 返回查询到的结果集
																		    */
	public ResultSet queryDB(String sql) {
		 ResultSet rs=null;
		 try {  
			 	if(conn==null) {
					System.out.println("请先连接数据库");
				}
				else if(conn!=null&&conn.isValid(7)==false) {				//如果连接失效
					closeDB();
					conn=DriverManager.getConnection(url, user, password);	//连接数据库
					System.out.println("连接数据库成功4");
																		    //预置sql语句，并设置游标可上下移动。												
					ps=conn.prepareStatement(sql);		 				
					rs=ps.executeQuery();                                   //提交，获取查询到的结果集
			 	}
			 	else {		
			 																//预置sql语句，并设置游标可上下移动。												
			 		ps=conn.prepareStatement(sql);		 				
			 		rs=ps.executeQuery();                                   //提交，获取查询到的结果集								   
			 	}
		 }catch (SQLException e) {
				System.out.println("执行查询SQL语句有异常");
				e.printStackTrace();
		  } 
		
		return rs;
		
	}
	
																			/**
																			 * 	事务专用连接数据库	
																			 * @return 返回连接对象Connection
																			 */
	public  Connection connectBatchtDB() {
		Connection con=null;
		try {
		                                                
			 con=DriverManager.getConnection(url, user, password);			 //连接数据库
			System.out.println("事务连接数据库成功");
					
		}  catch (SQLException e) {
			System.out.println("事务连接数据库失败");
		}
		return con;
	}
}	
