<%@page import="java.sql.*"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <%
    request.setCharacterEncoding("utf-8");
    String uId = request.getParameter("uid");

    String url_mysql = "jdbc:mysql://localhost/musik?serverTimezone=UTC&characterEncoding=utf8&useSSL=FALSE";
    String id_mysql="root";
    String pw_mysql="qwer1234";

    String whereDefault ="select d_id, d_date, d_title, d_content, d_emoji, u_id from diary where u_id = '" + uId + "' order by d_date desc";

    JSONObject jsonList = new JSONObject();
    JSONArray itemList = new JSONArray();

    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn_mysql = DriverManager.getConnection(url_mysql, id_mysql, pw_mysql);
        Statement stmt_mysql = conn_mysql.createStatement();




        ResultSet rs = stmt_mysql.executeQuery(whereDefault);

        while(rs.next()){
            JSONObject tempJson = new JSONObject();
            tempJson.put("d_id", rs.getInt(1));
            tempJson.put("d_date", rs.getString(2));
            tempJson.put("d_title", rs.getString(3));
            tempJson.put("d_content", rs.getString(4));
            tempJson.put("d_emoji", rs.getString(5));
            tempJson.put("u_id", rs.getString(6));
            itemList.add(tempJson);
            
        }
        jsonList.put("results", itemList);
        conn_mysql.close();
        out.print(jsonList);
    } catch(Exception e){
        e.printStackTrace();

    }
    %>