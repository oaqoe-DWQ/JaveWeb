package com.zhao.stock.dao.utils;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class JDBCMySql {
	private static final JDBCMySql JDBC=new JDBCMySql();                    //����ģʽ-���峣��
	private  Connection conn;
																			/**��ѯʱ�ر�**/
	public  PreparedStatement ps;                                           
																		    //����Ҫ���ӵ����ݿ��ַ
	private  String url="jdbc:mysql://localhost:3306/huali?rewriteBatchedStatements=true&useUnicode=true&serverTimezone=Asia/Shanghai&characterEncoding=utf8";  
	private  String user="root";											//����Ҫ���ӵ�MySql�˺�
	private  String password="Hlxy12580.";										//����Ҫ���ӵ�MySql����
	
	
	private JDBCMySql() {                                                  //����ģʽ-˽�й��췽��                    
	
	}
	
	
	static {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");						 //��������
			System.out.println("��������");
		} catch (ClassNotFoundException e) {
			System.out.println("��������ʧ��");
			e.printStackTrace();
		}                      
	}
																			/**
																			 *  	����ģʽ-��ȡJDBC��Ķ���
																			 * @return ����JDBC�����
																			 */
	public static JDBCMySql getJDBC() {

		return JDBC;		
	}
																			/**
																			 * 	�������ݿ�	
																			 * @return �������Ӷ���Connection
																			 */
	public  void connectDB() {
		
		try {
			if(conn==null) {                                                  				
				conn=DriverManager.getConnection(url, user, password);			 //�������ݿ�
				System.out.println("�������ݿ�ɹ�1");
			}
			else if(conn!=null&&conn.isValid(7)==false) {		                 //�������ʧЧ��	
				closeDB();
				conn=DriverManager.getConnection(url, user, password);			 //�������ݿ�
				System.out.println("�������ݿ�ɹ�2");
			}				
		} catch (SQLException e) {
			System.out.println("�������ݿ�ʧ��");
		}
	}
																			/**�ر����ݿ�**/
	public void closeDB() {
		if(conn!=null) {
			try {
				conn.close();												//�ر����ݿ�����
				conn=null;
				System.out.println("�ر����ݿ�ɹ�");
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
																			/**
																			 *  ִ�зǲ�ѯ�����
																			 * @param sql �������sql���
																			 * @return ����ִ�е�����
																			 */
	public int submitSQL(String sql) {
		int n=0;
		try {
			if(conn==null) {
				System.out.println("�����������ݿ�");
			}
			else if(conn!=null&&conn.isValid(7)==false) {					//�������ʧЧ
				closeDB();
				conn=DriverManager.getConnection(url, user, password);	     //�������ݿ�
				System.out.println("�������ݿ�ɹ�3");
				PreparedStatement ps=conn.prepareStatement(sql);			//Ԥ��sql���){
				n=ps.executeUpdate();									    //�ύ,����ִ�е�����
				ps.close();                                                 //�ر�	
			}
			else {
				PreparedStatement ps=conn.prepareStatement(sql);			//Ԥ��sql���){
				n=ps.executeUpdate();									    //�ύ,����ִ�е�����
				ps.close();                                                 //�ر�	
			}
			
		} catch (SQLException e) {
			System.out.println("ִ�зǲ�ѯSQL������쳣");
			e.printStackTrace();
		} 
		return n;
	}
																		   /**
																		    * 	ִ�в�ѯ�����
																		    * @param sql ����Ҫ��ѯ��sql���
																		    * @return ���ز�ѯ���Ľ����
																		    */
	public ResultSet queryDB(String sql) {
		 ResultSet rs=null;
		 try {  
			 	if(conn==null) {
					System.out.println("�����������ݿ�");
				}
				else if(conn!=null&&conn.isValid(7)==false) {				//�������ʧЧ
					closeDB();
					conn=DriverManager.getConnection(url, user, password);	//�������ݿ�
					System.out.println("�������ݿ�ɹ�4");
																		    //Ԥ��sql��䣬�������α�������ƶ���												
					ps=conn.prepareStatement(sql);		 				
					rs=ps.executeQuery();                                   //�ύ����ȡ��ѯ���Ľ����
			 	}
			 	else {		
			 																//Ԥ��sql��䣬�������α�������ƶ���												
			 		ps=conn.prepareStatement(sql);		 				
			 		rs=ps.executeQuery();                                   //�ύ����ȡ��ѯ���Ľ����								   
			 	}
		 }catch (SQLException e) {
				System.out.println("ִ�в�ѯSQL������쳣");
				e.printStackTrace();
		  } 
		
		return rs;
		
	}
	
																			/**
																			 * 	����ר���������ݿ�	
																			 * @return �������Ӷ���Connection
																			 */
	public  Connection connectBatchtDB() {
		Connection con=null;
		try {
		                                                
			 con=DriverManager.getConnection(url, user, password);			 //�������ݿ�
			System.out.println("�����������ݿ�ɹ�");
					
		}  catch (SQLException e) {
			System.out.println("�����������ݿ�ʧ��");
		}
		return con;
	}
}	
