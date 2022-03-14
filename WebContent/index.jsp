<%@page import="java.sql.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.sun.crypto.provider.RSACipher"%>
<%@page import="com.sun.javafx.animation.TickCalculation"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="com.mysql.cj.result.LocalTimeValueFactory"%>
<%@page import="java.time.LocalTime"%>
<%@page import="com.mysql.cj.jdbc.DatabaseMetaDataUsingInfoSchema"%>
<%@page import="jdk.nashorn.internal.ir.SetSplitState"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.zhao.stock.dao.entity.StockList"%>
<%@page import="java.util.HashMap"%>
<%@page import="okhttp3.Response" %>
<%@page import="okhttp3.Request" %>
<%@page import="okhttp3.OkHttpClient" %>
<%@page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>股票查询系统</title>
<style type="text/css">
	body{
		text-align: center;
		font-family: sans-serif;
		 background-color: rgba(238,0,205,0.3);
	}
	.divtop{
		position: absolute;
		width: 18%;
		height: 26%;
		 background-color: rgba(238,0,205,0.3);
		display: inline-block;
		top: 15%;
		border-radius: 8px;
		border-style: solid;
		border-width: 2px;
		border-color: rgb(50,232,205);
		box-shadow:00px 0px 10px rgba(0,0,0,0.6);
	}
	
	.divbottom{
		position: absolute;
		width: 18%;
		height: 26%;
		display: inline-block;
		top: 45%;
	}
	
	.ktitle{
		position: inherit;
		width: 40%;
		height: 23px;
		 background-color: rgba(50,232,205,10);
		bottom:93%;
		border-radius: 4px;
		box-shadow:0px 6px 6px rgba(0,0,0,0);
		left:30%;
		color:rgb(0,0,0);
		line-height: 22px;
	}
	
	.kimage{
		width:100%;
		height:100%;
		border-radius:8px;
		border-style:solid ;
		border-width: 2px;
		background-color:rgba(255,255,255,10);
		box-shadow:0px 0px 10px rgba(0,0,0,0.3);
	
		
	}
	
	#div1{
		left:11%;
	}
	#div2{
		left:31%;
	}
	#div3{
		left:51%;
	}
	#div4{
		left:71%;
	}
	#div5{
		left:11%;
	}
	#div6{
		left:31%;
	}
	#div7{
		left:51%;
	}
	#div8{
		left:71%;
	}
	#div10{ 
	  position: inherit;
		width: 200px;
		height: 80px;
		 background-color: rgba(50,232,205,10);
		border-radius: 4px;
		box-shadow:0px 6px 6px rgba(0,0,0,0);
		margin-left:32%;
		color:rgb(0,0,0);
		line-height: 22px;
	}
	#div9{
		position: absolute;
		width: 50%;
		height: 40px;
		top:85%;
		background-color:rgba(238,0,205,0.6);
		left: 25%;
		border-radius:50px;
		border-style: solid;
		border-width: 2px;
		border-color: rgb(50,232,205);
		box-shadow:0px 5px 8px rgba(0,0,0,0.4);
	}
	
	#table_main{
	width: 66%;
	 	height: 100%;
	 	margin: auto;
		border-collapse: collapse; 
	}
	#td_main{
		width: 16%;
		color: rgb(0,0,0);
		border-color: rgb(50,232,205);
		border-width: 0px;
		border-style: solid;
		border-left-width: 1px;
	}
	.td_main{
	  background-color:rgba(238,0,205,0.6);
	
	}
	
	#id_ai{
		border-right-width: 1px;
	}
	
	form{
		margin:3px;
	}
	
	input{
		width:40%;
		height:19px;
		background-color: rgb(50,232,205);
		border: 0px;
		outline: none;
		box-shadow: 0px 0px 8px rgba(0,0,0,0.8);
	}
	
	input:focus{
		outline: 1px solid rgb(0,0,0);
	}
	
	button{
		padding: 0px;
		margin: 0px;
		background-color: rgb(238,0,205);
		border-radius: 3px;
		border-width: 1.5px;
		border-style: solid;
		border-color: rgb(238,0,205);
		font-size: 12px;
		margin-left: 8px;
		box-shadow: 0px 0px 8px rgba(0,0,0,0.8);
		padding: 1.3px;
	}
	
	button:focus{
		outline:none;
		border-radius: 3px;
		border-width: 2px;
		border-style: solid;
		border-color: rgb(50,232,205);
	}
	
	#stocklist{
		position: inherit;
		width: 100%;
		height: 85%;
		color: rgb(0,0,0);
		overflow-y:scroll;
		overflow-x:none;
		bottom: 0px;
		scrollbar-width:auto;
		-ms-overflow-style:scrollbar;
		}
	
	#stocklist::-webkit-scrollbar{
		display: none;
	}
	#showlist{
		position: inherit;
		width: 100%;
		height: 100%;
		color: rgb(0,0,0);
		bottom: 0px;
		scrollbar-width:auto;
		-ms-overflow-style:scrollbar;
		}
	
	#showlist::-webkit-scrollbar{
		display: none;
	}
	p{
		padding: 0px;
		margin: 0px;
	}
	#dapan{
	width:100%;
	margin-top:30px;
	}
	#table_list{
	   width:100%;
	}
	.color1{
	  color:rgb(255,255,0);
	}
	.product{
		position: absolute;
	    left:15%;
	    top:30%;
	    font-size: 130%;
	   word-wrap: break-word;
      word-break: break-all;
	
	}
	#small_1{
	   position: absolute;
	    width:60px;
	    height:100px;
	    margin-left: 10px;
	}
	.in{
	 position: absolute;
	   left:25%;
	    top:120%;
	    font-size: 90%;
	}
	#small_2{
	
	     position: absolute;
	    width:200px;
	    height:100px;
	    margin-top:20px;
	   margin-left: 80px;
	}
		
	iframe{
	 
	   width:100%;
	   height:100%;

	}
	#small_3{
	   position: relative;
	  width:100%;
	  height:2%;
	  margin-top:15px;
	 
	}
	.data_query{
	  font-size: 85%;
	}
	.date_time{
	  position: absolute;
	    margin-left:15px;
	    margin-top: 25px;
	}
	#small_4{
	
	     position: relative;
	    width:100%;
	    height:95%;
	    margin-top:20px;
	}
	img{
	    width:260px;
	
	}
