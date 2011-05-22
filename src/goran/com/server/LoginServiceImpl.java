package goran.com.server;

import goran.com.client.LoginService;
import goran.com.jdo.ToDoUser;

import javax.jdo.JDOObjectNotFoundException;
import javax.jdo.PersistenceManager;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.google.appengine.api.datastore.KeyFactory;
import com.google.gwt.user.server.rpc.RemoteServiceServlet;
import com.google.gwt.user.server.rpc.UnexpectedException;

public class LoginServiceImpl extends RemoteServiceServlet implements
		LoginService {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	public Boolean checkLoginStatus() {
		HttpServletRequest httpServletRequest = this.getThreadLocalRequest();

		if (httpServletRequest.getUserPrincipal() == null) {
			return false;

		} else {
			return true;
		}
	}

	@Override
	public Boolean register(String username, String password) {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		ToDoUser newToDoUser = fetchUser(username, pm);
		Boolean result = false;
		if (newToDoUser == null) {
//			creates new ToDoUser and stores it
			newToDoUser = new ToDoUser();
			newToDoUser.password = password;
			newToDoUser.username = username;
			newToDoUser.setKey(KeyFactory.createKey(ToDoUser.class
					.getSimpleName(), newToDoUser.username));

			pm.currentTransaction().begin();
			try {
				pm.makePersistent(newToDoUser);
				pm.currentTransaction().commit();
			} finally {
				if (pm.currentTransaction().isActive()) {
					pm.currentTransaction().rollback();
				}
			}
			result = true;
		}
		return result;
	}

	public Boolean login(String username, String password)
			throws IllegalArgumentException {

		// fetch httpReqest and session
		HttpServletRequest httpServletRequest = this.getThreadLocalRequest();
		HttpSession session = httpServletRequest.getSession();

		Boolean loggedIn = false;
		PersistenceManager pm = PMF.get().getPersistenceManager();

		ToDoUser newToDoUser = fetchUser(username, pm);

		if (newToDoUser != null) {
			if (newToDoUser.password.equals(password)) {
				loggedIn = true;
//				sets session object
				session.setAttribute("user", newToDoUser);
			}
		}

		return loggedIn;
	}

	public ToDoUser fetchUser(String username, PersistenceManager pm) {
		ToDoUser newToDoUser;
		
		try {
			newToDoUser = pm.getObjectById(ToDoUser.class, username);
		} catch (Exception e) {
//			didint find it
			newToDoUser = null;
		}
	
		return newToDoUser;
	}

}
