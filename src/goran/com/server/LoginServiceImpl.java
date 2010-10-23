package goran.com.server;

import javax.jdo.PersistenceManager;

import goran.com.client.LoginService;
import goran.com.jdo.ToDoUser;

import com.google.appengine.api.datastore.KeyFactory;
import com.google.gwt.user.server.rpc.RemoteServiceServlet;

public class LoginServiceImpl extends RemoteServiceServlet implements
		LoginService {

	@Override
	public Boolean login(String username, String password)
			throws IllegalArgumentException {
		// TODO Auto-generated method stub
	
		Boolean loggedIn = false;
		PersistenceManager pm = PMF.get().getPersistenceManager();

		ToDoUser newToDoUser = pm.getObjectById(ToDoUser.class, username);
		if (newToDoUser != null) {
			if (newToDoUser.getPassword().equals(password)) {
				loggedIn = true;
			}
		}
//		ToDoUser toDoUser = new ToDoUser(username, password);
//		toDoUser.setKey(KeyFactory.createKey(ToDoUser.class.getSimpleName(),
//				toDoUser.getUsername()));
	
		
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