</style>
</head>
<body>
<%!
	OkHttpClient okhttp=new OkHttpClient();

	public String[] getStockDapanData(String url){
		String[] data=new String[]{};
		try{
			Request request=  new Request.Builder().url(url).build();
			Response res=okhttp.newCall(request).execute();
			if(res.isSuccessful()){
				String data1=res.body().string();
				
				String data2=data1.substring(data1.indexOf("\"")+1, data1.lastIndexOf("\""));
				data=data2.split(",");
				
			}
			}catch(Exception e){
				
			}
			return data;
	}
	public HashMap<String,Object> getStockData(String stocknumber){
		   HashMap<String,Object> map=new HashMap<String,Object>();
		   String[] data=new String[]{};
		   String adress="";
		   
		   String url1="http://hq.sinajs.cn/list=sh"+stocknumber;
		   try{
				Request request1=  new Request.Builder().url(url1).build();
				Response res1=okhttp.newCall(request1).execute();
				if(res1.isSuccessful()){
					String data1=res1.body().string();
					String data2=data1.substring(data1.indexOf("\"")+1, data1.lastIndexOf(";")-1);
					data=data2.split(",");	
					adress="sh";
				}			
				if(data.length<=1){
		   String url2="http://hq.sinajs.cn/list=sz"+stocknumber;
		   Request request2=  new Request.Builder().url(url2).build();
			Response res2=okhttp.newCall(request2).execute();
			if(res2.isSuccessful()){
				String data1=res2.body().string();
				String data2=data1.substring(data1.indexOf("\"")+1, data1.lastIndexOf(";")-1);
				data=data2.split(",");	
				adress="sz";
			}
				}
				if(data.length<=1){
					data[0]="股票错误";
				}
	           map.put("data",data);
	           map.put("adress", adress);
		   }catch(Exception e){
				
			}
		   return map;
	}
