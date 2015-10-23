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
                            
                <li><a href="/Instagrim/">Home</a>
            <%
                String fName = (String)request.getAttribute("FirstName");
                String lName = (String)request.getAttribute("LastName");
                String email = (String)request.getAttribute("email");
                String uName = (String)request.getAttribute("username");
                Pic mostRecentPic = (Pic)request.getAttribute("mostRecentPic");
                
                LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
                        if (lg != null){
                                                        
            %>
            <li class="nav"><a href="/Instagrim/Upload">Upload</a></li>
            <% } else {} %>
                    <li class="nav"><a href="/Instagrim/Images/<%=uName%>">Back to <%=uName%>'s Images</a></li>
            </ul>
        </nav>
        
        <article>
            <p>Here are some infos 4 u</p>

            <p><b>Username: </b><%=uName%><br/>
                <b>Name: </b><%=fName%> <%=lName%><br/>
                <b>Email: </b><%=email%></p>
            <p>Most recently uploaded image:</p>
            <a href="/Instagrim/Image/<%=mostRecentPic.getSUUID()%>" ><img src="/Instagrim/Thumb/<%=mostRecentPic.getSUUID()%>"></a><br/>
            <%
                if (lg != null){    
                    String lgName = lg.getUsername();
             if (lgName.equals(uName)) {      
            %>
            
            <p>Change details here:</p>
            <form method="Post">
                    <li>First Name <input type="text" required pattern="\w+" value="<%=fName%>" name="first_name"></li>
                    <li>Last Name <input type="text" required pattern="\w+" value="<%=lName%>" name="last_name"></li> 
                    <li>E-mail Address <input type="email" required pattern="[^ @]*@[^ @]*" value="<%=email%>" name="email"</li>
            </ul>
                <br/>
                <input type="submit" value="Update Profile"> 
            </form>
            <%}} else {}                       
                                %>
            
        </article>
    </body>
</html>
