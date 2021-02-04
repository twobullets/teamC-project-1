<%@ page language="java" pageEncoding="EUC-KR"%>
<%@ page import="java.io.*"%>
<%@ page trimDirectiveWhitespaces="true" %>
<% 
response.addHeader("content-type","application/octet-stream; charset=EUC-KR");

String fname = request.getParameter("file");
if(fname == null)
{
	fname = "pup.jpg";
}
fname = fname.replace("..","");
response.setHeader("Content-Disposition", "attachment; filename=\"" + fname + "\""); //Ã·ºÎÆÄÀÏ¸íÀ¸·Î º¸¿©ÁÜ.
try
{
	File mFile = new File("D:\\jsh\\Team\\WebContent\\board\\FileUpload", fname);
	
	InputStream in = null;
	in = new FileInputStream(mFile);
	OutputStream os = null;
	
	os = response.getOutputStream();
	byte b[] = new byte[(int)mFile.length()];
	int leng = 0;
	while((leng = in.read(b)) > 0)
	{
		os.write(b,0,leng);	
	}
	os.close();
	in.close();
}catch(Exception e)
{
	out.print("ERROR");
}
%>