<%-- 
    Document   : UsersPics
    Created on : Sep 24, 2014, 2:52:48 PM
    Author     : Administrator
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="uk.ac.dundee.computing.aec.instagrim.stores.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Instagrim</title>
        <link rel="stylesheet" type="text/css" href="/Instagrim/Styles.css" />
    </head>
    <body>
        <header>
        
        <h1>InstaGrim ! </h1>
        <h2>Cheekier than a Nando's</h2>
        </header>
        
        <nav>
            <ul>
                
                <!--<li class="nav"><a href="/Instagrim/Images/majed">Sample Images</a></li>-->
                <li class="nav"><a href="/Instagrim/UserList">All Users</a></li>
                
 
        <article>
            <%
                        LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
                        if (lg != null) {
                            //String UserName = lg.getUsername();                            
                            
                            if (lg.getlogedin()) {
                    %>
                    <li class="nav"><a href="/Instagrim/Profile/<%=lg.getUsername()%>">Profile</a></li>
                    <li class="nav"><a href="/Instagrim/Upload">Upload</a></li>
                    <li class="nav"><a href="/Instagrim/Logout">Log Out</a></li>
            </ul>
        </nav>
            <!-- Get attributes for first and last name in a linked list of strings -->
            
            <%}
                            }else{}
                                %>
            <h1>${currentUser}'s Images</h1>
        <%  //Get linked lists of pictures and dates
            java.util.LinkedList<Pic> lsPics = (java.util.LinkedList<Pic>) request.getAttribute("Pics");
            java.util.LinkedList<Date> lsDates = (java.util.LinkedList<Date>) request.getAttribute("Dates");

            if (lsPics == null) {
        %>
        <p>No Pictures found</p>
        <%
        } else {
                //Date formatting
                SimpleDateFormat df = new SimpleDateFormat("dd-MM-yy");
                
            //Iterate through the lists of pics and dates
            Iterator<Pic> iterator;
            Iterator<Date> iterator2;
            iterator = lsPics.iterator();
            iterator2 = lsDates.iterator();
            while (iterator.hasNext()) {
                Pic p = (Pic) iterator.next();
                Date d = (Date) iterator2.next();
                String dateToDisplay = df.format(d);


        //Display each one as we go    %>
        <a href="/Instagrim/Image/<%=p.getSUUID()%>" ><img src="/Instagrim/Thumb/<%=p.getSUUID()%>"></a><br/>
        <!--Date added goes here -->
        <p><%=dateToDisplay%></p>
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
