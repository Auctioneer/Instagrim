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
              <%  //Get linked list of users
            java.util.LinkedList<String> userList = (java.util.LinkedList<String>) request.getAttribute("users");

            //Display a message if there are no users
            if (userList == null) {
        %>
        <p>No Pictures found</p>
        <%
        } else {
            //Iterate through list of users and display links to their profile and images
            Iterator<String> iterator;

            iterator = userList.iterator();

            while (iterator.hasNext()) {
                String s = (String) iterator.next();

        %>
        <a href="/InstaLew/Profile/<%=s%>" ><%=s%>'s Profile</a> - <a href="/InstaLew/Images/<%=s%>" ><%=s%>'s Images<br/>
        <%

            }
            }
        %>
        </article>
        <footer>
            <ul><%
                        //If user is logged in, display the following links:
                        LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
                        if (lg != null) {
                            
                            if (lg.getlogedin()) {

                    %>
                    <li class="nav"><a href="/InstaLew/Profile/<%=lg.getUsername()%>">Profile</a></li>
                    <li class="nav"><a href="/InstaLew/UserList">All Users</a></li>
                    <li class="nav"><a href="/InstaLew/Upload">Upload</a></li>
                    <li class="nav"><a href="/InstaLew/Logout">Log Out</a></li>
            <% } }else {} %>
                <li class="footer"><a href="/InstaLew">Home</a></li>
            </ul>
        </footer>
    </body>
</html>
