<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.io.*"
%><%
// 서버에 업로드된 파일의 경로를 얻음(실제 사용시 변경 필요)
File repository = (File) application.getAttribute("javax.servlet.context.tempdir");

String fileName = request.getParameter("fileName");

File file = new File(repository, fileName);
if(file.exists()) {

	// 파일 다운로드 로직 작성
	// Content-Type 설정
	response.setContentType("application/octet-stream");
	// Content-Disposition 설정
	response.setHeader("Content-Disposition", String.format("attachment; filename=\"%s\"", file.getName()));

	FileInputStream inputStream = null;
	OutputStream outStream = null;
	try {
	    // 파일을 전송할 OutputStream 생성
	    outStream = response.getOutputStream();
	    // 다운로드할 파일의 InputStream 생성
	    inputStream = new FileInputStream(file);
	    byte[] buffer = new byte[1024];

	    // 파일내용 전송
	    for(int len = -1; (len = inputStream.read(buffer)) != -1;) {
	        outStream.write(buffer, 0, len);
	    }
	    outStream.flush();
	} catch(IOException ioe) {
	    ioe.printStackTrace();
	} finally {
	    if(inputStream != null) {inputStream.close();}
	    if(outStream != null) {outStream.close();}
	}

} else {
	response.sendError(404, fileName + " is not found.");
}
%>