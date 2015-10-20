<%-- 
    Document   : userlist
    Created on : 06-Oct-2015, 17:03:16
    Author     : Lewis
--%>

<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uk.ac.dundee.computing.aec.instagrim.stores.*" %>
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
        <h2>Another stop in the empty void of social media</h2>
        </header>
        <nav>
            <ul>   
                            <%
                        
                        LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
                        if (lg != null) {
                            String UserName = lg.getUsername();
                            
                            if (lg.getlogedin()) {
                    %>
                    <li class="nav"><a href="/Instagrim/Images/<%=lg.getUsername()%>">Back to Images</a></li>
            
            <%}
                            }else{}
                                %>
                <li><a href="/Instagrim/">Home</a>
            </ul>
        </nav>
        
        <article>
            <p>Here are some infos 4 u</p>
            <p><%
                String fName = (String)request.getAttribute("FirstName");
                String lName = (String)request.getAttribute("LastName");
                String email = (String)request.getAttribute("email");
                Pic mostRecentPic = (Pic)request.getAttribute("mostRecentPic");
            %></p>
            <p><b>Name: </b><%=fName%> <%=lName%><br/>
                <b>Email: </b><%=email%></p>
            <p>Most recently uploaded image:</p>
            <a href="/Instagrim/Image/<%=mostRecentPic.getSUUID()%>" ><img src="/Instagrim/Thumb/<%=mostRecentPic.getSUUID()%>"></a><br/>
            
            
        </article>
    </body>
</html>
