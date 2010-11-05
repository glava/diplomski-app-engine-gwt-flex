package goran.com.server;

import goran.com.jdo.ToDo;
import goran.com.jdo.ToDoUser;

import javax.jdo.PersistenceManager;

public class Data {
	public void createData(String key, String value) {
		
		if(true){
			return;
		}
	}
	
	public ToDoUser login(String username, String password){

		Boolean loggedIn = false;
		PersistenceManager pm = PMF.get().getPersistenceManager();
		
		ToDoUser newToDoUser = pm.getObjectById(ToDoUser.class, username);
		if (newToDoUser != null) {
			if (newToDoUser.getPassword().equals(password)) {
				loggedIn = true;
				return newToDoUser;
			}
		}
		return null;
	}
	
	public boolean createToDo(ToDoUser toDoUser)
	{
		PersistenceManager pm = PMF.get().getPersistenceManager();
		ToDoUser logedInUser = pm.getObjectById(ToDoUser.class, toDoUser.getUsername());
		logedInUser.setToDoTasks(toDoUser.getToDoTasks());
		pm.makePersistent(logedInUser);
		return true;
	}
	
}
