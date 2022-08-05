
<%@page import="java.sql.*"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <%

    request.setCharacterEncoding("utf-8");
    String d_title =request.getParameter("d_title");
    String d_content =request.getParameter("d_content");
    String u_id =request.getParameter("uid");
  

    String url_mysql = "jdbc:mysql://localhost/musik?serverTimezone=UTC&characterEncoding=utf8&useSSL=FALSE";
    String id_mysql="root";
    String pw_mysql="qwer1234";

    PreparedStatement ps =null;

    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn_mysql = DriverManager.getConnection(url_mysql, id_mysql, pw_mysql);
        Statement stmt_mysql = conn_mysql.createStatement();

        String act1 ="insert into diary (d_date, d_title, d_content, d_emoji, u_id";
        String act2=") values (now(),?,?,?,?)";

        ps=conn_mysql.prepareStatement(act1+act2);
        ps.setString(1,d_title);
        ps.setString(2,d_content);
        ps.setString(4,d_emoji);
        ps.setString(2,u_id);
    

        ps.executeUpdate();
        conn_mysql.close();
%>
       {"result":"OK"}
<%
    }catch(Exception e){
        %>
        {"result":"ERROR"}
<%
    }
    %>