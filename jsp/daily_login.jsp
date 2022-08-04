<%@page import="java.sql.*"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <%
    request.setCharacterEncoding("utf-8");
    String u_id = request.getParameter("uid");
    String u_pw = request.getParameter("upw");

    String url_mysql = "jdbc:mysql://localhost/musik?serverTimezone=UTC&characterEncoding=utf8&useSSL=FALSE";
    String id_mysql="root";
    String pw_mysql="qwer1234";

    PreparedStatement ps = null;

    
    JSONObject jsonList = new JSONObject();
    JSONArray itemList = new JSONArray();

    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn_mysql = DriverManager.getConnection(url_mysql, id_mysql, pw_mysql);
        Statement stmt_mysql = conn_mysql.createStatement();

        String whereDefault ="select u_id , u_pw , u_nickname from user where u_id = ? and u_pw = ? ";

        ps = conn_mysql.prepareStatement(whereDefault);
        ps.setString(1, u_id);
        ps.setString(2, u_pw);

        ResultSet rs = ps.executeQuery();

        if(rs.next()){
            JSONObject tempJson = new JSONObject();
            tempJson.put("u_id", rs.getString(1));
            tempJson.put("u_pw", rs.getString(2));
            tempJson.put("u_nickname", rs.getString(3));
            itemList.add(tempJson);
            
        }else{
            itemList.add("ERROR");
        }
        jsonList.put("results", itemList);
        conn_mysql.close();
        out.print(jsonList);

    }catch(Exception e){

        e.printStackTrace();

    }
    %>