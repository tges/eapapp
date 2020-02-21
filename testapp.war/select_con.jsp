<%@ page contentType="text/html; charset=euc-kr" %>

<%-- Parameter로 넘어온 값정의      --%>
<%
    String command       = request.getParameter("command").trim();
    String jdbc_select = "";
    String pool_select = "";
    String ds_select = "";
    

    if(command.equals("pool"))
    {
      pool_select = "selected";
    }
    else if(command.equals("ds"))
    {
      ds_select = "selected";
    }
    else if(command.equals("jdbc") )
    {
      jdbc_select = "selected";
      command = "jdbc";
    }
%>

<HTML>
<HEAD>
<script language='javascript'>

function funcLocation( )
{
  var form = document.test;
  form.method = "post";
  form.target = "lst_frame";
  form.action = "./select_lst.jsp";
  form.submit();
  
}

function funcCon( )
{
  var form = document.test;
  form.method = "post";
  form.target = "con_frame";
  form.action = "./select_con.jsp";
  form.submit();
  
}


</SCRIPT>
</HEAD>
<BODY>
<FORM method="post"  name="test" >
<TABLE width="800" cellpadding="1" cellspacing="1" border=0 style="border:solid 1px #E6E6E9">
	<tr><td colspan=2> >> JSP를이용한 DB연동 조회 
	<TR>
		<TD align="left" >조회 방법</TD>
		<TD >
			<SELECT name="command" onChange="funcCon()">
			<OPTION value="jdbc" <%=jdbc_select%> >USING DIRECT JDBC CONNECTION</option>
			<OPTION value="pool" <%=pool_select%> >USING WEBLOGIC CONNECTION POOL</option>
			<OPTION value="ds"   <%=ds_select%> >USING WEBLOGIC DATA SOURCE</option>
			</SELECT>
         <A HREF="javascript:funcLocation();">조 회</a>
         </TD>
	</TR>
</TABLE>
<Table  width="800" cellpadding="1" cellspacing="1" border=0 style="border:solid 1px #E6E6E9">
<% if( command.equals("jdbc") ){ %>
<tr>
<td>IP</td>
<td><INPUT type="text" name="ip" size="20"></td>
<td rowspan=5><TEXTAREA NAME='query' ROWS=8 COLS=90 WRAP=VIRTUAL></TEXTAREA></td>
</tr>
<tr>
<td>Port</td>
<td><INPUT type="text" name="port" size="20"></td>
</tr>
<tr>
<td>SID</td>
<td><INPUT type="text" name="sid" size="20"></td>
</tr>
<tr>
<td>User Name</td>
<td><INPUT type="text" name="username" size="20"></td>
</tr>
<tr>
<td>PassWord</td>
<td><INPUT type="text" name="password" size="20"></td>
</tr>
<% }else if( command.equals("pool") ){ %>
<tr>
<td>Connection Pool</td>
<td><INPUT type="text" name="poolname" size="20"></td>
</tr>
<tr>
<td colspan=2><TEXTAREA NAME='query' ROWS=8 COLS=90 WRAP=VIRTUAL></TEXTAREA></td>
</tr>
<% }else if( command.equals("ds") ){ %>
<tr>
<td>Data Source</td>
<td><INPUT type="text" name="dsname" size="20"></td>
</tr>
<tr>
<td colspan=2><TEXTAREA NAME='query' ROWS=8 COLS=90 WRAP=VIRTUAL></TEXTAREA></td>
</tr>

<% }else{ %>
선택 조건이 올바르지 않습니다.
<% }%>
</table>
</FORM>
</BODY>
</HTML>