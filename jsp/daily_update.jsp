<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <%

    request.setCharacterEncoding("utf-8");
    String d_content = request.getParameter("dcontent");
    String d_emoji = request.getParameter("demoji");
    String d_id = request.getParameter("d_id");


    String url_mysql = "jdbc:mysql://localhost/musik?serverTimezone=UTC&characterEncoding=utf8&useSSL=FALSE";
    String id_mysql="root";
    String pw_mysql="qwer1234";

    PreparedStatement ps = null;

    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn_mysql = DriverManager.getConnection(url_mysql, id_mysql, pw_mysql);
        Statement stmt_mysql = conn_mysql.createStatement();

        String act1 = "update diary set d_title = ?, d_content = ?, d_emoji= ?";
        String act2 = "where d_id = ?";

        ps = conn_mysql.prepareStatement(act1+act2);
        ps.setString(1, d_title);
        ps.setString(2, d_content);
        ps.setString(3, d_emoji);
        ps.setInt(4, d_id);

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