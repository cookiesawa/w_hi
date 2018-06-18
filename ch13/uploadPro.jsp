<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.io.File"
    import="java.util.*"
    import="org.apache.commons.fileupload.servlet.ServletFileUpload"
    import="org.apache.commons.fileupload.FileItem"
    import="org.apache.commons.fileupload.disk.DiskFileItem"
    import="org.apache.commons.fileupload.disk.DiskFileItemFactory"
%><%

// 파일업로드 로직 작성
// FileUpload 요청인지 체크
boolean isMultipart = ServletFileUpload.isMultipartContent(request);
if(isMultipart == false) {
   return;
}

// Disk 기반 파일 아이템 처리 Factory 생성
DiskFileItemFactory factory = new DiskFileItemFactory();

// 업로드된 파일을 저장할 서버 경로를 얻음(실제 사용시 변경 필요)
File repository = (File) application.getAttribute("javax.servlet.context.tempdir");
factory.setRepository(repository);

// FileUpload를 처리할 핸들러 생성
ServletFileUpload upload = new ServletFileUpload(factory);

// Form Parameter 처리를 위해 Map 생성
Map<String, String> param = new HashMap<String, String>();

String result = "업로드된 파일이 없습니다.";
String fileName = null;

// Multipart 처리
List<FileItem> items = upload.parseRequest(request);
for(FileItem item : items){
   if(item.isFormField()){
      // form field
      String name = item.getFieldName();
      String value = item.getString();
      param.put(name, value);
   } else{
      // Process a file upload
      // 브라우저에서 전송한 원본 파일명(브라우저 설정에 따라 전체 경로가 포함될 수도 있음)
      fileName = new File(item.getName()).getName();
      File uploadedFile = new File(repository, fileName);
      item.write(uploadedFile);
      result = fileName + "이 업로드 되었습니다.";
      System.out.println(uploadedFile.getAbsolutePath()); // 어떤 경로인지 알기 위해?
   }
}
%>
<%-- 결과 출력 로직 작성 --%>
<%= result %>[
<a href="download.jsp?fileName=<%= java.net.URLEncoder.encode(fileName, "utf-8") %>">
download</a>
]
