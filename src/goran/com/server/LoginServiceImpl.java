package goran.com.server;

import javax.jdo.PersistenceManager;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.catalina.HttpRequest;

import goran.com.client.LoginService;
import goran.com.jdo.ToDoUser;

import com.google.appengine.api.datastore.KeyFactory;
import com.google.gwt.user.server.rpc.RemoteServiceServlet;

public class LoginServiceImpl extends RemoteServiceServlet implements
		LoginService {

	@Override
	public Boolean login(String username, String password)
			throws IllegalArgumentException {
		
		//fetch httpReqest and session
		HttpServletRequest httpServletRequest = this.getThreadLocalRequest();
		HttpSession session = httpServletRequest.getSession();
		
		Boolean loggedIn = false;
		PersistenceManager pm = PMF.get().getPersistenceManager();

		ToDoUser newToDoUser = pm.getObjectById(ToDoUser.class, username);
		if (newToDoUser != null) {
			if (newToDoUser.getPassword().equals(password)) {
				loggedIn = true;
				session.setAttribute("user", newToDoUser);
			}
		}
	
		
		if(loggedIn)
		{
			return loggedIn;
		}
		else
		{
			throw( new IllegalArgumentException());
		}
		
	}

}
