package goran.com.server;

import goran.com.jdo.ToDoUser;

import java.io.IOException;

import javax.jdo.PersistenceManager;
import javax.persistence.Persistence;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.KeyFactory;

public class saveUser extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {

		String username = (String) req.getParameter("username");
		String password = (String) req.getParameter("password");
		Boolean loggedIn = false;
		PersistenceManager pm = PMF.get().getPersistenceManager();

		ToDoUser newToDoUser = pm.getObjectById(ToDoUser.class, username);
		if (newToDoUser != null) {
			if (newToDoUser.getPassword().equals(password)) {
				loggedIn = true;
			}
		}
		ToDoUser toDoUser = new ToDoUser(username, password);
		toDoUser.setKey(KeyFactory.createKey(ToDoUser.class.getSimpleName(),
				toDoUser.getUsername()));
		try {
			pm.makePersistent(toDoUser);

		} finally {
			pm.close();
		}
		resp.setContentType("text/plain");
		if (loggedIn) {
			resp.getWriter().println("welcome");
		} else {
			resp.getWriter().println("register");
		}
	}
}
