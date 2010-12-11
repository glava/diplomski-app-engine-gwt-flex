package events
{
	import flash.events.Event;
	
	import model.ToDo;
	import model.ToDoLaUser;
	
	public class LoginEvent extends Event
	{
		public static const LOGIN_USER:String = "Log.In.User";
		public static const LOGIN_USER_FAILED:String = "Log.In.User.Failed";
		
		
		public var toDoUser:ToDoLaUser;
		public function LoginEvent(type:String,toDoUser:ToDoLaUser, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			this.toDoUser = toDoUser;
			super(type, bubbles, cancelable);
		}
	}
}