package goran.com.server;

import java.util.ArrayList;

import goran.com.jdo.Tag;
import goran.com.jdo.ToDo;
import goran.com.jdo.ToDoUser;
import goran.com.model.ToDoUserVo;
import goran.com.model.ToDoVo;

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
			if (newToDoUser.password.equals(password)) {
				loggedIn = true;
				return newToDoUser;
			}
		}
		return null;
	}
	
	public boolean createToDo(ToDoUserVo toDoUserVo,ToDoVo toDoVo)
	{
		PersistenceManager pm = PMF.get().getPersistenceManager();
		return true;
	}
	
}
