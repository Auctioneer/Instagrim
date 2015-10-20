/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package uk.ac.dundee.computing.aec.instagrim.servlets;

import com.datastax.driver.core.Cluster;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import uk.ac.dundee.computing.aec.instagrim.lib.CassandraHosts;
import uk.ac.dundee.computing.aec.instagrim.models.User;

/**
 *
 * @author Administrator
 */
@WebServlet(name = "Register", urlPatterns = {"/Register"})
public class Register extends HttpServlet {
    Cluster cluster=null;
    public void init(ServletConfig config) throws ServletException {
        // TODO Auto-generated method stub
        cluster = CassandraHosts.getCluster();
    }

    
//Love me some RESTful interface
@Override
public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
{
    RequestDispatcher rd = request.getRequestDispatcher("register.jsp");
    rd.forward(request, response);
}
        
        


    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session=request.getSession();
        System.out.println("Session in servlet "+session);
        String username=request.getParameter("username");
        String first_name=request.getParameter("first_name");
        String last_name=request.getParameter("last_name");
        String email=request.getParameter("email");
        
        //For password verification, we'll compare the two passwords
        String password=request.getParameter("password");
        String password2=request.getParameter("password2");
        
        //If user already exists
            User us=new User();
        us.setCluster(cluster);
        
        if (us.isExistingUser(username) == true)
        {
            session.setAttribute("AlreadyExists", "A user with this username already exists. Please select a different one.");
            response.sendRedirect("/Instagrim/register.jsp");
        }
        
        
        //Else compare passwords
        else
        {
        if (password.equals(password2))
        {
        //Emails are stored as a set here
        Set<String> emailSet = new HashSet<String>(Arrays.asList(email));
        //Register the new user
        us.RegisterUser(username, password, first_name, last_name, emailSet);
        
        RequestDispatcher rd = request.getRequestDispatcher("/Login");
        rd.forward(request, response);
        }
        else
        {
            //Else display message that the passwords need to match. A new user should not be created.
            session.setAttribute("NoMatch", "Your passwords did not match. Please try again.");
            response.sendRedirect("/Instagrim/register.jsp");
        }
        }
        
        
	
        
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
