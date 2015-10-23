<%-- 
    Document   : register.jsp
    Created on : Sep 28, 2014, 6:29:51 PM
    Author     : Administrator
--%>

<%@page import="uk.ac.dundee.computing.aec.instagrim.stores.LoggedIn"%>
<%@page import="java.util.Iterator"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Instagrim</title>
        <link rel="stylesheet" type="text/css" href="Styles.css" />
    </head>
    <body>
        <header>
        <h1>InstaGrim ! </h1>
        <h2>Wishing I'd studied Psychology</h2>
        </header>
       
        <article>
              <%  //Get linked lists of pictures and dates
            java.util.LinkedList<String> userList = (java.util.LinkedList<String>) request.getAttribute("users");

            if (userList == null) {
        %>
        <p>No Pictures found</p>
        <%
        } else {
            Iterator<String> iterator;

            iterator = userList.iterator();

            while (iterator.hasNext()) {
                String s = (String) iterator.next();

        %>
        <a href="/Instagrim/Profile/<%=s%>" ><%=s%>'s Profile</a> - <a href="/Instagrim/Images/<%=s%>" ><%=s%>'s Images<br/>
        <%

            }
            }
        %>
        </article>
        <footer>
            <ul><%
                        
                        LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
                        if (lg != null) {
                            
                            if (lg.getlogedin()) {

                    %>
                    <li class="nav"><a href="/Instagrim/Profile/<%=lg.getUsername()%>">Profile</a></li>
                    <li class="nav"><a href="/Instagrim/UserList">All Users</a></li>
                    <li class="nav"><a href="/Instagrim/Upload">Upload</a></li>
            <% } }else {} %>
                <li class="footer"><a href="/Instagrim">Home</a></li>
            </ul>
        </footer>
    </body>
</html>
