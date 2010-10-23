package goran.com.client;

import goran.com.jdo.ToDoUser;

import com.google.gwt.user.client.rpc.RemoteService;
import com.google.gwt.user.client.rpc.RemoteServiceRelativePath;

@RemoteServiceRelativePath("login")
public interface LoginService extends RemoteService{
	
	Boolean login(String username, String password)  throws IllegalArgumentException;
	
		
}