%>
<%getStockDapanData("http://hq.sinajs.cn/list=s_sh000001"); %>
	<div id="div1" class="divtop">
	<table id ="dapan">
	<%
	try{	
		String[] shangzheng=getStockDapanData("http://hq.sinajs.cn/list=s_sh000001");
	%>
	<tr><td><%=shangzheng[0] %></td><td><%=shangzheng[1]%></td><td><%=shangzheng[3]%>%</td></tr>
	<%
		String[] shencheng=getStockDapanData("http://hq.sinajs.cn/list=s_sz399001");
	%>
	<tr><td> <%=shencheng[0]%></td><td><%=shencheng[1] %></td><td><%=shencheng[3]%>%</td></tr>
	<%
		String[] chuangzhi=getStockDapanData("http://hq.sinajs.cn/list=s_sz399006");
	%>
	<tr><td><%=chuangzhi[0]%> </td><td><%=chuangzhi[1]%></td><td><%=chuangzhi[3]%>%</td></tr>
	<%
		String[] zhongxiao=getStockDapanData("http://hq.sinajs.cn/list=s_sz399005");
	%>
	<tr><td><%=zhongxiao[0]%> </td><td><%=zhongxiao[1] %></td><td><%=zhongxiao[3] %>%</td></tr>
	<%
	}catch(Exception e){
		
	}
	%>
	</table>
	</div>
	<div id="div2" class="divtop">
		<form action="add.do">
			<input placeholder="输入股票代码" required="required" name="stocknumber">
			<button>+</button>
		</form>
		<div id="stocklist">
	   <%
		   ArrayList<StockList> list=(ArrayList)request.getAttribute("stocklist");
		    if(list!=null){
	    %>
	    <table id="table_list">
	    <% 
		        for(StockList i :list){
		         String[] stockdata= (String[]) getStockData(i.getNumber()).get("data");
		         try{
		         double nowprice=Double.parseDouble(stockdata[3]);
		         double yesterdayprice=Double.parseDouble(stockdata[2]);
		         double rate=(nowprice-yesterdayprice) / yesterdayprice*100;
		         BigDecimal d=new BigDecimal(rate);
		         double  rate2=d.setScale(2, BigDecimal.ROUND_UP).doubleValue();
		         if(rate2>0){
		      %>
		      <tr class="color1"><td><a href ="gegu.do?number=<%=i.getNumber()%>"><%=stockdata[0] %></a></td><td><%=stockdata[3] %></td><td>+<%=rate2 %>%</td><td></td><td><a href="delete.do?id=<%=i.getId()%>"><button>x</button></a></td></tr>
		      <% 	 
		         }else{
		       %>
		       <tr ><td><a href ="gegu.do?number=<%=i.getNumber()%>"><%=stockdata[0] %></a></td><td><%=stockdata[3] %></td><td><%=rate2 %>%</td><td></td><td><a href="delete.do?id=<%=i.getId()%>"><button>x</button></a></td></tr>
		       <%  	 
		          }
		        
		        }catch(Exception e){
		        	try{
		       	 %>
					<tr><td><%=i.getNumber() %></td><td>股票错误</td><td></td><td></td><td><a href="delete.do?id=<%=i.getId()%>"><button>x</button></a></td></tr>
				 <%
		            }catch(Exception e2){     
		          }  
		        }
		      }     
		   }
		 %>
		  </table>
		</div>
	</div>

	<div id="div3" class="divtop">
	<%
	String num=" ";
	String dizhi="";
	try{
		num=(String)request.getAttribute("gegu");
		HashMap<String,Object> gegudata=getStockData(num);
		String[] numberdata =(String [])gegudata.get("data");
		dizhi=(String)gegudata.get("adress");
		
		
		double now=Double.parseDouble(numberdata[3]);
		double yesterday=Double.parseDouble(numberdata[2]);
		double price=(now+yesterday)*100000000;
		double count=(now+yesterday)*6000000;
		
		double rate=(now-yesterday)/yesterday*100;
		
		 BigDecimal d=new BigDecimal(rate);
         double  rate2=d.setScale(2, BigDecimal.ROUND_UP).doubleValue();
         
   
         StringBuffer sBuffer = new StringBuffer();
       //时分秒
       Calendar cal = Calendar.getInstance();
       int hour = cal.get(Calendar.HOUR_OF_DAY);
       int minute = cal.get(Calendar.MINUTE);
       int second = cal.get(Calendar.SECOND);
       int YY = cal.get(Calendar.YEAR) ;
       int MM = cal.get(Calendar.MONTH)+1;
       int DD = cal.get(Calendar.DATE);
   
        
         %>
         <table id="small_1">
         <tr>
             <td></td>
             <td class="product"><%=numberdata[0] %></td>  
             <td class="in"><%=numberdata[3] %></td>   
          </tr>  
          </table> 
          
           <table id="small_2">
            <tr>
              <td>股票代码</td>
              <td><%=num %></td>
          </tr> 
          
           <tr>
              <td>涨贴幅度</td>
              <td><%=rate2 %></td>
          </tr> 
           <tr>
              <td>交易金额</td>
              <td><%=price%></td>
          </tr> 
           <tr>
              <td>交易量</td>
              <td><%=count %></td>
          </tr> 
           <tr>
              <td>记录时间</td>
              <td><%=hour+":"+minute+":"+second %></td>
          </tr> 
           <tr>
              <td>记录日期</td>
              <td><%=YY+":"+MM+":"+DD %></td>
          </tr> 
          
           
          </table>
          
          
	 <%
	}catch(Exception e){
			
	    }
		
	%>
	
	</div>
	<div id="div4" class="divtop">
	<div id="showlist">
	<iframe id="mainIframe" name="mainIframe" src="http://so.hexun.com/" frameborder="0" scrolling="yes" width="100%" ></iframe>
	</div>
	</div>
	
	<div id="div5" class="divbottom">
		<div class="kimage">
		      <table id="small_3">
             <%
	    String numb=" ";
	    String adr="";
	    try{
		numb=(String)request.getAttribute("gegu");
		HashMap<String,Object> gegudata1=getStockData(numb);
		String[] numberdata1 =(String [])gegudata1.get("data");
		adr=(String)gegudata1.get("adress");
		  StringBuffer sBuffer = new StringBuffer();
	       //时分秒
	       Calendar cal = Calendar.getInstance();
	       int hour = cal.get(Calendar.HOUR_OF_DAY);
	       int minute = cal.get(Calendar.MINUTE);
	       int second = cal.get(Calendar.SECOND);
	       int YY = cal.get(Calendar.YEAR) ;
	       int MM = cal.get(Calendar.MONTH)+1;
	       int DD = cal.get(Calendar.DATE);
		%>
            <tr class="data_query">
            <td><%=num %></td>
            <td ><%=numberdata1[0] %></td>              
              <td><%=YY+":"+MM+":"+DD+":"+hour+":"+minute+":"+second %></td>
          </tr>
          </table>
          <table id="small_4">
          <tr>
             <li> <img src="http://image.sinajs.cn/newchart/min/n/sh000001.gif " />    </li>
          </tr>   
          </table>
                  
	 <%
	}catch(Exception e){
			
	    }
		
	%>  
		
		</div>
		<div class="ktitle">日K线</div>
		
	</div>
	
	<div id="div6" class="divbottom">
		<div class="kimage">
		  <table id="small_3">
             <%
	    String num1=" ";
	    String adr1="";
	    try{
		num1=(String)request.getAttribute("gegu");
		HashMap<String,Object> gegudata2=getStockData(num1);
		String[] numberdata2 =(String [])gegudata2.get("data");
		adr1=(String)gegudata2.get("adress");
		  StringBuffer sBuffer = new StringBuffer();
	       //时分秒
	       Calendar cal = Calendar.getInstance();
	       int hour = cal.get(Calendar.HOUR_OF_DAY);
	       int minute = cal.get(Calendar.MINUTE);
	       int second = cal.get(Calendar.SECOND);
	       int YY = cal.get(Calendar.YEAR) ;
	       int MM = cal.get(Calendar.MONTH)+1;
	       int DD = cal.get(Calendar.DATE);
		%>
            <tr class="data_query">
            <td><%=num %></td>
            <td ><%=numberdata2[0] %></td>              
              <td><%=YY+":"+MM+":"+DD+":"+hour+":"+minute+":"+second %></td>
          </tr>
          </table>
          <table id="small_4">
          <tr>
             <li> <img src="http://image.sinajs.cn/newchart/daily/n/sh601006.gif" />    </li>
          </tr>   
          </table>
                  
	 <%
	}catch(Exception e){
			
	    }
		
	%>  
		
		</div>
		<div class="ktitle">分时线</div>
	</div>
	<div id="div7" class="divbottom">
		<div class="kimage">
		  <table id="small_3">
             <%
             String num2=" ";
     	    String adr2="";
	    try{
		num2=(String)request.getAttribute("gegu");
		HashMap<String,Object> gegudata3=getStockData(num2);
		String[] numberdata3 =(String [])gegudata3.get("data");
		adr2=(String)gegudata3.get("adress");
		  StringBuffer sBuffer = new StringBuffer();
	       //时分秒
	       Calendar cal = Calendar.getInstance();
	       int hour = cal.get(Calendar.HOUR_OF_DAY);
	       int minute = cal.get(Calendar.MINUTE);
	       int second = cal.get(Calendar.SECOND);
	       int YY = cal.get(Calendar.YEAR) ;
	       int MM = cal.get(Calendar.MONTH)+1;
	       int DD = cal.get(Calendar.DATE);
		%>
            <tr class="data_query">
            <td><%=num %></td>
            <td ><%=numberdata3[0] %></td>              
              <td><%=YY+":"+MM+":"+DD+":"+hour+":"+minute+":"+second %></td>
          </tr>
          </table>
          <table id="small_4">
          <tr>
             <li> <img src="http://image.sinajs.cn/newchart/weekly/n/sh000001.gif " />    </li>
          </tr>   
          </table>
                  
	 <%
	}catch(Exception e){
			
	    }
		
	%>  
		
		</div>
		<div class="ktitle">周K线</div>
	</div>
	
	<div id="div8" class="divbottom">
		<div class="kimage">
		  <table id="small_3">
             <%
             String num3=" ";
      	    String adr3="";
	    try{
		num3=(String)request.getAttribute("gegu");
		HashMap<String,Object> gegudata4=getStockData(num2);
		String[] numberdata4 =(String [])gegudata4.get("data");
		adr=(String)gegudata4.get("adress");
		  StringBuffer sBuffer = new StringBuffer();
	       //时分秒
	       Calendar cal = Calendar.getInstance();
	       int hour = cal.get(Calendar.HOUR_OF_DAY);
	       int minute = cal.get(Calendar.MINUTE);
	       int second = cal.get(Calendar.SECOND);
	       int YY = cal.get(Calendar.YEAR) ;
	       int MM = cal.get(Calendar.MONTH)+1;
	       int DD = cal.get(Calendar.DATE);
		%>
            <tr class="data_query">
            <td><%=num %></td>
            <td ><%=numberdata4[0] %></td>              
              <td><%=YY+":"+MM+":"+DD+":"+hour+":"+minute+":"+second %></td>
          </tr>
          </table>
          <table id="small_4">
          <tr>
             <li> <img src="http://image.sinajs.cn/newchart/monthly/n/sh000001.gif " />    </li>
          </tr>   
          </table>
                  
	 <%
	}catch(Exception e){
			
	    }
		
	%>  
		
		</div>
		<div class="ktitle">月K线</div>
	</div>
	
	<div id="div9" >
		<table id="table_main">
		<tr ><td id="td_main" class="td_main"><a href="http://localhost:8080/hubo/gegu.do?number=600506">首页</a></td><td>设置</td><td><a href=" http://quote.eastmoney.com/us/TY.html?from=BaiduAladdin ">TY预测</a></td><td><a href="http://www.jx216.com/newsview/4605vv1.html">AI预测</a></td></tr>
		</table>
	</div>
	<div id="div10"> 
	  <table>
	  <%
           StringBuffer sBuffer = new StringBuffer();
	       //时分秒
	       Calendar cal = Calendar.getInstance();
	       int hour = cal.get(Calendar.HOUR_OF_DAY);
	       int minute = cal.get(Calendar.MINUTE);
	       int second = cal.get(Calendar.SECOND);
	       int YY = cal.get(Calendar.YEAR) ;
	       int MM = cal.get(Calendar.MONTH)+1;
	       int DD = cal.get(Calendar.DATE);
		%>
            <tr class="date_time">
            <td></td>
             <td><%=YY+":"+MM+":"+DD+":"+hour+":"+minute+":"+second %></td>
      
          </tr>    
          </table>
	</div>

	
	
	
	
	
	
</body>
</html>