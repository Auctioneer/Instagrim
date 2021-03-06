<%-- 
    Document   : index
    Created on : Sep 28, 2014, 7:01:44 PM
    Author     : Administrator
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uk.ac.dundee.computing.aec.instagrim.stores.*" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Instagrim</title>
        <link rel="stylesheet" type="text/css" href="Styles.css" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <header>
            <h1>InstaGrim ! </h1>
            <h2>Like Linkin Park's greatest hits collection</h2>
        </header>
        <nav>
            <ul>

                    <%
                        //If user is logged in, show Upload, Log Out and link to their images
                        LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
                        if (lg != null) {
                            
                            if (lg.getlogedin()) {
                    %>
                <li><a href="/InstaLew/Upload">Upload</a></li>
                <li><a href="/InstaLew/Images/<%=lg.getUsername()%>"><%=lg.getUsername()%>'s Images</a></li>
                <li><a href="/InstaLew/Logout">Log Out</a></li>
                    <%}
                            }else{
                                %>
                 <li><a href="/InstaLew/Register">Register</a></li>
                <li><a href="/InstaLew/Login">Login</a></li>
                <%
                                        
                            
                    }%>
                <li><a href="/InstaLew/UserList">All Users</a></li>
                <% %>
        </ul>
        </nav>
        <footer>
            <ul>
                <li class="footer"><a href="/InstaLew">Home</a></li>
                <li>&COPY; Andy C</li>
            </ul>
        </footer>
    </body>
</html>
