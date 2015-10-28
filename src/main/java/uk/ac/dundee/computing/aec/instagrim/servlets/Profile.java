/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uk.ac.dundee.computing.aec.instagrim.servlets;

import com.datastax.driver.core.BoundStatement;
import com.datastax.driver.core.Cluster;
import static com.datastax.driver.core.DataType.set;
import com.datastax.driver.core.PreparedStatement;
import com.datastax.driver.core.ResultSet;
import com.datastax.driver.core.Row;
import com.datastax.driver.core.Session;
import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.reflect.Array.set;
import java.util.Arrays;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import java.util.LinkedList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import uk.ac.dundee.computing.aec.instagrim.lib.CassandraHosts;
import uk.ac.dundee.computing.aec.instagrim.lib.Convertors;
import uk.ac.dundee.computing.aec.instagrim.models.PicModel;
import uk.ac.dundee.computing.aec.instagrim.models.User;
import uk.ac.dundee.computing.aec.instagrim.stores.LoggedIn;
import uk.ac.dundee.computing.aec.instagrim.stores.Pic;
import uk.ac.dundee.computing.aec.instagrim.stores.Pic;

/**
 *
 * @author Lewis
 */
@WebServlet(name = "Profile", urlPatterns = {"/Profile","/Profile/*"})
public class Profile extends HttpServlet {

    Cluster cluster;
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("If you're seeing this, it's fucked.");
        }
    }
    
    // <editor-fold defaultstate="collapsed" desc="This method has since been deprecated, but I'm leaving it here for prosperity's sake.">
    //Method to return the most recent image the user has uploaded
    private void getMostRecentPic(String User, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        try
        { 
        PicModel tm = new PicModel();
        tm.setCluster(cluster);
 
        //The most recent picture is at the top of the linked list that is returned when getPicsForUser is called
        java.util.LinkedList<Pic> lsPics = tm.getPicsForUser(User);
         
        System.out.println("PICS IS: " + lsPics);
        
        //System.out.println("Yo nigga it's " + lsPics.size());
        
        if(lsPics!=null){        
            //So just take the first picture of the list from that
            Pic mostRecentPic = lsPics.getFirst();
            //And set it as the attribute
            request.setAttribute("mostRecentPic", mostRecentPic);
            
        }
        }
           
            catch(Exception yoManItsNull)
            {
                //Set attribute of message saying there are no pics
                request.setAttribute("noPics", "This user has not uploaded any pictures yet.");
            }

    }
    
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
    {
        //Initialise variables
        String username = "";
        String firstname = "";
        String lastname = "";
        String emailFinal = "";
        Set<String> email;
        
        //Get username - it's the third item in the array when the URL is split up
        String args[] = Convertors.SplitRequestPath(request);
        username = args[2];
        
        //Get first, last names and email pertaining to user
        Session session = cluster.connect("instalew");
        PreparedStatement ps = session.prepare("select first_name, last_name, email from userprofiles where login =?");
        ResultSet rs = null;
        BoundStatement boundStatement = new BoundStatement(ps);
        rs = session.execute( // this is where the query is executed
                boundStatement.bind( // here you are binding the 'boundStatement'
                        username));
        if (rs.isExhausted()) {
            System.out.println("Oops, something went wrong");

        } else {
            for (Row row : rs) {
                
                    //Set details
                    firstname = row.getString("first_name");
                    lastname = row.getString("last_name");
                    email = row.getSet("email", String.class);
                    
                    //Converting e-mail to string from set
                    String [] newEmail = email.toArray(new String [email.size()]);
                    emailFinal = Arrays.toString(newEmail);
                    emailFinal = emailFinal.substring(1, emailFinal.length()-1);
                }
            
            //Set attributes
            request.setAttribute("FirstName", firstname);
         request.setAttribute("LastName", lastname);
         request.setAttribute("email", emailFinal);
         request.setAttribute("username", username);
            }
         
        //Call method to get most recent picture
       // getMostRecentPic(username, request, response);  
        
        PicModel tm = new PicModel();
        tm.setCluster(cluster);
        
        //Set current user to be the string passed in, for use in the JSP
        
        //Get list of pictures
        java.util.LinkedList<Pic> lsPics = tm.getPicsForUser(username);
                request.setAttribute("Pics", lsPics);

        //Direct to user's profile
        RequestDispatcher rd = request.getRequestDispatcher("/userprofile.jsp");
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
    //For updating profile info
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
        
        //Get user details from form
        String username = lg.getUsername();
        String firstname = request.getParameter("first_name");
        String lastname = request.getParameter("last_name");
        String email = request.getParameter("email");
        
        //Emails are stored as a set here
        Set<String> emailSet = new HashSet<String>(Arrays.asList(email));
        
        //Create new user object
        User user = new User();
        user.setCluster(cluster);
        
        //Call method to update info
        user.updateUserInfo(username, firstname, lastname, emailSet);

        //Return user to profile page, which will show updated info
        response.sendRedirect("/InstaLew/Profile/" + lg.getUsername());

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

    @Override
    public void init(ServletConfig config) throws ServletException {
        // TODO Auto-generated method stub
        cluster = CassandraHosts.getCluster();
    }
}
