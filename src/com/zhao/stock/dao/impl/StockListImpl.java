package com.zhao.stock.dao.impl;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.mysql.cj.protocol.Resultset;
import com.zhao.stock.dao.entity.StockList;
import com.zhao.stock.dao.utils.JDBCMySql;
public class StockListImpl {
       private JDBCMySql jdbc=JDBCMySql.getJDBC();
       
       public int addStockNumber(String stocknumber) {
    	   String sql="insert into stocklist(number)values('"+stocknumber+"')";
    	   int n=jdbc.submitSQL(sql);
    	   return n;
       }
       public ArrayList<StockList> queryStockNumber(){
    	   ArrayList<StockList> list=new ArrayList<StockList>();
    	   String sql="select *from stocklist";
    	   ResultSet rs=jdbc.queryDB(sql);
    	   if(rs!=null) {
    		   StockList stock=null;
    		   try {
				while(rs.next()) {
					   stock =new StockList();
					   stock.setId(rs.getInt("id"));
					   stock.setNumber(rs.getString("number"));
					   System.out.println(rs.getInt("id")+" "+rs.getString("number"));
				       list.add(stock);
				}
				rs.close();
				jdbc.ps.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
    		   
    	   }
		return list;
    	   
       }
       public int deleteStockNumber(int number) {
    	   String sql="delete from stocklist where id ="+number;
    	   int n=jdbc.submitSQL(sql);
		return n;
    	   
       }
}
