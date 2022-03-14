package com.zhao.stock.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.regex.Pattern;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.zhao.stock.dao.entity.StockList;
import com.zhao.stock.dao.impl.StockListImpl;
import com.zhao.stock.dao.utils.JDBCMySql;

/**
 * Servlet implementation class StockServlet
 */
@WebServlet("*.do")
public class StockServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private String number="600000";
	private JDBCMySql jdbc=JDBCMySql.getJDBC();
	private StockListImpl impl=new StockListImpl();

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		jdbc.connectDB();
	}

	/**
	 * @see Servlet#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
		jdbc.closeDB();
	}

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String uri=request.getRequestURI();
        String action=uri.substring(uri.lastIndexOf("/"),uri.lastIndexOf("."));
        if("/add".equals(action)){
        	String name=request.getParameter("stocknumber");
        	String xxx="[0-9][0-9][0-9][0-9][0-9][0-9]";
        	if(Pattern.matches(xxx, name)) {	
        		impl.addStockNumber(name);	
        	}
        }else if("/delete".equals(action)) {
        	String id=request.getParameter("id");
        	int n=impl.deleteStockNumber(Integer.parseInt(id));
             
	    }else if("/gegu".equals(action)){
        	 number=request.getParameter("number");
        	
        }
		
		ArrayList<StockList> list=impl.queryStockNumber();
        
        request.setAttribute("stocklist", list);
		request.setAttribute("gegu", number);
		request.getRequestDispatcher("index.jsp").forward(request, response);
	}

}
