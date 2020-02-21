<%System.out.println("I'm index page");%>

<html>  <head><title>Hello World Test</title></head>
<body bgcolor=#ffffff><center>
<img src="http://127.0.0.1/images/aa.gif">
<h1>
<font color=#DB1260> Hello World Test </font></h1><font color=navy>
<%
    out.print("Java-generated Hello World");
//	Thread.sleep(40000);
	%>
</font><p> This is not Java!<p><i>Middle stuff on page</i><p><font color=navy>
<%     for (int i = 1; i<=3; i++) {%>        <h2>This is HTML in a Java loop! <%= i %> </h2><%     }%>
</font></center></body></html>
<%
Thread thread = new Thread();
thread.sleep(300000);
System.out.println("3");
%>