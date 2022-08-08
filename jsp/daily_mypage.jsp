<%@page import="java.sql.*"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <%
    request.setCharacterEncoding("utf-8");
    String u_nickname = request.getParameter("u_nickname");
    String u_email = request.getParameter("u_email");
    String u_pw = request.getParameter("u_pw");

    String url_mysql = "jdbc:mysql://localhost/musik?serverTimezone=UTC&characterEncoding=utf8&useSSL=FALSE";
    String id_mysql = "root";
    String pw_mysql = "qwer1234";

    PreparedStatement ps = null;

    JSONObject jsonList = new JSONObject();
    JSONArray itemList = new JSONArray();

    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn_mysql = DriverManager.getConnection(url_mysql, id_mysql, pw_mysql);
        Statement stmt_mysql = conn_mysql.createStatement();
    
    
        String whereDefault = "select user from buser where u_nickname = ? and u_email = ? and u_pw = ? ";

        ps = conn_mysql.prepareStatement(whereDefault);
        ps.setString(1, u_nickname);
        ps.setString(2, u_email);
        ps.setString(3, u_pw);

        ResultSet rs = ps.executeQuery();

        if(rs.next()){
            JSONObject tempJson = new JSONObject();
            tempJson.put("buid", rs.getString(1));
            itemList.add(tempJson);
        }else{
            itemList.add("ERROR");
        }
        jsonList.put("results",itemList);
        conn_mysql.close();
        out.print(jsonList);

        }catch(Exception e){

            e.printStackTrace();
        }
        %>