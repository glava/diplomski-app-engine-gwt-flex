package goran.com.server;

import goran.com.jdo.ToDoUser;

import java.io.IOException;

import javax.jdo.PersistenceManager;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		resp.setContentType("text/plain");
		
		Boolean loggedIn = false;
		String username = (String) req.getParameter("username");
		String password = (String) req.getParameter("password");
		HttpSession session = req.getSession();
		PersistenceManager pm = PMF.get().getPersistenceManager();
		
		ToDoUser newToDoUser = pm.getObjectById(ToDoUser.class, username);
		if (newToDoUser != null) {
			if (newToDoUser.getPassword().equals(password)) {
				loggedIn = true;
				session.setAttribute("user", newToDoUser);
			}
		}
		if (req.getSession().getAttribute("user") != null) {
			resp.getWriter().println("success");
		} else {
			resp.getWriter().println("failure");
		}
	}
}
