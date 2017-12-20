<%@ page contentType="text/html;charset=EUC-KR"%>
<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
</HEAD>
<BODY>
<a href="sessioncheck.jsp"> Click Here </a><br>
<br>
thank you<br>

</BODY>
</HTML>
<%
session.setAttribute("ID","sanghunji");
%>
<br>
<%
out.println(session.getAttribute("ID"));
System.out.println("init session value() : "+session.getAttribute("ID"));
%>
<br>
<%="지상헌"%>
<%
if (request.getParameter("pram") != null){
String pram = request.getParameter("pram");
%>
<br>파람은 <%=pram%>
<%
}
%>