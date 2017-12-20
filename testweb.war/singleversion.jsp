<%@ page contentType="text/html;charset=euc-kr" pageEncoding="euc-kr"%>
<%@ page import="java.sql.*, javax.naming.*, javax.sql.*"%>
<head><title>Single Version Test Page</title></head>
<body>
<%
Context initCtx = new InitialContext();
DataSource ds = (DataSource)initCtx.lookup("altibase");
Connection sCon = ds.getConnection();
Statement sStmt = sCon.createStatement();
String query = "select '" +
"<b>DB name: </b>'||trim(db_name)||'<br>" +
"<b>version: </b>'||trim(product_signature)||'<br>" +
"<b>Current Time: </b>'"+
"||to_char(sysdate,'yyyy/mm/dd hh24:mi:ss')||'<hr>'" +
" from v$database;";
ResultSet sRes = sStmt.executeQuery(query);
sRes.next();
out.println("<font size=4><b>ALTIBASE Connection Info</b></font><p>");
out.println(sRes.getString(1));
sRes.close();
sStmt.close();
sCon.close();
%>
</body>
</html>