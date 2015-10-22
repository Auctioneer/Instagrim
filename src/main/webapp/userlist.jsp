<%-- 
    Document   : register.jsp
    Created on : Sep 28, 2014, 6:29:51 PM
    Author     : Administrator
--%>

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
        <nav>
            <ul>
                
                <li><a href="/Instagrim/Images/majed">Sample Images</a></li>
            </ul>
        </nav>
       
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
        <a href="/Instagrim/Profile/<%=s%>" ><%=s%></a><br/>
        <!--Date added goes here -->
        <%

            }
            }
        %>
        </article>
        <footer>
            <ul>
                <li class="footer"><a href="/Instagrim">Home</a></li>
            </ul>
        </footer>
    </body>
</html>
