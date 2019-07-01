<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="javax.naming.InitialContext" %>
<%-- Parameter로 넘어온 값정의      --%>
<%
    String command    = request.getParameter("command").trim();
    String query      = request.getParameter("query").trim();
    String ip         = "";
    String port       = "";
    String sid        = "";
    String username   = "";
    String password   = "";
    String poolname   = ""; 
    String dsname     = ""; 
   
    Connection        conn  = null;
    PreparedStatement pstmt = null;
    
    try{
	    ResultSet         rs = null;
	    ResultSetMetaData rm = null;
		
		if(command.equals("jdbc") )
		{
		    ip         = request.getParameter("ip").trim();
		    port       = request.getParameter("port").trim();
		    sid        = request.getParameter("sid").trim();
		    username   = request.getParameter("username").trim();
		    password   = request.getParameter("password").trim();
		    
		    conn       = DriverManager.getConnection( "jdbc:oracle:thin:@"+ip+":"+port+":"+sid,username, password);
		}
		else if(command.equals("pool"))
		{
		    poolname   = request.getParameter("poolname").trim();
		    Driver eduDriver = (Driver)Class.forName("weblogic.jdbc.pool.Driver").newInstance();
		
		    Properties props = new Properties();
		    props.put("connectionPoolID", poolname);    
		    conn  = eduDriver.connect("jdbc:weblogic:pool:"+poolname, null);
		    
		}
		else if(command.equals("ds"))
		{
		    dsname     = request.getParameter("dsname").trim();
		    javax.naming.Context ctx = null;
		    ctx = new InitialContext();
		    javax.sql.DataSource ds = (javax.sql.DataSource) ctx.lookup (dsname);
		    conn  = ds.getConnection();
		}
		        
		    pstmt     = conn.prepareStatement(query);
		    rs        = pstmt.executeQuery();
		    rm        = rs.getMetaData();
			int count = rm.getColumnCount();
%>
<HTML>
<HEAD>
<LINK href="/htdocs/common/xjsv.css" rel="stylesheet" type="text/css">
<LINK href="/htdocs/common/sctdstyle.css" rel="stylesheet" type="text/css">
</HEAD>
<BODY>
<FORM method="post"  name="test" >
<table cellpadding="1" cellspacing="1" border=0 style="border:solid 1px #E6E6E9" >
<%
String columnLabel = "";
for( int i = 0 ; i < count ; i++)
{	
	out.println("<td>"+rm.getColumnLabel(i+1)+"</td>");;
}
while (rs.next()) {
out.println("<tr>");
	for( int j = 0 ; j < count ; j++ )
		out.println("<td>"+ rs.getString(j+1)+"</td>");
out.println("</tr>");
 }
  rs.close();
}catch(Exception e)
{ 
 e.printStackTrace();
      out.println("조회 에러 입니다. 아래 내용 확인 하시기 바랍니다.:::<br>"+e.getMessage()+"<br>"+query);
}
finally
{    
      if (pstmt != null) pstmt.close();
      if (conn  != null)  conn.close();
}
%>
</table>
</FORM>
</BODY>
</HTML>