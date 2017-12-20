<%
/*
 *  Program Type : JSP
 *  Program ID   : monitoring.jsp
 *
 *  DESC         :
 *  Author       :
 *  Date         :
 */
%>

<%@ page language="java" %>
<%@ page import="import java.util.*"%>
<%@ page import="import javax.naming.*"%>
<%@ page import="import javax.jms.*"%>
<%@ page import="import weblogic.management.MBeanHome"%>
<%@ page import="import weblogic.management.RemoteMBeanServer"%>
<%@ page import="import weblogic.management.Helper"%>
<%@ page import="import weblogic.management.runtime.*"%>

<%!
	    public static MBeanHome home;
	    public static int preThoughput;
%>

<%
JVMRuntimeMBean jvmBean;
ExecuteQueueRuntimeMBean exeBean;
ServerRuntimeMBean serverBean;

int precount=0;

String wlsuser   ="weblogic";
String wlspwd    ="weblogic";
String wlsip     ="localhost";
String wlsport   ="7001";
String serverName="myserver";
String queue     ="weblogic.kernel.Default";

int useM=0 ;
int totM=0 ;
int idleT= 0;
int totT=0;
int thoughput = 0;
int refreshtime = 15;

	try{
	    MBeanHome mbh                = Helper.getMBeanHome(wlsuser, wlspwd, "t3://"+wlsip+":"+wlsport, serverName);
	    RemoteMBeanServer homeServer = (RemoteMBeanServer)mbh.getMBeanServer();
	    
	    if(home == null){
	       home               = (MBeanHome)homeServer.getMBeanHome();
	    }

	    jvmBean    = (JVMRuntimeMBean) home.getRuntimeMBean(serverName, "JVMRuntime");
	    exeBean    = (ExecuteQueueRuntimeMBean) home.getRuntimeMBean(queue, "ExecuteQueueRuntime");
	    serverBean = (ServerRuntimeMBean) home.getRuntimeMBean(serverName, "ServerRuntime");

	    totM  = (int)(jvmBean.getHeapSizeCurrent()/1024/1024 );
	    useM  = ((int)(jvmBean.getHeapSizeCurrent())-(int)(jvmBean.getHeapFreeCurrent()))/1024/1024 ;
	    idleT = exeBean.getExecuteThreadCurrentIdleCount();
	    totT = exeBean.getExecuteThreadTotalCount() ;
	    thoughput = ( exeBean.getServicedRequestTotalCount() - preThoughput)/refreshtime;
		preThoughput = exeBean.getServicedRequestTotalCount();

	} catch (javax.management.InstanceNotFoundException ne) {
	        System.out.println(ne.getMessage());
	} catch (Exception e) {
	  e.printStackTrace();

	}
	

%>
<HTML>
<HEAD>
</HEAD>
<% if( idleT > 0) { %>
<BODY bgcolor="#ccffcc" >
	<FORM name="weblogic" >
	<font face="58?r"><span style="font-size:10pt;">
	<input type="hidden" name="ok" value="Y">
	Server Name: <%= serverName%><br>
	Memory(use/tot):<%= useM %>(M)/<%= totM %>(M)<br>
	Idle Thread / total Thread :<b><%= idleT %>/<%=totT%></b><br>
	Thorouhput :<b><%=thoughput %></b><br>
	</span></font>
	</form>
<%} else { %>
<BODY bgcolor="#cccccc" >
	<FORM name="weblogic" >
	<font face="58?r"><span style="font-size:10pt;">
	<input type="hidden" name="ok" value="Y">
	Server Name: <%= serverName%><br>
	Memory(use/tot):<%= useM %>(M)/<%= totM %>(M)<br>
	Idle Thread / total Thread :<b><%= idleT %>/<%=totT%></b><br>
	Thorouhput :<b><%=thoughput %></b><br>
	</span></font>
	</form>
<% }
%>
</body>
</HTML>




