package goran.com.jdo;

import java.util.ArrayList;
import java.util.List;

import javax.jdo.annotations.Element;
import javax.jdo.annotations.IdGeneratorStrategy;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

import com.google.appengine.api.datastore.Key;

@PersistenceCapable
public class ToDoUser {

	@PrimaryKey
	@Persistent(valueStrategy = IdGeneratorStrategy.IDENTITY)
	private Key key;

	@Persistent
	public String username;
	@Persistent
	public String password;
	
	@Persistent(mappedBy = "user",defaultFetchGroup = "true")
    @Element(dependent = "true")
	public List<ToDo> toDoTasks = new ArrayList<ToDo>();;

//	@Persistent(mappedBy = "user",defaultFetchGroup = "true")
//    @Element(dependent = "true")
//	public List<Tag> tags = new ArrayList<Tag>();

	public void setKey(Key key) {
		this.key = key;
	}

	public Key getKey() {
		return key;
	}

}