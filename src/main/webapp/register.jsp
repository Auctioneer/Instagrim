<%-- 
    Document   : register.jsp
    Created on : Sep 28, 2014, 6:29:51 PM
    Author     : Administrator
--%>

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
        <h2>Hardly my greatest work</h2>
        </header>
        <nav>
            <ul>
                
                <li><a href="/Instagrim/Images/majed">Sample Images</a></li>
            </ul>
        </nav>
       
        <article>
            <h3>Register as user</h3>
            <p>Passwords must contain five or more characters, with at least one number, upper case and lower case character. </p>
            <form method="POST"  action="Register">
                <ul>
                    <li>User Name <input type="text" required pattern="\w+" name="username"></li>
                    <li>First Name <input type="text" required pattern="\w+" name="first_name"></li>
                    <li>Last Name <input type="text" required pattern="\w+" name="last_name"></li>
                    <li>E-mail Address <input type="text" required pattern="\w+" name="email"</li>
                    <li>Password <input type="password" required pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{5,}" name="password" onchange="form.pwd2.pattern = this.value;"></li>
                    <li>Re-enter password <input type="password" name="password2"></li>
                </ul>
                <br/>
                <input type="submit" value="Register"> 
            </form>

        </article>
        <footer>
            <ul>
                <li class="footer"><a href="/Instagrim">Home</a></li>
            </ul>
        </footer>
    </body>
</html>
