<%@page import="java.sql.*"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <%
    int pages = Integer.parseInt(request.getParameter("page"));

    int offset2 = (pages+1) * 10;

    request.setCharacterEncoding("utf-8");
    String emotion = request.getParameter("emotion");

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
    
    
        String whereDefault = "select m_id, m_singer, m_title, m_lycrics, m_image, m_link, m_date from music where m_emotion = ? LIMIT 10 OFFSET ?";

        ps = conn_mysql.prepareStatement(whereDefault);
        ps.setString(1, emotion);
        ps.setInt(2, offset2);

        ResultSet rs = ps.executeQuery();

        while(rs.next()){
            JSONObject tempJson = new JSONObject();
            tempJson.put("m_id", rs.getString(1));
            tempJson.put("m_singer", rs.getString(2));
            tempJson.put("m_title", rs.getString(3));
            tempJson.put("m_lycrics", rs.getString(4));
            tempJson.put("m_image", rs.getString(5));
            tempJson.put("m_link", rs.getString(6));
            tempJson.put("m_date", rs.getString(7));
            itemList.add(tempJson);
        }
        jsonList.put("results",itemList);
        conn_mysql.close();
        out.print(jsonList);

        }catch(Exception e){

            e.printStackTrace();
        }
        %>