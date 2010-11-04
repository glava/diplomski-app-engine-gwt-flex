package goran.com.server;

import goran.com.jdo.ToDoUser;

import java.io.IOException;

import javax.jdo.PersistenceManager;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ToDoUserService extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {

		HttpSession session = req.getSession(true);
		
		ToDoUser user = (ToDoUser) session.getAttribute("user");

		resp.setContentType("text/plain");
		if (user!=null) {
			resp.getWriter().println("user je tu");
		} else {
			resp.getWriter().println("user nije tu");
		}
	}
}
