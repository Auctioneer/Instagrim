<%-- 
    Document   : upload
    Created on : Sep 22, 2014, 6:31:50 PM
    Author     : Administrator
--%>

<%@page import="uk.ac.dundee.computing.aec.instagrim.stores.LoggedIn"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Instagrim</title>
        <link rel="stylesheet" type="text/css" href="Styles.css" />
    </head>
    <body>
        <h1>InstaGrim ! </h1>
        <h2>Don'tcha wish your servlets were hot like me</h2>
        <nav>
            <ul>

                <li class="nav"><a href="/InstaLew/UserList">All Users</a></li>

                <%
                        //If user is logged in, show profile, image page and log out
                        LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
                        if (lg != null) {
                            
                            if (lg.getlogedin()) {

                    %>
                <li class="nav"><a href="/InstaLew/Profile/<%=lg.getUsername()%>">Profile</a></li>
                <li><a href="/InstaLew/Images/<%=lg.getUsername()%>"><%=lg.getUsername()%>'s Images</a></li>
                <li><a href="/InstaLew/Logout">Log Out</a></li>
                <% } } %>
            </ul>
        </nav>
 
        <article>
            <h3>File Upload</h3>
            <form method="POST" enctype="multipart/form-data" action="Image">
                File to upload: <input type="file" name="upfile"><br/>

                <br/>
                
                <!--Radio buttons to select between two filters-->
                <input type="radio" name="filter" id="filterBlackWhite" value="blackWhite" checked>Filter 1: Black and White<br/>
                <input type="radio" name="filter" id="filterColour1" value="colour1">Filter 2: Colourful and Pretty<br/>
                
                <input type="submit" value="Press"> to upload the file!
            </form>

        </article>
        <footer>
            <ul>
                <li class="footer"><a href="/InstaLew">Home</a></li>
            </ul>
        </footer>
    </body>
</html>
